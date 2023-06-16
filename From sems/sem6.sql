USE lesson_3;

SELECT * FROM staff;

-- Создадим процедуру ,
-- которая будет выводить статус по ЗП 
-- от 0 до 49 999 вкл-но, то "Средняя ЗП"
-- от 50 000 вкл-но до 69 999 вкл-но, "ЗП выше средней"
-- ЗП > 70 000, то "Высокая ЗП"

-- Номер сотрудника (id), статус сотрудника (результат - в отдельной переменной)
SELECT @res_out := 5;
DROP PROCEDURE IF EXISTS get_status;
DELIMITER $$ 
CREATE PROCEDURE get_status
(
	IN staff_number INT, -- Номер человека
    OUT staff_status VARCHAR(45) -- Статус конкретного человека
)	
BEGIN
	DECLARE staff_salary DOUBLE; -- NULL
    
    SELECT salary INTO staff_salary
    FROM staff
    WHERE staff_number = id; -- 5 = 5, получаем ЗП 5 сотрудника и храним ее в staff_salary
    
    IF staff_salary BETWEEN 0 AND 49999
		THEN SET staff_status = "Средняя ЗП";
	ELSEIF staff_salary BETWEEN 50000 AND 69999
		THEN SET staff_status = "ЗП выше средней";
	ELSEIF staff_salary >= 70000
		THEN SET staff_status = "Высокая";
	END IF;
    
END $$


-- Вызов процедуры 
CALL get_status(4, @res_out);

SELECT *
FROM staff
WHERE id = 4;

SELECT @res_out;


-- Функция будет искать в-т человека
-- текущая дата и время, дату рождения человека 
SELECT NOW();

DROP FUNCTION IF EXISTS get_age;
DELIMITER $$ 
CREATE FUNCTION get_age
(
	date_bith DATE, -- 'yyyy-mm-dd': '2023-06-04'
    current_t DATETIME -- 2023-06-04 10:55:05 'yyyy-mm-dd hh:mm:ss'
)
RETURNS INT 
DETERMINISTIC 
RETURN (YEAR(current_t) - YEAR(date_bith));
DELIMITER ; 
SELECT get_age('1983-09-04', NOW()) AS "Возраст человека";


-- ПРОЦЕДУРЫ
-- создание процедуры для добавления нового пользователя с профилем c определение COMMIT или ROLLBACK

-- Создать процедуру, которая будет печатать все цифры от N до 1
-- n = 5: "5,4,3,2,1" 
DROP PROCEDURE IF EXISTS print_numbers;
DELIMITER $$
CREATE PROCEDURE print_numbers
(
	input_number INT -- N
)
BEGIN 
	DECLARE n INT; -- n = input_number
    DECLARE result VARCHAR(45) DEFAULT "";
    
    SET n = input_number;
    REPEAT
		SET result = CONCAT(result, n,",");
        SET n = n - 1;
        
        UNTIL n <= 0 -- Условие выхода из цикла
        -- Если у вас n - отр или ноль
    END REPEAT;
    SELECT result;
END $$

-- Вызов процедуры 
CALL print_numbers(7); -- N = 7

