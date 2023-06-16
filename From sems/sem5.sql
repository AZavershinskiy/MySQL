USE lesson_3;

SELECT * FROM staff;

-- Ранжирование 
-- Вывести список всех сотрудников и указать место в рейтинге по ЗП
SELECT 
	salary, 
    post,
    CONCAT(firstname, " ", lastname) AS fullname,
    DENSE_RANK() OVER(ORDER BY salary DESC) AS `dense_rank`
FROM staff;

-- Ранжирование 
-- Вывести список всех сотрудников и указать место в рейтинге по ЗП
-- Но по каждой специальности 
SELECT 
	salary, 
    post,
    CONCAT(firstname, " ", lastname) AS fullname,
    DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
FROM staff;

-- Найдите самых высокооплачиваемых сотрудников в каждой специальности
SELECT
	salary, 
    post,
	fullname,
    `dense_rank`
FROM (SELECT 
	salary, 
    post,
    CONCAT(firstname, " ", lastname) AS fullname,
    DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
FROM staff) rank_salary
WHERE `dense_rank` = 1;

-- ТОП2 самых высокооплачиваемых сотрудников в каждой специальности:
SELECT
	salary, 
    post,
	fullname,
    `dense_rank`
FROM (SELECT 
	salary, 
    post,
    CONCAT(firstname, " ", lastname) AS fullname,
    DENSE_RANK() OVER(PARTITION BY post ORDER BY salary DESC) AS `dense_rank`
FROM staff) rank_salary
WHERE `dense_rank` IN (1,2); -- dense_rank = 1 OR dense_rank = 2

-- Агрегация 
-- Вывести по должностям:
-- суммарную ЗП 
-- среднюю ЗП 
-- процентное соотношение отдельно взятой ЗП к суммарной ЗП по должности
SELECT
	salary, 
    post,
    CONCAT(firstname, " ", lastname) AS fullname,
    SUM(salary) OVER w AS sum_salary, -- w = (PARTITION BY post)
	ROUND(AVG(salary) OVER w, 2) AS avg_salary,
	ROUND(salary * 100 / SUM(salary) OVER w,  2) AS percent_sum_salary
FROM staff
WINDOW w AS (PARTITION BY post);

SELECT
	salary, 
    post,
    CONCAT(firstname, " ", lastname) AS fullname,
	ROUND(AVG(salary) OVER w, 2) AS salary_avg
FROM staff
WINDOW w AS (
	ORDER BY salary DESC
    ROWS BETWEEN 1 PRECEDING AND 
    1 FOLLOWING -- Между 1 предыдущей и 1 следующей (-1 0 1)
);    

-- представления 
SELECT
	COUNT(*) AS count_staff,
    post, 
    ROUND(AVG(salary), 2) AS `avg`
FROM staff
GROUP BY post
ORDER BY count_staff;

CREATE OR REPLACE VIEW count_post
AS
SELECT
	COUNT(*) AS count_staff,
    post, 
    ROUND(AVG(salary), 2) AS `avg`
FROM staff
GROUP BY post
ORDER BY count_staff;

SELECT * -- count_staff, post, avg
FROM count_post;