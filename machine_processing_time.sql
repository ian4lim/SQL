/*
Author: Ian Lim
Script Date: March 9, 2024
Description: There is a factory website that has several machines each running
the same number of processes. Write an SQL query to find the average time each
machine takes to complete a process.
*/

WITH end AS(
    SELECT
        machine_id,
        process_id,
        activity_type,
        timestamp AS end_time
    FROM Activity
    WHERE activity_type = 'end'
),

start AS(
    SELECT
        machine_id,
        process_id,
        activity_type,
        timestamp AS start_time
    FROM Activity
    WHERE activity_type = 'start'
)

SELECT
    start.machine_id,
    ROUND(AVG(end_time - start_time), 3) as processing_time
FROM start
INNER JOIN end
ON start.machine_id = end.machine_id
AND start.process_id = end.process_id
GROUP BY machine_id;
