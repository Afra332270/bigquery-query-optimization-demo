# bigquery-query-optimization-demo

## Introduction

The goal of this project is to demonstrate how BigQuery optimization techniques partitioning and clustering can help reduce query costs and improve performance when compared to querying regular, unpartitioned tables. I used the public dataset 'bigquery-public-data.google_trends.international_top_terms' for this experiment.

## Experiment Overview

I first created a small unpartitioned table by copying only recent data from the dataset. Then I created a small partitioned table using the same recent data as before, which I partitioned by 'refresh_date'. After this, I ran the same query on both tables and compared computational costs between the two such as Elapsed Time, Slot Time consumed, and Byted shuffled. Then I created another table which was both partitioned and clustered using recent data from the dataset. Then I ran two more queries to show how clustering can further improve perfomance.
A subset of the dataset was used to stay within free-tier storage limits.
