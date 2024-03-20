/*
Author: Ian Lim
Script Date: March 11, 2024
Description: This query reports the fraction of players that logged in for at
least two consecutive days starting from their first login date.
*/

# Adding previous_date column to show the last date of login
WITH a AS(
    SELECT
        player_id,
        device_id,
        event_date,
        LAG(event_date) OVER(PARTITION BY player_id ORDER BY event_date) AS previous_date
    FROM Activity
),

# Counting how many players have consecutive logins
b AS(
    SELECT
        COUNT(DISTINCT player_id) AS num_players
    FROM a
    WHERE previous_date IS NOT NULL
    AND DATEDIFF(event_date, previous_date) = 1
)

# Reporting fraction of players with consecutive logins
SELECT
    ROUND(((SELECT * FROM b) / COUNT(DISTINCT player_id)), 2) as fraction
FROM a
