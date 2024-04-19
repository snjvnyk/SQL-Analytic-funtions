WITH age_group_population AS (
    SELECT 
        gender,
        MIN(minimum_age) AS min_age,
        MAX(maximum_age) AS max_age,
        SUM(population) AS head_count,
        RANK() OVER (PARTITION BY gender ORDER BY SUM(population) DESC) AS age_group_rank
    FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
    WHERE minimum_age IS NOT NULL AND maximum_age IS NOT NULL
    GROUP BY gender, maximum_age
)
SELECT gender, min_age, max_age, head_count
FROM age_group_population
WHERE age_group_rank <= 5;
