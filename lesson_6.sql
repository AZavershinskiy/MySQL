CREATE DATABASE IF NOT EXISTS lesson_6;
USE lesson_6;

/*
START TRANSACTION;
SELECT total FROM account WHERE user_id = 2;
UPDATE account SET total = total - 3000 WHERE user_id = 2;
UPDATE account SET total = total + 3000 WHERE user_id IS NULL;
COMMIT; -- or ROLLBACK
*/

-- TEMPORARY TABLE - for current user session:
/*
CREATE TEMPORARY TABLE table_name( 
    column_1_definition,
    column_2_definition,
    ...,
    table_constraints
    );
*/

-- set variable:
/*
SET @variable_name := value;
SET @counter := 100;

or

set variable using SELECT statement:
SELECT @variable_name := value;
*/
SET @test1 := 5;
SELECT @test1;
-- or
SELECT @test2 := 50;

-- Set max price for variable(msrp) from table(products):
/*
SELECT @msrp := MAX(msrp)
FROM products;
*/

-- IF statement:
/*
IF(expr, if_true_expr, if_false_expr)

SELECT IF(400<2000, 'YES', 'NO'); -- YES

SELECT IF(1 = 2, 'true', 'false'); -- false
SELECT IF(1 = 1, 'true', 'false'); -- true
*/

-- N/A instead of NULL:
/*
SELECT 
    customer_number, 
    customer_name, 
    IF (state IS NULL, 'N/A', state) state,
    country
FROM customer;
*/

-- IF statement with aggregate functions:
/*
SELECT 
    SUM(IF(status = 'Shipped', 1, 0)) AS Shipped,
    SUM(IF(status = 'Cancelled', 1, 0)) AS Cancelled
FROM orders;
*/ 

-- COUNT IF statement:
/*
SELECT DISTINCT status
FROM orders
ORDER BY status;

SELECT 
    COUNT(IF(status = 'Canceled', 1, NULL)) Cancelled,
    COUNT(IF(status = 'Disputed', 1, NULL)) Disputed,
    COUNT(IF(status = 'In Process', 1, NULL)) 'In Process',
    COUNT(IF(status = 'On Hold', 1, NULL)) 'On Hold',
    COUNT(IF(status = 'Resolved', 1, NULL)) 'Resolved',
    COUNT(IF(status = 'Shipped', 1, NULL)) Shipped
FROM orders;
*/

-- Procedure syntax:
/*
DELIMITER //
CREATE PROCEDURE procedure_name [(parameter datatype [, parameter datatype])]
BEGIN
    declaration_select
    executable_section
END //
DELIMITER ;

CREATE PROCEDURE Filter()
BEGIN
SELECT * FROM data.record
WHERE Country LIKE '%ia';
END;
CALL Filter();
*/

-- WHILE:
/*
[label_name:] WHILE condition DO
    {...statements...}
END WHILE [label_name];

DECLARE i INT DEFAULT 3;
    WHILE i>0 DO
        SELECT magazine_incoming.id_incoming, products.name, prodocts.author, magazine_incoming.quantity
        FROM magazine_incoming, products
        WHERE magazine_incoming.id_product = products.id_product AND magazine_incoming.id_incoming = i;
        SET i = i - 1;
    END WHILE;
*/

-- Procedure modification:
/*
CREATE PROCEDURE books (IN num INT)
    BEGIN
        DECLARE i INT DEFAULT 0;
        IF (num > 0) THEN
            WHILE i < num DO
                SELECT magazine_incoming.id_incoming, products.name, prodocts.author, magazine_incoming.quantity
                FROM magazine_incoming, products
                WHERE magazine_incoming.id_product = products.id_product AND magazine_incoming.id_incoming = i;
                SET i = i + 1;
            END WHILE;
        ELSE
            SELECT 'Set the correct parameter';
        END IF;
    END
*/

-- ---------------------------------------------
-- FROM SEMINAR:
USE lesson_3;
SHOW TABLES;

-- Let 's create a procedure,
-- which will display the status of the salary
-- from 0 to 49 999 incl, then "Low salary"
-- from 50 000 to 69 999 incl, "Average salary"
-- Salary > 70 000, then "High salary"

