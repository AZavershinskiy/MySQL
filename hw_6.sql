CREATE DATABASE IF NOT EXISTS hw_6;
USE hw_6;

/*
1.Создайте функцию, которая принимает кол-во сек и форматирует их в кол-во дней, часов, минут и секунд.
Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds'
*/
-- Создание функции:
DROP FUNCTION IF EXISTS sec_to_date;
DELIMITER //
CREATE FUNCTION sec_to_date(seconds_input INT)
	RETURNS VARCHAR(100) DETERMINISTIC
	BEGIN
		DECLARE result VARCHAR(100);
        DECLARE weeks INT;
		DECLARE days INT;
		DECLARE hours INT;
		DECLARE minutes INT;
		DECLARE sec_rem INT; -- sec_rem - remaining seconds

        IF 86400 <= seconds_input 
            THEN
                SET days = seconds_input DIV 86400;
                SET sec_rem = seconds_input % 86400;
                SET hours = sec_rem DIV 3600;
                SET sec_rem = sec_rem % 3600;
                SET minutes = sec_rem DIV 60;
                SEt sec_rem = sec_rem % 60;
                SET result = CONCAT(seconds_input,' seconds -> ',days,' days, ',hours,' hours, ',minutes,' minutes, ',sec_rem,' seconds');
        ELSEIF 3600 <= seconds_input AND seconds_input < 86400
            THEN
                SET hours = seconds_input DIV 3600;
                SET sec_rem = seconds_input % 3600;
                SET minutes = sec_rem DIV 60;
                SEt sec_rem = sec_rem % 60;
                SET result = CONCAT(seconds_input,' seconds -> ',hours,' hours, ',minutes,' minutes, ',sec_rem,' seconds');
        ELSEIF 60 <= seconds_input AND seconds_input < 3600
            THEN
                SET minutes = seconds_input DIV 60;
                SEt sec_rem = seconds_input % 60;
                SET result = CONCAT(seconds_input,' seconds -> ',minutes,' minutes, ',sec_rem,' seconds');
        ELSE 
            SET result = CONCAT(seconds_input,' seconds -> ',seconds_input,' seconds');
		END IF;
        
	RETURN result;
	END//
DELIMITER ;
-- Вызов функции:
SELECT sec_to_date(123456);


/*
2. Выведите только четные числа от 1 до 10 (Через цикл).
Пример: 2,4,6,8,10
*/
DROP PROCEDURE IF EXISTS print_even_numbers;
DELIMITER $$
CREATE PROCEDURE print_even_numbers
(
	input_number INT
)
BEGIN 
	DECLARE n INT DEFAULT 2; 
    DECLARE result VARCHAR(100) DEFAULT '2';
    DECLARE title VARCHAR(45);

    IF input_number > 3 THEN
        REPEAT
            SET n = n + 2;
            SET result = CONCAT(result,', ',n);

            UNTIL n > input_number - 2
        END REPEAT;
        SELECT result;
    ELSEIF input_number = 2 OR input_number = 3 THEN
        SET result = '2';
        SELECT result;
    ELSE 
        SET result = 'Input error';
        SELECT result;
    END IF;
END $$
DELIMITER ;

CALL print_even_numbers(10);