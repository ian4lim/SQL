/*
Author: Ian Lim
Script Date: May 5, 2023
Description: This query returns a table of each industry_group along with the 
number of companies which are in that industry and a total of the PCFs for that
industry, rounded to one decimal place. This data is stored in a PostgreSQL
database containing one table, product_emissions. which looks at PCFs by product
as well as the stage of production these emissions occurred in.
*/

SELECT
	industry_group,
	COUNT(*) AS count_industry,
	ROUND(SUM(carbon_footprint_pcf), 1) AS total_industry_footprint
FROM product_emissions
WHERE year = 2017
GROUP BY industry_group
ORDER BY total_industry_footprint DESC;
