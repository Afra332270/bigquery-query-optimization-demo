# bigquery-query-optimization-demo

## Introduction

The goal of this project is to demonstrate how BigQuery optimization techniques partitioning and clustering can help reduce query costs and improve performance when compared to querying regular, unpartitioned tables. I used the public dataset 'bigquery-public-data.google_trends.international_top_terms' for this experiment.

## Experiment Overview

I first created a small unpartitioned table by copying only recent data from the dataset. Then I created a small partitioned table using the same recent data as before, which I partitioned by 'refresh_date'. After this, I ran the same query on both tables and compared computational costs between the two such as Elapsed Time, Slot Time consumed, and Byted shuffled. Then I created another table which was both partitioned and clustered using recent data from the dataset. Then I ran two more queries to show how clustering can further improve perfomance.
A subset of the dataset was used to stay within free-tier storage limits.

## Key Concepts

Partitioning splits data into partitions based on: - Date/Timestamp
                                                   - Integer range
                                                   - Ingestion time

This helps reduce query costs since BigQuery only has to scan relevant data instead of the whole dataset. In an unpartitioned table however, any query will cause to scan the whole dataset since there are no partitions. So in this experiment, I partitioned the dataset by refresh_date, which means data with the same dates will be grouped together physically. However, when we query the table, we still need to use a partition filter (on the partition column), to prevent full table scans. This helps reduce costs significantly.

Clustering further groups the data inside the partitions based on some condition, to help further improve costs. For example, when we cluster by a column such as 'country_name', BigQuery physically sorts the data by country_name, so that rows with the same country are grouped together.

Both partitioning and clustering happen at storage time, where data is physically organized on disk.


