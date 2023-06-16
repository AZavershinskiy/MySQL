CREATE DATABASE IF NOT EXISTS lesson_6;
USE lesson_6;

/*
START TRANSACTION;
SELECT total FROM account WHERE user_id = 2;
UPDATE account SET total = total - 3000 WHERE user_id = 2;
UPDATE account SET total = total + 3000 WHERE user_id IS NULL;
COMMIT;
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
CREATE PROCEDURE procedure_name [(parameter datatype [, parameter datatype])]
BEGIN
    declaration_select
    executable_section
END;

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


-- FROM SEMINAR:
