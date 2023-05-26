/* Task 1 
 Создайте таблицу с мобильными телефонами, используя графический интерфейс. 
 Заполните БД данными */

CREATE DATABASE IF NOT EXISTS hw_1;

USE hw_1;

CREATE TABLE
    IF NOT EXISTS mobile_phone (
        id INT PRIMARY KEY AUTO_INCREMENT,
        product_name VARCHAR(45),
        manufacturer VARCHAR(45),
        product_count INT,
        price INT
    );

INSERT
    mobile_phone(
        product_name,
        manufacturer,
        product_count,
        price
    )
VALUES 
    ('iPhone X', 'Apple', 3, 76000),
    ('iPhone 8', 'Apple', 2, 51000),
    ('Galaxy S9', 'Samsung', 2, 56000),
    ('Galaxy S8', 'Samsung', 1, 41000),
    ('P20 Pro', 'Huawei', 5, 36000);

SELECT
    product_name,
    manufacturer,
    product_count,
    price
FROM mobile_phone;

/* Task 2 
 Выведите название, производителя и цену для товаров, количество которых превышает 2 */

SELECT
    product_name,
    manufacturer,
    price
FROM mobile_phone
WHERE product_count > 2;

/* Task 
 3 Выведите весь ассортимент товаров марки “Samsung” */

SELECT product_name 
FROM mobile_phone 
WHERE manufacturer = 'Samsung';

/* Task 4 
 Выведите информацию о телефонах, где суммарный чек больше 100 000 и меньше 145 000 */

SELECT
    product_name,
    manufacturer,
    product_count,
    price
FROM mobile_phone
WHERE price * product_count 
BETWEEN 100000 
AND 145000;

/* Task 5
 С помощью регулярных выражений найти (можно использовать операторы "LIKE", "RLIKE" для 5.3) */
 
-- 5.1 Товары, в которых есть упоминание 'Iphone'

SELECT
    product_name,
    manufacturer,
    product_count,
    price
FROM mobile_phone
WHERE product_name 
LIKE '%iphone%';

-- 5.2. "Galaxy

SELECT product_name,
    manufacturer,
    product_count,
    price
FROM mobile_phone
WHERE product_name 
LIKE '%galaxy%';

-- 5.3. Товары, в которых есть ЦИФРЫ

SELECT
    product_name,
    manufacturer,
    product_count,
    price
FROM mobile_phone
WHERE product_name 
RLIKE '[0-9]';

-- 5.4. Товары, в которых есть ЦИФРА "8"

SELECT
    product_name,
    manufacturer,
    product_count,
    price
FROM mobile_phone
WHERE product_name 
LIKE '%8%';