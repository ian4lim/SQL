/*
Author: Ian Lim
Script Date: March 11, 2024
Description: Find the name of the user who has rated the greatest number of
movies. In case of a tie, return the lexicographically smaller user name.
Find the movie name with the highest average rating in February 2020. In case
of a tie, return the lexicographically smaller movie name.
*/

-- Finding the user with the highest number of ratings
WITH a AS(
  SELECT
    user_id,
    name,
    COUNT(*) num_reviews
  FROM MovieRating r
  LEFT JOIN Users u
  USING(user_id)
  GROUP BY user_id
  ORDER BY num_reviews DESC, name ASC
  LIMIT 1
),
-- Finding the movie with the highest rating in Feb 2020
b AS(
  SELECT
    movie_id,
    title,
    AVG(rating) as avg_rating
  FROM MovieRating r
  LEFT JOIN Movies m
  USING(movie_id)
  WHERE created_at BETWEEN '2020-02-01' AND '2020-02-29'
  GROUP BY movie_id
  ORDER BY avg_rating DESC, title ASC
  LIMIT 1
)
-- Combining the results
SELECT
  name as results
FROM a
UNION ALL
SELECT
  title
FROM b as results
