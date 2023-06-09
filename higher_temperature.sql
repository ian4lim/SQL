/*
Author: Ian Lim
Script Date: June 9, 2023
Description: This query finds all dates' id with higher temperatures compared to its previous dates (yesterday)
*/

WITH cte AS(
    SELECT
        id,
        recordDate,
        temperature,
        LAG(temperature) OVER(ORDER BY recordDate) AS yest_temp,
        LAG(recordDate) OVER(ORDER BY recordDate) AS yest_date
    FROM Weather
)

SELECT
    id
FROM cte
WHERE temperature > yest_temp;
