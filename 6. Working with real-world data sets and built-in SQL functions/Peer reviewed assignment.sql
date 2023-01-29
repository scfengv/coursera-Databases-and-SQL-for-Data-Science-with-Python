-- DATABASE: Socioeconomic Indicators in Chicago name as CENSUS
-- https://data.cityofchicago.org/Health-Human-Services/Census-Data-Selected-socioeconomic-indicators-in-C/kn9c-c2s2
--           Chicago Public Schools name as SCHOOLS
-- https://data.cityofchicago.org/Education/Chicago-Public-Schools-Progress-Report-Cards-2011-/9xs2-f89t
--           Chicago Crime Data name as CRIME
-- https://data.cityofchicago.org/Public-Safety/Crimes-2001-to-present/ijzp-q8t2


-- Problem 1
-- Find the total number of crimes recorded in the CRIME table

%%sql
SELECT COUNT ( * ) AS NUM_OF_CRIMES 
FROM CRIME ;

-- Problem 2
-- List community areas with per capita income less than 11000

%%sql
SELECT COMMUNITY_AREA_NAME, PER_CAPITA_INCOME 
FROM CENSUS 
WHERE PER_CAPITA_INCOME < 11000 ; 

-- Problem 3
-- List all case numbers for crimes involving minors

%%sql
SELECT CASE_NUMBER, DESCRIPTION 
FROM CRIME 
WHERE DESCRIPTION LIKE '%MINOR%' ;

-- Problem 4
-- List all kidnapping crimes involving a child

%%sql
SELECT CASE_NUMBER,PRIMARY_TYPE, DESCRIPTION 
FROM CRIME 
WHERE PRIMARY_TYPE = 'KIDNAPPING' AND DESCRIPTION LIKE 'CHILD%' ;

-- Problem 5
-- What kinds of crimes were recorded at schools

%%sql
SELECT DISTINCT ( PRIMARY_TYPE ) ,LOCATION_DESCRIPTION 
FROM CRIME 
WHERE LOCATION_DESCRIPTION LIKE 'SCHOOL%' ;

-- Problem 6
-- List the average safety score for each type of school

%%sql
SELECT " Elementary, Middle, or High School ", AVG ( SAFETY_SCORE ) AS AVG_SAFETY_SCORE 
FROM SCHOOLS 
GROUP BY " Elementary, Middle, or High School " ;

-- Problem 7
-- List 5 community areas with highest % of households below poverty line

%%sql
SELECT COMMUNITY_AREA_NAME, PERCENT_HOUSEHOLDS_BELOW_POVERTY 
FROM CENSUS 
ORDER BY PERCENT_HOUSEHOLDS_BELOW_POVERTY DESC LIMIT 5 ;

-- Problem 8
-- Which community area is most crime prone?

%%sql
SELECT COMMUNITY_AREA_NUMBER ,COUNT ( * ) AS CRIME_NUM 
FROM CRIME 
GROUP BY COMMUNITY_AREA_NUMBER 
ORDER BY CRIME_NUM DESC LIMIT 1 ;

SELECT COMMUNITY_AREA_NAME 
FROM CENSUS 
WHERE COMMUNITY_AREA_NUMBER = 25 ;

-- Problem 9
-- Use a sub-query to find the name of the community area with highest hardship index

%%sql
SELECT COMMUNITY_AREA_NAME 
FROM CENSUS 
WHERE HARDSHIP_INDEX = ( SELECT MAX ( HARDSHIP_INDEX ) FROM CENSUS ) ;

-- Problem 10
-- Use a sub-query to determine the Community Area Name with most number of crimes

%%sql
SELECT COMMUNITY_AREA_NAME
FROM CENSUS
WHERE COMMUNITY_AREA_NUMBER = ( SELECT COMMUNITY_AREA_NUMBER
                                FROM CRIME GROUP BY COMMUNITY_AREA_NUMBER ORDER BY COUNT(*) DESC LIMIT 1 )