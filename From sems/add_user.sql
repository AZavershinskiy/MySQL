USE lesson_4;

-- ПРОЦЕДУРЫ
-- создание процедуры для добавления нового пользователя с профилем c определение COMMIT или ROLLBACK

DROP PROCEDURE IF EXISTS user_add;
DELIMITER $$ 
CREATE PROCEDURE user_add
(
	firstname VARCHAR(50), lastname VARCHAR(50), email VARCHAR(120), -- users
    phone VARCHAR(50), hometown VARCHAR(50),photo_id INT, birthday DATE,
    OUT result VARCHAR(300)
)
BEGIN
	DECLARE _rollback BIT DEFAULT 0; -- rollback - откат, commit - сохранить
    DECLARE code_error VARCHAR(45); -- код ошибки 
    DECLARE error_text VARCHAR(45); -- текст ошибки
	DECLARE CONTINUE HANDLER FOR SQLEXCEPTION
    BEGIN
		SET _rollback = 1;
        GET STACKED DIAGNOSTICS CONDITION 1
		code_error = RETURNED_SQLSTATE, error_text = MESSAGE_TEXT;
	END;
    
	START TRANSACTION; -- Начало транзакции
    
    INSERT INTO users (firstname, lastname, email)
	VALUES (firstname, lastname, email);

	INSERT INTO profiles (user_id, hometown, birthday, photo_id)
	VALUES (last_insert_id(), hometown, birthday, photo_id);

	IF _rollback THEN -- _rollback == 1
		SET result = CONCAT("Упс. Ошибка: ", code_error, " .Текст ошибки: ", error_text);
        ROLLBACK; -- Откат, так как данные не верны 
	ELSE -- _rollback = 0	
	SET result = "Ok!";
        COMMIT; -- В случае успеха, я данные сохраняю 
	END IF;
END $$
DELIMITER ;

CALL user_add
	('New', 'User', 'new_user@gmail.com', "0390131", 'Moscow', -1, '1998-01-01', @proced_result);
SELECT @proced_result;

CALL user_add
	('New', 'User', 'new_user@gmail.com', "0390131", 'Moscow', 10, '1998-01-01', @proced_result);
SELECT @proced_result;

