-- Query on unpartitioned table

SELECT country_name, COUNT(*) AS term_count
FROM google_trends_analysis.trends_unpartitioned
WHERE refresh_date >= '2024-01-15'
GROUP BY country_name;


-- Query on partitioned table

SELECT country_name, COUNT(*) AS term_count
FROM google_trends_analysis.trends_partitioned
WHERE refresh_date >= '2024-01-15'
GROUP BY country_name;


-- Query-1 on partitioned and clustered table

SELECT * FROM google_trends_analysis.trends_partitioned_clustered 
  WHERE refresh_date = '2024-01-03' AND country_name = 'India';


-- Query-2 on partitioned and clustered table

SELECT country_name, COUNT(*) AS term_count FROM my_dataset.trends_partitioned_clustered 
  WHERE refresh_date >= '2024-01-15' AND country_name = 'India' 
  GROUP BY country_name;
