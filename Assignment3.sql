/*	1	*/
SELECT CONCAT_WS(' ',first_name, last_name) AS 'Full Name',
Round(( CONVERT(REPLACE(Left(NOW(), 10), '-', ''), unsigned) - 
CONVERT(REPLACE(left(birth_date,10), '-', ''), unsigned) )/10000, 0) AS Age,
address AS Address, contact_no AS 'Contact Number'
FROM artists ORDER BY AGE DESC LIMIT 5;

/*	2	*/
SELECT CONCAT_WS(' ', a.first_name, a.last_name) AS "Actors in Star Wars"
FROM movie_cast mc 
JOIN movies m ON m.movie_id = mc.movie_id 
JOIN artists a ON a.artist_id = mc.person_id
WHERE m.title = "Star Wars" and a.Profession = "Actor";

/*	3	*/
SELECT mr.number_of_stars, m.title FROM movies_ratings mr
JOIN movies m ON m.movie_id = mr.movie_id
JOIN awards a ON a.movie_id = m.movie_id
JOIN artists ON artists.artist_id = a.person_id
WHERE artists.Profession = "Actor" AND mr.number_of_stars = 
	(SELECT MIN(number_of_stars) FROM movies_ratings)
;

/*	4	*/
SELECT genre AS Genre, 
COUNT(distinct(title)) AS "Number of movies",
LEFT(release_date, 4) AS "Release Year" FROM movies
GROUP BY genre, LEFT(release_date, 4) ORDER BY LEFT(release_date, 4);

/*	5	*/
SELECT m.title FROM 
awards a JOIN movies m ON m.movie_id = a.movie_id
GROUP BY m.title HAVING COUNT(a.awards_id) >= 3;

/*	6	*/
SELECT movies.title, LEFT(movies.release_date, 4) AS Year, movies.Distributor
FROM movies_ratings mr 
RIGHT JOIN movies ON movies.movie_id = mr.movie_id
WHERE mr.number_of_stars IS NULL;

/*	7	*/
SELECT m.title, a.category FROM awards a
JOIN movies m ON m.movie_id = a.movie_id
WHERE m.Distributor = "Disney"
GROUP BY a.category, m.title;

/*	8	*/
SELECT DISTINCT(Profession) AS "Professions in Music Industry" FROM artists;