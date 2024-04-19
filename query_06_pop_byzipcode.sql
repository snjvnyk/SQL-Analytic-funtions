WITH zip_population AS (
    SELECT 
        zipcode,
        gender,
        SUM(population) AS total_population,
        RANK() OVER (PARTITION BY gender ORDER BY SUM(population) DESC) AS population_rank
    FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
    GROUP BY zipcode, gender
)
SELECT zipcode, gender, total_population
FROM zip_population
WHERE population_rank = 1;
