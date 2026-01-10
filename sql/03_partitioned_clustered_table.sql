--Creates partitioned + clustered taable to show further improvements
CREATE TABLE google_trends_analysis.trends_partitioned_clustered
  PARTITION BY refresh_date
  CLUSTER BY country_name
  AS SELECT * FROM 'bigquery-public-data.google_trends.international_top_terms' WHERE refresh_date >= DATE '2024-01-01' LIMIT 5000;
