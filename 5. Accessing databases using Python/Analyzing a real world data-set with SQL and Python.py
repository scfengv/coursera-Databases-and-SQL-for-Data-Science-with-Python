# DATEBASE: CHICAGO_SOCIOECONOMIC_DATA

# This dataset contains a selection of six socioeconomic indicators of public health significance and a “hardship index,” 
# for each Chicago community area, for the years 2008 – 2012
# Scores on the hardship index can range from 1 to 100, with a higher index number representing a greater level of hardship

# Community Area Number (ca): 
#   Used to uniquely identify each row of the dataset

# Community Area Name (community_area_name): 
#   The name of the region in the city of Chicago

# Percent of Housing Crowded (percent_of_housing_crowded): 
#   Percent of occupied housing units with more than one person per room

# Percent Households Below Poverty (percent_households_below_poverty): 
#   Percent of households living below the federal poverty line

# Percent Aged 16+ Unemployed (percent_aged_16_unemployed): 
#   Percent of persons over the age of 16 years that are unemployed

# Percent Aged 25+ without High School Diploma (percent_aged_25_without_high_school_diploma): 
#   Percent of persons over the age of 25 years without a high school education

# Percent Aged Under 18 or Over 64:
#   Percent of population under 18 or over 64 years of age (percent_aged_under_18_or_over_64): (ie. dependents)

# Per Capita Income (per_capita_income_): 
#   Community Area per capita income is estimated as the sum of tract-level aggragate incomes divided by the total population

# Hardship Index (hardship_index): 
#   Score that incorporates each of the six selected socioeconomic indicators


# Connect to the database #

# load the SQL extension and establish a connection with the database
%load_ext sql
%sql ibm_db_sa://smt18684:Lsb8ouTylZNDetDW@ba99a9e6-d59e-4883-8fc0-d6a8c9f7a08f.c1ogj3sd0tgtu0lqde00.databases.appdomain.cloud:31321/bludb?security=SSL

# Store the dataset in a Table #
import pandas
chicago_socioeconomic_data = pandas.read_csv('https://data.cityofchicago.org/resource/jcxq-k9xf.csv')
%sql PERSIST chicago_socioeconomic_data

# Problem 1
# How many rows are in the dataset?

%sql SELECT COUNT ( * ) 
FROM chicago_socioeconomic_data;

# Problem 2
# How many community areas in Chicago have a hardship index greater than 50.

%sql SELECT COUNT ( * ) 
FROM chicago_socioeconomic_data 
WHERE HARDSHIP_INDEX > 50;

# Problem 3
# What is the maximum value of hardship index in this dataset?

%sql SELECT MAX ( HARDSHIP_INDEX ) 
FROM chicago_socioeconomic_data;

# Problem 4
# Which community area which has the highest hardship index?

%sql SELECT COMMUNITY_AREA_NAME 
FROM chicago_socioeconomic_data 
WHERE HARDSHIP_INDEX = 
( SELECT MAX(HARDSHIP_INDEX) FROM chicago_socioeconomic_data);

# Problem 5
# Which Chicago community areas have per-capita incomes greater than $60,000

%sql SELECT COMMUNITY_AREA_NAME 
FROM chicago_socioeconomic_data 
WHERE PER_CAPITA_INCOME_ > 60000;

# Problem 6
# Create a scatter plot using the variables per_capita_income_ and hardship_index. Explain the correlation between the two variables

import matplotlib.pyplot as plt
%matplotlib inline
import seaborn as sns

income_vs_percent_households_below_poverty = 
%sql SELECT per_capita_income_, percent_households_below_poverty 
FROM chicago_socioeconomic_data;
plot = sns.jointplot ( x = 'per_capita_income_', y='percent_households_below_poverty', data=income_vs_percent_households_below_poverty.DataFrame() )