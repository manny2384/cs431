/*		Query 1		*/
DROP VIEW IF EXISTS movies_legendary_technicians;
CREATE VIEW movies_legendary_technicians AS
	SELECT m.title, CONCAT_WS(' ',a.first_name, a.last_name) AS Technicians,
	LEFT(NOW(), LOCATE(' ', NOW())) - LEFT(a.birth_date, LOCATE(' ', a.birth_date))
		AS AGE
		FROM artists a INNER JOIN movie_cast mc ON mc.person_id = a.artist_id
		INNER JOIN movies m ON m.movie_id = mc.movie_id
		WHERE mc.category IS NOT NULL
		HAVING AGE > 40 ORDER BY AGE ASC
	;
SELECT * FROM movies_legendary_technicians;

/*		Query 2		*/
DROP PROCEDURE IF EXISTS must_watch_movies;
DELIMITER //
CREATE PROCEDURE must_watch_movies()
BEGIN
	DECLARE movie_name VARCHAR(45);
    DECLARE dist VARCHAR(45);
    DECLARE year_of_release VARCHAR(5);
	DECLARE row_found TINYINT DEFAULT TRUE;
    DECLARE movie_list VARCHAR(600) DEFAULT "";
    
    DECLARE movie_cursor CURSOR FOR
		SELECT title, distributor, LEFT(release_date, 4)
		FROM movies
			WHERE gross > 2 ORDER BY title ASC;
	
    DECLARE CONTINUE HANDLER FOR NOT FOUND
		SET row_found = FALSE;
        
	OPEN movie_cursor;
    
    WHILE row_found = TRUE DO
		FETCH movie_cursor INTO movie_name, dist, year_of_release;
		IF row_found = TRUE THEN
			SET movie_list = CONCAT(movie_list, "'", movie_name, "','", dist, "','", 
				year_of_release,"'|");
		END IF;
	END WHILE;
    
    CLOSE movie_cursor;
    
    SELECT movie_list AS must_watch_movies_with_gross_over_2million;
END//
CALL must_watch_movies();
