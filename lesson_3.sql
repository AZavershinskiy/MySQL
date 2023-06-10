
CREATE DATABASE IF NOT EXISTS lesson_3;

USE lesson_3;

DROP TABLE IF EXISTS products;

CREATE TABLE
    IF NOT EXISTS products (
        id INT PRIMARY KEY AUTO_INCREMENT,
        product_name VARCHAR(45) NOT NULL,
        manufacturer VARCHAR(45) NOT NULL,
        product_count INT DEFAULT 0,
        price DECIMAL NOT NULL
    );

INSERT
    products (
        product_name,
        manufacturer,
        product_count,
        price
    )
VALUES 
    ('iPhone X', 'Apple', 3, 71000),
    ('iPhone 8', 'Apple', 3, 56000),
    ('Galaxy S9', 'Samsung', 6, 56000),
    ('Galaxy S8', 'Samsung', 2, 46000),
    ('Honor 10', 'Huawei', 3, 26000),
    ('Nokia 8', 'HMD Global', 6, 38000);

-- Sort by COLUMN:
SELECT
    id,
    product_name,
    manufacturer,
    product_count,
    price
FROM products
ORDER BY price; -- ORDER BY is placed at the end of the query

-- Using an alias in an ORDER BY query
SELECT
    product_name,
    product_count
    *
    price AS total_sum
FROM products
ORDER BY total_sum;

-- Usage example: LIMIT
SELECT * FROM products 
LIMIT 3; -- number of lines to display starting from the first

SELECT * FROM products
LIMIT 2, 3; -- number of lines to skip, number of lines to display

-- Usage example: LIMIT OFFSET
SELECT *
FROM products
LIMIT 2 OFFSET 3; -- number of lines to display, number of lines to skip

-- Microoft DBMS
SELECT TOP 2 * -- number of lines starting from the first
FROM products;

-- Unique values - DISTINCT
SELECT DISTINCT manufacturer
FROM products;

SELECT DISTINCT manufacturer, product_count
FROM products;


-- GROUP BY
SELECT manufacturer,  COUNT(*) AS models_count
FROM products
GROUP BY manufacturer;


/* Aggregate functions
AVG - calculates the average
SUM - calculates the sum of the values
MIN - calculates the minimum value
MAX - calculates the maximum value
COUNT - calculates the number of rows in a query
*/

SELECT 
MIN(price), 
MAX(price),
AVG(price)
FROM products
WHERE manufacturer = 'Samsung';

-- AVG
SELECT AVG(price) AS 'Average Price' 
FROM products;

SELECT AVG(price) 
FROM products
WHERE manufacturer = 'Apple'; -- with column filtering

-- COUNT (number of rows in tables)
SELECT COUNT(*)
FROM products;

-- HAVING
SELECT manufacturer, COUNT(*) AS 'Models Count'
FROM products
GROUP BY manufacturer
HAVING COUNT(*) > 1;

SELECT manufacturer, COUNT(*) AS 'Models', SUM(product_count) AS Units
FROM products
WHERE price * product_count > 80000
GROUP BY manufacturer
HAVING SUM(product_count) > 2
ORDER BY Units DESC; -- DESC - descending sort (Z>A, 9>0)


SELECT * FROM products
ORDER BY price DESC;