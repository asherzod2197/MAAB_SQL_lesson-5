
-- Task 1

SELECT *,
       ROW_NUMBER() OVER (ORDER BY Salary DESC) AS SalaryRank
FROM Employees;


-- Task 2

SELECT *
FROM (
    SELECT *,
           RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
    FROM Employees
) t
WHERE SalaryRank IN (
    SELECT SalaryRank
    FROM (
        SELECT RANK() OVER (ORDER BY Salary DESC) AS SalaryRank
        FROM Employees
    ) x
    GROUP BY SalaryRank
    HAVING COUNT(*) > 1
);


-- Task 3

SELECT *
FROM (
    SELECT *,
           DENSE_RANK() OVER (PARTITION BY Department ORDER BY Salary DESC) AS rnk
    FROM Employees
) t
WHERE rnk <= 2;


-- Task 4

SELECT *
FROM (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY Department ORDER BY Salary ASC) AS rn
    FROM Employees
) t
WHERE rn = 1;


-- Task 5

SELECT *,
       SUM(Salary) OVER (PARTITION BY Department ORDER BY HireDate) AS RunningTotal
FROM Employees;


-- Task 6

SELECT *,
       SUM(Salary) OVER (PARTITION BY Department) AS TotalDepartmentSalary
FROM Employees;


-- Task 7

SELECT *,
       AVG(Salary) OVER (PARTITION BY Department) AS AvgDepartmentSalary
FROM Employees;


-- Task 8

SELECT *,
       Salary - AVG(Salary) OVER (PARTITION BY Department) AS DifferenceFromAvg
FROM Employees;


-- Task 9

SELECT *,
       AVG(Salary) OVER (
           ORDER BY EmployeeID
           ROWS BETWEEN 1 PRECEDING AND 1 FOLLOWING
       ) AS MovingAvg
FROM Employees;


-- Task 10

SELECT *,
       SUM(Salary) OVER (
           ORDER BY HireDate DESC
           ROWS BETWEEN CURRENT ROW AND 2 FOLLOWING
       ) AS Last3Sum
FROM Employees;


-- Task 11

SELECT *,
       AVG(Salary) OVER (
           ORDER BY HireDate
           ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS RunningAvg
FROM Employees;


-- Task 12

SELECT *,
       MAX(Salary) OVER (
           ORDER BY EmployeeID
           ROWS BETWEEN 2 PRECEDING AND 2 FOLLOWING
       ) AS SlidingMax
FROM Employees;


-- Task 13

SELECT *,
       (Salary * 100.0 / SUM(Salary) OVER (PARTITION BY Department)) AS PercentageContribution
FROM Employees;
