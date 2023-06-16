-- Комментарий, после "--" обязательно нужно ставить пробел 
# Комментарий 

/*
	Это 
    многострочный 
    комментарий 
*/

-- snake_case - названия столбцов, таблиц, БД 

-- 1. Создание БД 
CREATE DATABASE IF NOT EXISTS lesson_1; -- Создание БД lesson_1, если она НЕ СУЩЕСТВУЕТ

-- 2. Подключение к БД
USE lesson_1; -- Взаим-е с БД lesson_1

-- 3. Создание таблицы: студенты
DROP TABLE IF EXISTS student; -- Удалю таблицу student, если она существует
CREATE TABLE student
(
	-- имя_столбца тип_данных ограничения 
    id INT PRIMARY KEY AUTO_INCREMENT,
	firstname VARCHAR(45),
    email VARCHAR(45),
    mobile_phone VARCHAR(45)
)
AUTO_INCREMENT = 10 -- Изменили автоинкремент на 0
;

-- 4. Заполним таблицу данными 
INSERT student (firstname, email, mobile_phone) -- Заполняем таблицу student, столбцы: (firstname, email, mobile_phone)
VALUES 
	("Андрей", "dmfjjf@gmail.com", "+7-999-888-66-55"), -- id = 0
    ("Анатолий", "dmfjjf@gmail.com", "+7-999-888-66-55"),  -- id = 1 
    ("Алексей", "dmfjjf@gmail.com", "+7-999-888-66-55"),  -- id = 2
    ("Анастасия", "dmfjjf@gmail.com", "+7-999-888-66-55"),  -- id = 3 
    ("Виктория", "dmfjjf@gmail.com", "+7-999-888-66-55"),  -- id = 4 
    ("Владимир", "dmfjjf@gmail.com", "+7-999-888-66-55");  -- id = 5 
    
-- 5. Отобразим таблицу

SELECT *
FROM student; -- Дурной тон 

-- 6. Вывести ограниченное количество столбцов (имя и почту)
SELECT firstname, email 
FROM student;

-- 7. Получим номер телефона и почту студента по имени Андрей 
SELECT mobile_phone, email, firstname
FROM student
WHERE firstname = "Андрей";

DESCRIBE student; -- Аналитик по столбцам в таблице student

-- 8. Получим номера телефонов и почту студентов, исключив Андрея
SELECT mobile_phone, email, firstname
FROM student
WHERE firstname != "Андрей"; -- "<>" и "!=" - одинаковые вещи 

-- 9. Вывести список всех студентов, имена которых начинаются с буквы "А" 
SELECT mobile_phone, email, firstname
FROM student
WHERE firstname LIKE "А%";

-- 10
SELECT mobile_phone, email, firstname
FROM student
WHERE firstname LIKE "%м__";