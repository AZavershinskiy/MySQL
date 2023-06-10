-- Отсортируйте данные по полю заработная плата (salary) в порядке: убывания, возрастания.
CREATE DATABASE IF NOT EXISTS hw_3;

USE hw_3;

CREATE TABLE
    IF NOT EXISTS staff (
        id INT PRIMARY KEY AUTO_INCREMENT,
        firstname VARCHAR(45) NOT NULL,
        lastname VARCHAR(45) NOT NULL,
        post VARCHAR(45) NOT NULL,
        seniority INT,
        salary DECIMAL(8, 2), -- 100 000 . 00
        age INT
    );

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

SELECT id, firstname, lastname, post, seniority, salary, age
FROM staff
ORDER BY salary DESC;

SELECT id, firstname, lastname, post, seniority, salary, age
FROM staff
ORDER BY salary;


-- Выведите 5 максимальных заработных плат (saraly).
SELECT firstname, post, salary
FROM staff
ORDER BY salary DESC
LIMIT 5;


-- Посчитайте суммарную зарплату (salary) по каждой специальности (роst).
SELECT post, SUM(salary) AS SFES -- Salary for each specialty
FROM staff
GROUP BY post
ORDER BY SFES;



-- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
SELECT post, COUNT(*) AS 'Employees'
FROM staff
WHERE age BETWEEN 24 AND 49 AND post = 'Рабочий';


-- Найдите количество специальностей.
SELECT COUNT(DISTINCT post) AS 'Specialties'
FROM staff;


-- Выведите специальности, у которых средний возраст сотрудников меньше 30 лет.
SELECT post, ROUND(AVG(age)) AS average_age, COUNT(post) AS 'Employees'
FROM staff
GROUP BY post
HAVING average_age < 35; -- в задании 30, но таких нет 


/*
Доп: ...не успеваю...
Внутри каждой должности вывести ТОП-2 по ЗП (2 самых высокооплачиваемых сотрудника по ЗП внутри каждой должности)
Доп по базе данных для ВК(in progress):
....
-- Посчитать количество документов у каждого пользователя
-- Посчитать лайки для моих документов (моих медиа)
 */