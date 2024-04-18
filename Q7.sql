SELECT MAX(maximum_age) AS max_age, SUM(population) AS female_population
FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
WHERE zipcode = '94085' AND gender = 'female'
GROUP BY maximum_age
ORDER BY SUM(population) DESC
LIMIT 1;
