# 1. Создание БД
CREATE DATABASE IF NOT EXISTS lesson_3;

USE lesson_3;

DROP TABLE IF EXISTS staff;
CREATE TABLE staff
(
	id INT PRIMARY KEY AUTO_INCREMENT,
    firstname VARCHAR(45) NOT NULL,
    lastname VARCHAR(45) NOT NULL,
    post VARCHAR(45) NOT NULL,
    seniority INT, 
    salary DECIMAL(8,2), -- 100 000 . 00
    age INT
);
-- 4. Заполнение таблицы данными
INSERT staff(firstname, lastname, post, seniority,salary,age)
VALUES ("Петр", "Петров", "Начальник", 8, 70000, 30); -- id = 1
INSERT staff (firstname, lastname, post, seniority, salary, age)
VALUES
  ('Вася', 'Петров', 'Начальник', 40, 100000, 60),
  ('Петр', 'Власов', 'Начальник', 8, 70000, 30),
  ('Катя', 'Катина', 'Инженер', 2, 70000, 25),
  ('Саша', 'Сасин', 'Инженер', 12, 50000, 35),
  ('Иван', 'Петров', 'Рабочий', 40, 30000, 59),
  ('Петр', 'Петров', 'Рабочий', 20, 55000, 60),
  ('Сидр', 'Сидоров', 'Рабочий', 10, 20000, 35),
  ('Антон', 'Антонов', 'Рабочий', 8, 19000, 28),
  ('Юрий', 'Юрков', 'Рабочий', 5, 15000, 25),
  ('Максим', 'Петров', 'Рабочий', 2, 11000, 19),
  ('Юрий', 'Петров', 'Рабочий', 3, 12000, 24),
  ('Людмила', 'Маркина', 'Уборщик', 10, 10000, 49);

SELECT * FROM staff;

-- ORDER BY - сортировка 
SELECT 
	salary,
    id,
    CONCAT(firstname, " ", lastname) AS fullname -- "1" + " " + "1" = "1 1"
FROM staff
ORDER BY salary DESC; -- ASC (искомое значение сортировки - по воз-ю) 
-- DESC - по убыванию

SELECT 
	salary,
    id,
    firstname, 
    lastname
FROM staff
ORDER BY lastname DESC, firstname DESC, salary DESC; -- От я -> а

SELECT DISTINCT lastname
FROM staff
ORDER BY lastname
LIMIT 5; -- по воз-ю, от буквы "А" к букве "Я"

-- Группировка - GROUP BY
-- Для каждой должности найти:
-- среднюю зп, мин зп, макс зп, разницу между макс и мин зп, коливество сотрудников 
SELECT
	post,
    ROUND(AVG(salary), 2),
    MAX(salary) ,
    MIN(salary),
    MAX(salary) - MIN(salary) AS Difference,
    COUNT(id)
FROM staff
WHERE post NOT IN("Начальник", "Уборщик") -- исключаем до группировки
GROUP BY post
HAVING AVG(salary) > 25000; -- условие на сформированные группы

SELECT AVG(salary)
FROM staff
WHERE AVG(salary) > 10000;

SELECT AVG(salary)
FROM staff
HAVING AVG(salary) > 10000; -- Оператор HAVING работает с агрегатными функциями

SELECT *
FROM staff
WHERE post NOT IN("Начальник", "Уборщик");

SELECT *
FROM staff
HAVING post NOT IN("Начальник", "Уборщик");


-- Создадим архив документов по месяцам (сколько документов было создано в каждом месяце)
SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
SELECT 
	COUNT(id) AS count_media,
    MONTHNAME(created_at) AS month_name, -- 05 - May 
    MONTH(created_at) AS month_number
FROM media 
GROUP BY month_name
ORDER BY MONTH(created_at);

-- Сколько документов у каждого пользователя 
SELECT 
	user_id,
	COUNT(id) AS count_media,
    (SELECT email FROM users WHERE users.id = media.user_id) AS user_email
FROM media
GROUP BY user_id
ORDER BY COUNT(id) DESC
LIMIT 5;