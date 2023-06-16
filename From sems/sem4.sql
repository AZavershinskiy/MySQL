DROP DATABASE IF EXISTS lesson_4;
CREATE DATABASE lesson_4;
USE lesson_4;
DROP TABLE IF EXISTS teacher;
CREATE TABLE teacher
(	
	id INT NOT NULL PRIMARY KEY,
    surname VARCHAR(45),
    salary INT
);

INSERT teacher
VALUES
	(1,"Авдеев", 17000),
    (2,"Гущенко",27000),
    (3,"Пчелкин",32000),
    (4,"Питошин",15000),
    (5,"Вебов",45000),
    (6,"Шарпов",30000),
    (7,"Шарпов",40000),
    (8,"Питошин",30000);
    

DROP TABLE IF EXISTS lesson;
CREATE TABLE lesson
(	
	id INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    course VARCHAR(45),
    teacher_id INT,
    FOREIGN KEY (teacher_id)  REFERENCES teacher(id)
);
INSERT INTO lesson(course,teacher_id)
VALUES
	("Знакомство с веб-технологиями",1),
    ("Знакомство с веб-технологиями",2),
    ("Знакомство с языками программирования",3),
    ("Базы данных и SQL",4),
    ("Нейронные сети", NULL),
    (NULL, 5); -- Учитель, который ведет данный предмет, временно отстутствует


-- Получим фамилии учителей и курсы, которые они ведут
SELECT 
	t.surname, 
    l.course, -- t = teacher, l = lesson
    l.teacher_id,
    t.id
FROM teacher t -- t = teacher,
JOIN lesson l -- INNER JOIN = JOIN, l = lesson
ON t.id = l.teacher_id;

-- Получим фамилии ВСЕХ учителей и курсы, которые они ведут
SELECT
	t.surname,
    l.course
FROM teacher t
LEFT JOIN lesson l
ON t.id = teacher_id;

--  Получим фамилии  учителей, которые НЕ ВЕДУТ уроки
SELECT
	t.surname, 
    l.course, -- t = teacher, l = lesson
    l.teacher_id,
    t.id
FROM teacher t
LEFT JOIN lesson l
ON t.id = l.teacher_id
WHERE l.teacher_id IS NULL;

-- Получим инфо о учителях, которые ведут "Веб-технологии"
SELECT 
	t.surname, 
    l.course, -- t = teacher, l = lesson
    l.teacher_id,
    t.id
FROM teacher t -- t = teacher,
JOIN lesson l -- INNER JOIN = JOIN, l = lesson
ON t.id = l.teacher_id 
WHERE l.course = "Знакомство с веб-технологиями";
    
    
-- Подзапрос 
SELECT
	t.*,
    web_lesson.* -- course, teacher_id
FROM teacher t 
JOIN (SELECT course, teacher_id FROM lesson 
WHERE course = "Знакомство с веб-технологиями") web_lesson
ON t.id = web_lesson.teacher_id;

-- Подзапрос 
SELECT
	t.*,
    web_lesson.* -- course, teacher_id
FROM (SELECT course, teacher_id FROM lesson 
WHERE course = "Знакомство с веб-технологиями") web_lesson
JOIN teacher t 
ON t.id = web_lesson.teacher_id; 