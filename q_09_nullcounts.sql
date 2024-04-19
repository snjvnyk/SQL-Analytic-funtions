SELECT countif(zipcode IS NULL) as null_zip,
  countif(gender IS NULL) as null_gender, 
  countif(minimum_age IS NULL) as null_max, 
  countif(maximum_age IS NULL) as null_min,
  countif(population IS NULL) as null_population

FROM bigquery-public-data.census_bureau_usa.population_by_zip_2010

