SELECT zipcode, SUM(population) AS total_female_population
FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
WHERE gender = 'female'
GROUP BY zipcode
ORDER BY SUM(population) DESC
LIMIT 5;
