/*
Author: Ian Lim
Script Date: May 5, 2023
Description: This query shows how the length of stay of an international student
impacts the average mental health diagnostic scores of depression (PHQ), social
connectedness (SCS) and acculturative stress (AS)
*/

SELECT
	stay,
	ROUND(AVG(todep), 2) AS average_phq,
	ROUND(AVG(tosc), 2) AS average_scs,
	ROUND(AVG(toas), 2) AS average_as
FROM students
WHERE inter_dom = 'Inter'
GROUP BY stay
ORDER BY stay DESC;
