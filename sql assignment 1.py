import pandas as pd
from google.cloud import bigquery

# Initialize BigQuery client
client = bigquery.Client()

# Function to execute SQL queries and return results as DataFrame
def run_query(query):
    query_job = client.query(query)
    results = query_job.result()
    df = results.to_dataframe()
    return df

# 1. Total population in zipcode 94085 (Sunnyvale CA)
def get_total_population():
    query = """
    SELECT SUM(population) AS total_population
    FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
    WHERE zipcode = '94085'
    """
    return run_query(query)

# 2. Number of Male and Female head count in zipcode 94085 (Sunnyvale CA)
def get_gender_head_count():
    query = """
    SELECT gender, SUM(population) AS head_count
    FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
    WHERE zipcode = '94085'
    GROUP BY gender
    """
    return run_query(query)

# 3. Age group with max headcount for both male and female genders combined (zipcode 94085 (Sunnyvale CA))
def get_max_age_group_headcount():
    query = """
    WITH AgeRanges AS (
      SELECT
        gender,
        CASE
          WHEN minimum_age BETWEEN 0 AND 17 THEN '0-17'
          WHEN minimum_age BETWEEN 18 AND 34 THEN '18-34'
          WHEN minimum_age BETWEEN 35 AND 49 THEN '35-49'
          WHEN minimum_age BETWEEN 50 AND 64 THEN '50-64'
          WHEN minimum_age >= 65 THEN '65+'
        END AS age_range,
        SUM(population) AS head_count
      FROM `bigquery-public-data.census_bureau_usa.population_by_zip_2010`
      WHERE zipcode = '94085'
      GROUP BY gender, age_range
    )
    SELECT gender, age_range, head_count
    FROM AgeRanges
    ORDER BY head_count DESC
    LIMIT 1
    """
    return run_query(query)

# Define functions for other queries in a similar manner...

if __name__ == "__main__":
    # Example usage:
    total_population = get_total_population()
    print("Total population in 94085:", total_population)

    gender_head_count = get_gender_head_count()
    print("Gender head count in 94085:", gender_head_count)

    max_age_group_headcount = get_max_age_group_headcount()
    print("Max age group headcount in 94085:", max_age_group_headcount)
