-- DATASET: Chicago Public Schools - Progress Report Cards (2011-2012)
-- https://cf-courses-data.s3.us.cloud-object-storage.appdomain.cloud/IBMDeveloperSkillsNetwork-DB0201EN-SkillsNetwork/labs/FinalModule_Coursera_V5/data/ChicagoPublicSchools.csv

-- Query the database system catalog to retrieve table metadata
-- metadata: the data that describe data
-- https://ithelp.ithome.com.tw/articles/10237545

-- %sql aka sql magic, which can only be use in jupyter nb

%%sql 
SELECT TABSCHEMA, TABNAME, CREATE_TIME \
FROM SYSCAT.TABLES \
WHERE TABSCHEMA='DB2-USERNAME' ;
-- SYSCAT.TABLE which means "system catalog table", contains the table metatable


-- Retrieve the the list of columns in SCHOOLS table and their column type (datatype) and length

%%sql 
SELECT COLNAME, TYPENAME, LENGTH \
FROM SYSCAT.COLUMN \
WHERE TABNAME = 'SCHOOLS';

-- Problem 1
-- How many Elementary Schools are in the dataset

%%sql 
SELECT COUNT ( * ) \
FROM SCHOOLS \ 
WHERE "Elementary, Middle, or High School" = 'ES' ;
-- column name contains MiXeD-cAsE, which be quoted with "DOUBLE QUOTEs" 


-- Problem 2
-- What is the highest Safety Score

%%sql 
SELECT MAX ( Safety_Score ) AS MAX_SAFETY_SCORE \
FROM SCHOOLS ;
-- Return a number (score) as SELECT MAX ( column ),  if the school is asking, which is preset below, sub-query is needed


-- Problem 3
-- Which schools have highest Safety Score

%%sql 
SELECT * FROM SCHOOLS \
WHERE SAFETY_SCORE = ( SELECT MAX ( SAFETY_SCORE ) FROM SCHOOLS ) ;

-- Problem 4
-- What are the top 10 schools with the highest "Average Student Attendance"

%%sql 
SELECT Name_of_School, Average_Student_Attendance \
FROM SCHOOLS \
ORDER BY AVERAGE_STUDENT_ATTENDANCE \
DESC NULLS LAST LIMIT 10 ;
-- The ORDER BY clause can include the NULLS FIRST keywords or the NULLS LAST
-- NULLS LAST: NONE value at the last
-- NULLS FIRST: NONE valus at the top
-- https://www.ibm.com/docs/en/informix-servers/12.10?topic=clause-ascending-descending-orders


-- Problem 5
-- Retrieve the list of 5 Schools with the lowest Average Student Attendance sorted in ascending order based on attendance

%%sql
SELECT Name_of_School,Average_Student_Attendance \
FROM SCHOOLS \
ORDER BY AVERAGE_STUDENT_ATTENDANCE \
ASC NULLS LAST LIMIT 10 ;

-- Problem 6
-- Now remove the '%' sign from the above result set for Average Student Attendance column

%%sql
SELECT Name_of_School, REPLACE ( Average_Student_Attendance, '%','') \
FROM SCHOOLS \
ORDER BY AVERAGE_STUDENT_ATTENDANCE \
ASC NULLS LAST LIMIT 10 ;
-- REPLACE ( the column which have sth to be replaced , 'the thing been replaced', 'by what' )
-- https://www.ibm.com/docs/en/db2/10.5?topic=functions-replace
-- In the case, the " % " sign in Average_Student_Attendance had been replaced by nothing " " 


-- Problem 7
-- Which Schools have Average Student Attendance lower than 70%?

%%sql 
SELECT Name_of_School,Average_Student_Attendance \
FROM SCHOOLS \
WHERE DECIMAL ( REPLACE ( Average_Student_Attendance, '%','') ) < 70 \
ORDER BY Average_Student_Attendance ;
-- The column type of " Average_Student_Attendance " was a VARCHAR, which can be seen at line 19 ~ 22
-- So you cannot use it as is in the where clause for a numeric comparison
-- https://learn.microsoft.com/zh-tw/dotnet/visual-basic/language-reference/data-types/decimal-data-type


-- Problem 8
-- Get the total College Enrollment for each Community Area

%%sql 
SELECT community_area_name, SUM ( college_enrollment ) AS TOTAL_ENROLLMENT \
FROM SCHOOLS \
GROUP BY community_area_name ;

-- Problem 9
-- Get the 5 Community Areas with the least total College Enrollment sorted in ascending order

%%sql 
SELECT community_area_name, SUM ( college_enrollment ) \
FROM SCHOOLS \
GROUP BY community_area_name \
ORDER BY SUM(college_enrollment) LIMIT 5 ;

-- Problem 10
-- List 5 schools with lowest safety score

%%sql 
SELECT name_of_school, SAFETY_SCORE \
FROM SCHOOLS \
ORDER BY SAFETY_SCORE LIMIT 5 ;

-- Problem 11
-- Get the hardship index for the community area which has College Enrollment of 4368

%%sql 
SELECT HARDSHIP_INDEX \
FROM chicago_socioeconomic_data CD, SCHOOLS SC \
WHERE CD.ca = SC.community_area_number AND college_enrollment = 4368 ;
-- Link to another database which been used in Analyzing a real world data-set with SQL and Python.py

-- Problem 12
-- Get the hardship index for the community area which has the school with the highest enrollment

%%sql 
SELECT ca, community_area_name, hardship_index from chicago_socioeconomic_data \
WHERE ca IN \
( SELECT community_area_number FROM schools ORDER BY college_enrollment DESC LIMIT 1 ) ;