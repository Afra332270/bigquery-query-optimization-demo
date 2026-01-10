-- Creates a partitioned table partitioned by refresh_date
CREATE TABLE google_trends_analysis.trends_partitioned
  PARTITION BY refresh_date
  AS SELECT refresh_date, country_name, term, score 
  FROM 'bigquery-public-data.google_trends.international_top_terms' WHERE refresh_date BETWEEN '2024-01-01' AND '2024-01-31';
