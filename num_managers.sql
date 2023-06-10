/*
Author: Ian Lim
Script Date: June 10, 2023
Description: This query reports the managers with at least five direct reports.
*/

WITH m AS(
    SELECT
        managerId,
        COUNT(*)
    FROM Employee
    GROUP BY managerId
    HAVING COUNT(*) >= 5
)
SELECT
    name
FROM Employee
WHERE id IN (
    SELECT managerId
    FROM m
)
