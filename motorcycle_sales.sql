/*
Author: Ian Lim
Script Date: March 5, 2024
Description: This query returns product_line, the month from
 date, displayed as 'June', 'July', and 'August', the warehouse, and
 net_revenue. This is to analyze motorcycle sales data by looking at wholesale
 revenue by product line, and how this varies month-to-month and across
 warehouses
*/

SELECT product_line,
    CASE WHEN EXTRACT('month' from date) = 6 THEN 'June'
        WHEN EXTRACT('month' from date) = 7 THEN 'July'
        WHEN EXTRACT('month' from date) = 8 THEN 'August'
    END as month,
    warehouse,
    ROUND(SUM(total * (1 - payment_fee))::numeric, 2) AS net_revenue
FROM sales
WHERE client_type = 'Wholesale'
GROUP BY product_line, warehouse, month
ORDER BY product_line, month, net_revenue DESC
