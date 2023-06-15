CREATE DATABASE IF NOT EXISTS lesson_5;
USE lesson_5;

CREATE TABLE sales (
    sales_employee VARCHAR(50) NOT NULL,
    fiscal_year INT NOT NULL,
    sale DECIMAL(14,2) NOT NULL,
    PRIMARY KEY(sales_employee, fiscal_year)
    );
INSERT INTO sales(sales_employee, fiscal_year, sale)
VALUES
    ('Bob', 2016, 100),
    ('Bob', 2017, 150),
    ('Bob', 2018, 200),
    ('Alice', 2016, 150),
    ('Alice', 2017, 100),
    ('Alice', 2018, 200),
    ('John', 2016, 200),
    ('John', 2017, 150),
    ('John', 2018, 250);

SELECT sales_employee, fiscal_year, sale
FROM sales;

SELECT fiscal_year, SUM(sale)
FROM sales
GROUP BY fiscal_year;


/* Window Function Syntax
SELECT
Function name (calculation column)
OVER
(
    PARTITION BY grouping column
    ORDER BY sort column
    ROWS or RANGE expression to limit rows within a group
)
*/

DROP TABLE Orders;
CREATE TABLE IF NOT EXISTS Orders (
    Date DATE NOT NULL,
    Medium VARCHAR(10) NOT NULL,
    Conversions INT NOT NULL
    );

INSERT INTO Orders (Date, Medium, Conversions)
VALUES
    ('2020-05-10', 'cpa', 1),
    ('2020-05-10', 'cpc', 2),
    ('2020-05-10', 'organic', 1),
    ('2020-05-11', 'cpa', 1),
    ('2020-05-11', 'cpc', 3),
    ('2020-05-11', 'organic', 2),
    ('2020-05-11', 'direct', 1),
    ('2020-05-12', 'cpc', 1),
    ('2020-05-12', 'organic', 2);

-- PARTITION BY:
SELECT Date, Medium, Conversions, SUM(Conversions)
OVER (PARTITION BY Date 
ORDER BY Medium) AS 'Sum'
FROM Orders;

-- ROWS and RANGE:
SELECT
    Date,
    Medium,
    Conversions,
    SUM(Conversions) 
OVER (PARTITION BY Date ORDER BY Conversions ROWS 
    BETWEEN CURRENT ROW AND 1 FOLLOWING) AS 'Sum'
FROM Orders;

-- Example of using aggregate functions with OVER window construction:
SELECT
    Date,
    Medium,
    Conversions,
    SUM(Conversions) OVER(PARTITION BY Date) AS 'Sum',
    COUNT(Conversions) OVER(PARTITION BY Date) AS 'Count',
    ROUND(AVG(Conversions) OVER(PARTITION BY Date), 2) AS 'Avg',
    MAX(Conversions) OVER(PARTITION BY Date) AS 'Max',
    MIN(Conversions) OVER(PARTITION BY Date) AS 'Min'
FROM Orders;

/*
Ranking functions:
ROW_NUMBER
RANK
DENSE_RANK
NTILE
*/

SELECT
    Date,
    Medium,
    Conversions,
    ROW_NUMBER()
    OVER(PARTITION BY Date ORDER BY Conversions) AS 'Row_number',
    RANK()
    OVER(PARTITION BY Date ORDER BY Conversions) AS 'Rank',
    DENSE_RANK()
    OVER(PARTITION BY Date ORDER BY Conversions) AS 'Dense_rank',
    NTILE(3)
    OVER(PARTITION BY Date ORDER BY Conversions) AS 'Ntile'
FROM ORDERS;

-- Offset functions:
-- LAG or LEAD
-- FIRST_VALUE or LAST_VALUE
SELECT
    Date,
    Medium,
    Conversions,
    LAG(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Lag',
    LEAD(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Lead',
    FIRST_VALUE(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'First_Value',
    LAST_VALUE(Conversions) OVER(PARTITION BY Date ORDER BY Date) AS 'Last_Value'
FROM Orders;

-- VIEW
/*
CREATE [OR REPLACE] VIEW view_name AS
    SELECT columns
    FROM table
    [WHERE conditions];

[...] - optional
*/

DROP TABLE IF EXISTS customer;
CREATE TABLE IF NOT EXISTS customer
(
    Customer_id INT PRIMARY KEY,
    Customer_name VARCHAR(20) NOT NULL,
    Contact_no VARCHAR(20) UNIQUE NOT NULL,
    Email VARCHAR(20) UNIQUE NOT NULL,
    Purchased_amount DECIMAL(8,2) NOT NULL,
    City VARCHAR(20) NOT NULL
);
INSERT INTO customer(Customer_id, Customer_name, Contact_no, Email, Purchased_amount, City)
VALUES
    (184, 'Ravi Kumar', '9887463893', 'ravi@gmail.com', 8000, 'Kolkana'),
    (984, 'Vinay Das', '9839878678', 'vinay@yahoo.in', 12000, 'Dilhi'),
    (452, 'K.Amarnath', '7598759387', 'amar@gmail.com', 15000, 'Kolkata'),
    (874, 'Abhinash Desai', '7675878798', 'desai@gmail.com', 5000, 'Mumbai');

CREATE VIEW customer_archive AS
SELECT Customer_id, Customer_name, Contact_no, Email, Purchased_amount, City
FROM customer
WHERE Purchased_amount > 10000;

SELECT * FROM customer_archive;

CREATE TABLE IF NOT EXISTS products 
(
    id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(45),
    manufacturer VARCHAR(45),
    product_count INT,
    price INT
);

INSERT products(product_name, manufacturer, product_count, price)
VALUES 
    ('iPhone X', 'Apple', 3, 76000),
    ('iPhone 8', 'Apple', 2, 51000),
    ('Galaxy S9', 'Samsung', 2, 56000),
    ('Galaxy S8', 'Samsung', 1, 41000),
    ('P20 Pro', 'Huawei', 5, 36000);

CREATE VIEW copy_products AS
SELECT price, product_count, manufacturer
FROM products
WHERE manufacturer = 'Apple';

SELECT * FROM copy_products;

-- DROP VIEW copy_products;

ALTER VIEW copy_products AS
SELECT price, product_count, manufacturer, product_name
FROM products
WHERE manufacturer = 'Apple';


CREATE TABLE customer2
(
    customer VARCHAR(10) NOT NULL,
    rating INT NOT NULL
);
INSERT INTO customer2 (customer, rating)
VALUES 
    ('#1', 33),
    ('#2', 77),
    ('#3', 80),
    ('#4', 10),
    ('#5', 50);
CREATE VIEW Highratings
    AS SELECT *
        FROM customer2
        WHERE rating = 
            (SELECT MAX(rating)
            FROM customer2);
SELECT * FROM Highratings;

