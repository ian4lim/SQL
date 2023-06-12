/*
Author: Ian Lim
Script Date: June 11, 2023
Description: Compute the moving average of how customers paid in a
seven day window (i.e., current day + 6 days before)
*/

-- Grouping sales by day
WITH a AS(
SELECT
  visited_on,
  SUM(amount) as amount
FROM Customer
GROUP BY visited_on
),
-- Calculating running total and running average
b AS(
SELECT
  visited_on,
  SUM(amount) OVER(ORDER BY visited_on
                    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_sum,
  AVG(amount) OVER(ORDER BY visited_on
                    ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) AS moving_avg,
  ROW_NUMBER() OVER(ORDER BY visited_on) AS row_num
FROM a
)
-- Starting output with day 7
SELECT
  visited_on,
  ROUND(moving_sum, 2) AS amount,
  ROUND(moving_avg, 2) AS average_amount
FROM b
WHERE row_num >= 7
