WITH male_population_by_age AS (
    SELECT
        MAX(maximum_age) AS max_age,
        SUM(population) AS male_population,
        RANK() OVER (ORDER BY SUM(population) DESC) AS population_rank
    FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
    WHERE zipcode = '94085' AND gender = 'male'
    GROUP BY maximum_age
)
SELECT max_age, male_population
FROM male_population_by_age
WHERE population_rank = 1;