-- Employee number (id), employee status (result - in a separate variable)
SELECT @res_out := 5;
DROP PROCEDURE IF EXISTS get_status;
DELIMITER $$
CREATE PROCEDURE get_status
(
    IN staff_number INT, -- -- person's number
    OUT staff_status VARCHAR(45)  -- the status of a particular person 
)
BEGIN
    DECLARE staff_salary DOUBLE; -- NULL

    SELECT salary INTO staff_salary
    FROM staff
    WHERE staff_number = id; -- 5 = 5, get the salary of the 5th employee and store it in 'staff_salary'

    IF staff_salary BETWEEN 0 AND 49999
        THEN SET staff_status = 'Low salary';
    ELSEIF staff_salary BETWEEN 50000 AND 69999
        THEN SET staff_status = 'Average salary';
    ELSEIF staff_salary >= 70000
        THEN SET staff_status = 'High salary';
    END IF;
END $$
DELIMITER ;

-- Procedure call:
CALL get_status(4, @res_out);

SELECT * FROM staff
WHERE id = 4;

SELECT @res_out;


-- The function will look for the person's age
-- Current date and time, person's date of birth
DROP FUNCTION IF EXISTS get_age;
DELIMITER $$
CREATE FUNCTION get_age
(
    date_bith DATE, -- 'yyyy-mm-dd': '2023-06-04'
    current_t DATETIME -- 2023-06-04 10:55:05 'yyyy-mm-dd hh:mm:ss'
)
RETURNS INT
DETERMINISTIC
RETURN (YEAR(current_t) - YEAR(date_bith));
DELIMITER ;

SELECT get_age('1989-12-06', NOW()) AS "Person's age";


USE vk_db;
-- PROCEDURES
-- Creation procedure for adding a new user  profile with COMMIT or ROLLBACK

DROP PROCEDURE IF EXISTS user_add;
DELIMITER $$
CREATE PROCEDURE user_add
(
    firstname VARCHAR(50), lastname VARCHAR(50), email VARCHAR(50), -- users
    phone VARCHAR(50), hometown VARCHAR(50), photo_id INT, birthday DATE,
    OUT result VARCHAR(300)
)
BEGIN
    DECLARE _rollback BIT DEFAULT 0;
    DECLARE error_code VARCHAR(300);
    DECLARE error_text VARCHAR(300);
    DECLARE   HANDLER FOR SQLEXCEPTION
    BEGIN
        SET _rollback = 1;
        GET STACKED DIAGNOSTICS CONDITION 1
        error_code = RETURNED_SQLSTATE, error_text = MESSAGE_TEXT;
    END;
    START TRANSACTION; -- start
    INSERT INTO users (firstname, lastname, email)
    VALUES (firstname, lastname, email);
    INSERT INTO profiles (user_id, hometown, birthday, photo_id)
    VALUES (LAST_INSERT_ID(), hometown, birthday, photo_id);
    IF _rollback THEN -- _rollback == 1
        SET result = CONCAT('Oops! Error: ', error_code, ' . Error text: ', error_text);
        ROLLBACK; -- rolled back because data is invalid
    ELSE -- _rollback == 0
        SET result = 'OK!';
        COMMIT;
    END IF;
END $$
DELIMITER ;

CALL user_add
    ('New', 'User', 'email@email.ml', '123-123', 'Woscow', 10, '1999-01-01', @proced_result);
SELECT @proced_result;


USE lesson_6;
-- Create a procedure that will print all digits from N to 1
-- n = 5: "5, 4, 3, 2, 1"
DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER $$
CREATE PROCEDURE print_numbers
(
	input_number INT -- n
)
BEGIN 
	DECLARE n INT; -- n = input_number
    DECLARE result VARCHAR(45) DEFAULT '';
    
    SET n = input_number;
    REPEAT
		SET result = CONCAT(result, n, ', ');
        SET n = n - 1;

        UNTIL n <= 0 -- loop exit condition
    END REPEAT;
    SELECT result;

END $$
DELIMITER ;

CALL print_numbers(10);