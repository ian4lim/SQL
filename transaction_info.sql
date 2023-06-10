/*
Author: Ian Lim
Script Date: June 10, 2023
Description: This query finds for each month and country, the number of
transactions and their total amount, the number of approved transactions and
their total amount.
*/

#Finding information from all transactions
WITH a AS(
    SELECT
        DATE_FORMAT(trans_date, '%Y-%m') AS month,
        country,
        COUNT(*) as trans_count,
        SUM(amount) AS trans_total_amount
    FROM Transactions
    GROUP BY month, country
),
#Finding information from approved transactions
b AS(
    SELECT
        DATE_FORMAT(trans_date, '%Y-%m') AS month,
        country,
        COUNT(*) as approved_count,
        SUM(amount) AS approved_total_amount
    FROM Transactions
    WHERE state = 'approved'
    GROUP BY month, country
)
#Combining all information together
SELECT
    a.month,
    a.country,
    trans_count,
    approved_count,
    trans_total_amount,
    approved_total_amount
FROM a
INNER JOIN b
ON a.month = b.month
AND a.country = b.country
