/* Task 1 
Используя операторы языка SQL, создайте табличку “sales”. Заполните ее данными. */
CREATE DATABASE IF NOT EXISTS hw_2;

USE hw_2;

CREATE TABLE
    IF NOT EXISTS sales (
        id INT PRIMARY KEY AUTO_INCREMENT, 
        order_date DATE NOT NULL UNIQUE, 
        count_product INT NOT NULL);

DESCRIBE sales;

INSERT sales (order_date, count_product)
VALUES
    ('22-01-01', 156),
    ('22-01-02', 180),
    ('22-01-03', 21),
    ('22-01-04', 124),
    ('22-01-05', 341);

SELECT
    id,
    order_date,
    count_product
FROM
    sales;

/* Task 2 
Сгруппируйте значений количества в 3 сегмента — меньше 100, 100-300 и больше 300. */
SELECT
    id AS 'Order ID',
    IF (count_product<100, 'Small order', 
    IF (count_product<=300, 'Average order', 'Big order')) 
    AS 'Type order'
FROM
    sales;

/* Task 3
Создайте таблицу “orders”, заполните ее значениями. 
Покажите “полный” статус заказа, используя оператор CASE. */
CREATE TABLE
    IF NOT EXISTS orders (
        id INT PRIMARY KEY AUTO_INCREMENT,
        employee_id VARCHAR(10) NOT NULL UNIQUE,
        amount DECIMAL(5, 2) NOT NULL,
        order_status VARCHAR(10));

DESCRIBE orders;

INSERT orders (employee_id, amount, order_status)
VALUES
    ('e03', 15.00, 'OPEN'),
    ('e01', 25.50, 'OPEN'),
    ('e05', 100.70, 'CLOSED'),
    ('e02', 22.18, 'OPEN'),
    ('e04', 9.50, 'CANCELLED');

SELECT
    id,
    employee_id,
    amount,
    order_status
FROM
    orders;

SELECT
    id,
    employee_id,
    amount,
    order_status,
    CASE
        WHEN order_status = 'OPEN' THEN 'Order is in open state'
        WHEN order_status = 'CLOSED' THEN 'Order is closed'
        WHEN order_status = 'CANCELLED' THEN 'Order is cancelled'
        ELSE 'No orders'
    END AS 'Full order status'
FROM
    orders;



/*...как будет время...
Дополнительное задание к первым 2 урокам:
1. CRUD - операции на любом ЯП. Коннект с БД через С#, к примеру
Файл со скриптом прикреплен к материалам(interview.sql):
№1. Используя оператор ALTER TABLE, установите внешний ключ в одной из таблиц (clients-posts)
№2. Без оператора JOIN, верните заголовок публикации, текст с описанием, 
идентификатор клиента, опубликовавшего публикацию и логин данного клиента.
№3. Выполните поиск по публикациям, автором которых является клиент "Michael".
 */