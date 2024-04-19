WITH female_population_by_zip AS (
    SELECT zipcode, SUM(population) AS total_female_population,
           RANK() OVER (ORDER BY SUM(population) DESC) AS zipcode_rank
    FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
    WHERE gender = 'female'
    GROUP BY zipcode
)

SELECT zipcode, total_female_population
FROM female_population_by_zip
WHERE zipcode_rank <= 5;
