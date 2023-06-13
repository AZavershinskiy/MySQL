DROP DATABASE IF EXISTS lesson_4;
CREATE DATABASE lesson_4;
USE lesson_4;

CREATE TABLE teacher 
(
    id INT NOT NULL PRIMARY KEY, 
    surname VARCHAR(45), 
    salary INT
);

INSERT teacher
VALUES
    (1, 'Авдеев', 17000),
    (2, 'Гущенко', 27000),
    (3, 'Пчелкин', 32000),
    (4, 'Питошин', 15000),
    (5, 'Вебов', 45000),
    (6, 'Шарпов', 30000),
    (7, 'Шарпов', 40000),
    (8, 'Питошин', 30000);

DROP TABLE IF EXISTS lesson;

CREATE TABLE lesson 
(
    id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id) REFERENCES teacher (id)
);

INSERT INTO lesson (course, teacher_id)
VALUES
    ('Знакомство с веб-технологиями', 1),
    ('Знакомство с веб-технологиями', 2),
    ('Знакомство с языками программирования', 3),
    ('Базы данных и SQL', 4),
    ('Нейронные сети', NULL),
    (NULL, 5); -- учитель, который ведет данный предмет, временно отстутствует

SELECT * FROM lesson;

-- Get the names of teachers and the courses they teach
SELECT 
    t.id, -- t = teacher
    t.surname, 
    l.teacher_id, -- l - lesson
    l.course 
FROM teacher t
JOIN lesson l -- INNER JOIN = JOIN
ON t.id = l.teacher_id AND t.surname != 'Вебов';

-- Get the names of ALL teachers and the courses they teach
SELECT 
    t.surname,
    l.course
FROM teacher t
LEFT JOIN lesson l
ON t.id = l.teacher_id;

-- Get the names of ALL teachers who do not teach lessons
SELECT
    t.id,
    t.surname,
    l.teacher_id,
    l.course
FROM teacher t
LEFT JOIN lesson l
ON t.id = l.teacher_id
WHERE l.course IS NULL;

-- Get info about teachers who teach "Веб-технологии"
SELECT 
    t.surname,
    l.course
FROM teacher t
LEFT JOIN lesson l
ON t.id = l.teacher_id
WHERE l.course LIKE '%веб%';

-- SUBQUERY
/*
SELECT
    id,
    <SUBQUERY>
FROM
    <SUBQUERY>
WHERE
    <SUBQUERY>
GROUP BY
    id
HAVING
    <SUBQUERY>
*/
SELECT
    t.*,
    web_lesson.* -- course, teacher_id
FROM teacher t
JOIN (SELECT course, teacher_id 
    FROM lesson 
    WHERE course LIKE '%веб%') AS web_lesson
ON t.id = web_lesson.teacher_id;
-- OR
SELECT
    t.*,
    wl.* -- course, teacher_id
FROM (SELECT course, teacher_id 
    FROM lesson 
    WHERE course LIKE '%веб%') AS wl
JOIN teacher t
ON t.id = wl.teacher_id;