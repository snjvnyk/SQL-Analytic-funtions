SELECT zipcode, gender, SUM(population) AS total_population
FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
GROUP BY zipcode, gender
ORDER BY SUM(population) DESC
LIMIT 2;
