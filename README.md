# bigquery-cost-optimization-demo

## Introduction

The goal of this project is to demonstrate how BigQuery optimization techniques partitioning and clustering can help reduce query costs and improve performance when compared to querying regular, unpartitioned tables. For this experiment, I used the 'bigquery-public-data.google_trends.international_top_terms' from BigQuery Public Datasets.


## Experiment Overview

I first created a small unpartitioned table by copying only recent data from the dataset. Then I created a small partitioned table using the same recent data as before, which I partitioned by 'refresh_date'. After this, I ran the same query on both tables and compared computational costs between the two such as Elapsed Time, Slot Time consumed, and Bytes shuffled. Then I created another table which was both partitioned and clustered using recent data from the dataset. Then I ran two more queries to show how clustering can further improve perfomance.
A subset of the dataset was used to stay within free-tier storage limits.

## Key Concepts

-Partitioning splits data into partitions based on: 
   - Date/Timestamp
   - Integer range
   - Ingestion time

This helps reduce query costs since BigQuery only has to scan relevant data instead of the whole dataset. In an unpartitioned table however, any query will cause to scan the whole dataset since there are no partitions. So in this experiment, I partitioned the dataset by refresh_date, which means data with the same dates will be grouped together physically. However, when we query the table, we still need to use a partition filter (on the partition column), to prevent full table scans. This helps reduce costs significantly.

Clustering further groups the data inside the partitions based on some condition, to help further improve costs. For example, when we cluster by a column such as 'country_name', BigQuery physically sorts the data by country_name, so that rows with the same country are grouped together.

Both partitioning and clustering happen at storage time, where data is physically organized on disk.

Elapsed Time refers to the actual time (wall-clock time) taken by query to execute from start to finish. It includes the time taken by BigQuery to plan the query, wait for available slots, execute the query, and move data. A lower elapsed time may indicate a faster query.

Slot Time Consumed refers to the total slot time taken, that is the number of slots used and the duration thet were used. For example, if 100 slots were used for 2 seconds, the slot time will be 200 slot-seconds. Faster queries can still be more expensive if they use many slots. BigQuery dynamically assigns slots to queries and slots help execute parts of a query in parallel.

Bytes Shuffled refers to the amount of data moved across workers during execution. Shuffling mainly occurs during operations such as JOINs, GROUP BY, ORDER BY, window functions, etc. A worker is an actual execution process. A worker can process multiple slots. These workers contain pieces of data which they assemble together by communicating with each other and moving data amongst each other. This causes bytes to be shuffled. Moving data between workers can be expensive and contribute a lot to slower queries. 

Slots contribute to parallelism while workers help with exchanging data.


## Results and Observations

After creating both the partitioned and unpartitioned tables, we can see that the slot tie consumed is lower for the partitioned table than the unpartitioned table.
After running the same query on both the unpartitioned and partitioned tables, we can see that both the elapsed time and slot time consumed was lower for the partitioned table than the unpartitioned table.

For the partitioned and clustered table, I ran two queries. The first query gave a much lower slot time compared to previous queries, since clustering can further reduce the number of data scanned. For the second query, both the slot time and elapsed time is higher. This is because the partition filter requires to check multiple partitions and aggregation (due to GROUP BY and COUNT(*)) results in shuffling. However, even though the second query increases costs, the costs would have been much higher without partitioning and clustering.


