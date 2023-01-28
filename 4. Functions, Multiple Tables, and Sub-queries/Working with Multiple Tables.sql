-- DATABASE: HR Database

-- Retrieve only the EMPLOYEES records that correspond to jobs in the JOBS table
SELECT * 
FROM EMPLOYEES 
WHERE JOB_ID 
IN (SELECT JOB_IDENT FROM JOBS);

-- Retrieve only the list of employees whose JOB_TITLE is Jr. Designe
SELECT *
FROM EMPLOYEES
WHERE JOB_ID 
IN (SELECT JOB_IDENT FROM JOBS WHERE JOB_TITLE = 'Jr. Designer');

-- Exercise 1: Accessing Multiple Tables with Sub-Queries

-- Retrieve JOB information and who earn more than $70,000
SELECT *
FROM JOBS
WHERE JOB_IDENT 
IN (SELECT JOB_ID FROM EMPLOYEES WHERE SALARY > 70000);

-- Retrieve JOB information and whose birth year is after 1976
SELECT *
FROM JOBS
WHERE JOB_IDENT 
IN (SELECT JOB_ID FROM EMPLOYEES WHERE YEAR(B_DATE) > 1976 );

-- Retrieve JOB information for female employees whose birth year is after 1976
SELECT *
FROM JOBS
WHERE JOB_IDENT 
IN (SELECT JOB_ID FROM EMPLOYEES WHERE SEX = 'F' AND YEAR(B_DATE) > 1976 );

-- Exercise 2: Accessing Multiple Tables with Implicit Joins

-- Retrieve only the EMPLOYEES records that correspond to jobs in the JOBS table
SELECT *
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT

-- Redo the previous query, but retrieve only the Employee ID, Employee Name and Job Title
SELECT E.EMP_ID, E.F_NAME, E.L_NAME, J.JOB_TITLE
FROM EMPLOYEES E, JOBS J
WHERE E.JOB_ID = J.JOB_IDENT
