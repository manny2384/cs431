/*		Query 1		*/
DROP PROCEDURE IF EXISTS test;
DELIMITER //
CREATE PROCEDURE test()
BEGIN

	DECLARE SQL_ERROR TINYINT DEFAULT FALSE;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET SQL_ERROR = TRUE;
        
	START TRANSACTION;
    
    DELETE FROM addresses WHERE musician_id = 8;
	DELETE FROM musicians WHERE musician_id = 8;
    
    IF SQL_ERROR = FALSE THEN
        SELECT * FROM musicians; /* DISPLAY updated table	*/
        SELECT * FROM addresses;
		COMMIT;
	ELSE
        SELECT 'Transaction A failed, rolled back' AS OUTPUT;
        ROLLBACK;
    END IF;

END//
CALL test();

/*		Query 2		*/

DROP PROCEDURE IF EXISTS test;
DELIMITER //;
CREATE PROCEDURE test()
BEGIN
	DECLARE SQL_ERROR TINYINT DEFAULT FALSE;
    DECLARE order_id INT DEFAULT 0;
    
    DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET SQL_ERROR = TRUE;
	
    START TRANSACTION;
    
    INSERT INTO orders VALUES (DEFAULT, 3, NOW(), '10.00', '0.00', NULL, 4,
		'American Express', '378282246310005', '04/2016', 4);
    
	SELECT LAST_INSERT_ID() INTO order_id;
    
	INSERT INTO order_instruments VALUES (DEFAULT, order_id, 6, '415.00', '161.85', 1);
        
	INSERT INTO order_instruments VALUES (DEFAULT, order_id, 1, '699.00', '209.70', 1);
        
    IF SQL_ERROR = FALSE THEN
		SELECT "TRANSACTION SUCCESSFULL" AS OUTPUT;
        /*	DISPLAY NEW ROW FROM TABLE */
        SELECT * FROM order_instruments oi WHERE oi.order_id = order_id;
        COMMIT;
	ELSE
		SELECT "TRANSACTION FAILED" AS OUTPUT;
        ROLLBACK;
	END IF;
END//;
call test();

/*		Query 3		*/

DROP PROCEDURE IF EXISTS test;
DELIMITER //;
CREATE PROCEDURE test()
BEGIN
	DECLARE SQL_ERROR TINYINT DEFAULT FALSE;

	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
		SET SQL_ERROR = TRUE;
		
	START TRANSACTION;
    
		SELECT * FROM musicians WHERE musician_id = 6 FOR UPDATE;

		UPDATE orders SET musician_id = 3 WHERE musician_id = 6;

		UPDATE addresses SET musician_id = 3 WHERE musician_id = 6;

		DELETE FROM musicians WHERE musician_id = 6;
        
        IF SQL_ERROR = FALSE THEN 
			SELECT 'TRANSACTION SUCCESS';
            SELECT * FROM musicians;
            SELECT * FROM addresses;
            SELECT * FROM orders;
            COMMIT;
		ELSE
			SELECT 'MUSICIANS DELETE FAILED';
            ROLLBACK;
		END IF;
END//;
CALL test();