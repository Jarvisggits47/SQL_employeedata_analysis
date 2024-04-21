CREATE DATABASE IF NOT exists simplelearn;
use simplelearn;
SELECT *FROM
    empattrition;
-- Q1: Write an skill query to find the details of employees under attrition having five +year experience
--  in between the age group 27 -35
SELECT *
FROM
    empattrition
WHERE
    ï»¿Age BETWEEN 27 AND 35
        AND TotalWorkingYears > 5;
-- Q2: Fetch theDetails of employees having maximum and minimum salary working in different department 
--  less than 13% salary hike

SELECT 
    Department,
    MAX(MonthlyIncome),
    MIN(MonthlyIncome),
    PercentSalaryHike
FROM
    empattrition
GROUP BY Department
HAVING PercentSalaryHike < 13
ORDER BY MAX(MonthlyIncome) DESC;
-- Q3 Calculate the average monthly income of all employees who worked more than 3 years at company
-- and whose education background is Medical
SELECT 
    AVG(MonthlyIncome)
FROM
    empattrition
WHERE
    TotalWorkingYears > 3
        AND EducationField = 'Medical'
GROUP BY EducationField;
-- Q.4 Identify the total number of male and female employees from attrition whose Marital status is 
-- married and have not received promotion in last 2 years
SELECT 
    gender, COUNT(EmployeeNumber)
FROM
    empattrition
WHERE
    MaritalStatus = 'Married'
        AND YearsSinceLastPromotion = 2
        AND Attrition = 'Yes'
GROUP BY gender;
-- Q5 employee with MAX  performance rating but no promotion since 4 years
SELECT *
FROM
    empattrition
WHERE
    PerformanceRating = (SELECT 
            MAX(PerformanceRating)
        FROM
            empattrition)
        AND YearsSinceLastPromotion >= 4;
-- Q 6 Top 10  Employees who have max and min salary hike
SELECT 
EmployeeNumber,
    YearsAtCompany,
    PerformanceRating,
    YearsSinceLastPromotion,
    MAX(PercentSalaryHike),
    MIN(PercentSalaryHike)
FROM
    empattrition
GROUP BY YearsAtCompany , YearsSinceLastPromotion , PerformanceRating
ORDER BY MAX(PercentSalaryHike) DESC 
LIMIT 10;
-- SELECT DISTINCT department
-- FROM empattrition

-- Q 7 employees working overtime but given MIN salaryhike and are more than 5 years with company
SELECT 
    *
FROM
    empattrition
WHERE
    OverTime = 'Yes'
        AND PercentSalaryHike =
        (SELECT MIN(PercentSalaryHike)FROM empattrition)
        AND YearsAtCompany >= 5;
-- Q 8employees working overtime  given MAX salary hike but are less than 5 years with company
SELECT *FROM
    empattrition
WHERE
    OverTime = 'Yes'
        AND PercentSalaryHike = (SELECT  MAX(PercentSalaryHike)FROM empattrition)
        AND YearsAtCompany < 5;
-- Q 9 employees not working overtime but given MAX salary hike and are less than 5 years with company
SELECT *FROM
    empattrition
WHERE
    OverTime = 'No'
        AND PercentSalaryHike = (SELECT MAX(PercentSalaryHike) FROM empattrition)
        AND YearsAtCompany < 5;
-- Q 10 write an SQL query to fetch Marital Status with MAX RelationshipSatisfaction and min RelationshipSatis..
SELECT 
    MaritalStatus,
    MAX(RelationshipSatisfaction),
    MIN(RelationshipSatisfaction)
FROM
    empattrition
GROUP BY MaritalStatus