SELECT gender, MIN(minimum_age) AS min_age, MAX(maximum_age) AS max_age, SUM(population) AS head_count
FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
GROUP BY gender
ORDER BY SUM(population) DESC
LIMIT 5;
