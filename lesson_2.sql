SHOW DATABASES; # disolay list DATABASES

CREATE DATABASE IF NOT EXISTS lesson_2;

USE lesson_2;

CREATE TABLE
    IF NOT EXISTS movie (
    id INT PRIMARY KEY AUTO_INCREMENT, # PRIMARY KEY = UNIQUE NOT NULL
    title VARCHAR (45) NOT NULL, 
    title_eng VARCHAR (45), 
    release_year INT, # YYYY: 2023
    duration_min INT, 
    storyline TEXT
    );

DESCRIBE movie;

INSERT INTO movie (title, title_eng, release_year, duration_min, storyline)
VALUES
    ('Игры разума', 'A Beautiful Mind', 2001, 135,'От всемирной известности до греховных глубин — все это познал на своей шкуре Джон Форбс Нэш-младший. Математический гений, он на заре своей карьеры сделал титаническую работу в области теории игр, которая перевернула этот раздел математики и практически принесла ему международную известность. Однако буквально в то же время заносчивый и пользующийся успехом у женщин Нэш получает удар судьбы, который переворачивает уже его собственную жизнь.'),
    ('Форрест Гамп', 'Forrest Gump', 1994, 142, 'Сидя на автобусной остановке, Форрест Гамп — не очень умный, но добрый и открытый парень — рассказывает случайным встречным историю своей необыкновенной жизни. С самого малолетства парень страдал от заболевания ног, соседские мальчишки дразнили его, но в один прекрасный день Форрест открыл в себе невероятные способности к бегу. Подруга детства Дженни всегда его поддерживала и защищала, но вскоре дороги их разошлись.'),
    ('Иван Васильевич меняет профессию', NULL, 1998, 128,'Инженер-изобретатель Тимофеев сконструировал машину времени, которая соединила его квартиру с далеким шестнадцатым веком - точнее, с палатами государя Ивана Грозного. Туда-то и попадают тезка царя пенсионер-общественник Иван Васильевич Бунша и квартирный вор Жорж Милославский. На их место в двадцатом веке «переселяется» великий государь. Поломка машины приводит ко множеству неожиданных и забавных событий...'),
    ('Назад в будущее', 'Back to the Future', 1985, 116, 'Подросток Марти с помощью машины времени, сооружённой его другом-профессором доком Брауном, попадает из 80-х в далекие 50-е. Там он встречается со своими будущими родителями, ещё подростками, и другом-профессором, совсем молодым.'),
    ('Криминальное чтиво', 'Pulp Fiction', 1994, 154, NULL);

SELECT id, title, title_eng, release_year, duration_min, storyline FROM movie; 

/*
DML: 
    INSERT, 
    DELETE, 
    UPDATE, 
    SELECT

DDL: 
    CREATE, 
    DROP, 
    ALTER, 
    RENAME, 
    TRUNCATE (clearing the TABLE from the data, only the COLUMN names remain)
*/

RENAME TABLE movie TO film;

SHOW FULL TABLES;

ALTER TABLE film
ADD test INT DEFAULT 100, # All ROWS in the test COLUMN are equal to the VALUE 100
ADD price INT DEFAULT 250;
SELECT * FROM film;


ALTER TABLE film
DROP test;
SELECT * FROM film;


UPDATE film
SET price = price + 150 # 250 + 150 (price = 400)
WHERE title = 'Иван Васильевич меняет профессию';
SELECT * FROM film;


DELETE FROM film
WHERE title = 'Криминальное чтиво';
SELECT * FROM film;

-- ADD a new COLUMN that will store the payment status: 1 - payment on the site, 0 - not paid online
ALTER TABLE film
ADD payment_status INT;
SELECT * FROM film;

UPDATE film SET payment_status = RAND(); #Range 0 to 1
SELECT * FROM film;

-- SELECT FLOOR(RAND() * 100 - RAND() * RAND()*5); # FLOOR - Rounding down (CEILING - Rounding up)


SELECT
    id AS 'Number',
    title AS 'Name',
    payment_status AS 'Payment status', # precede CASE with a comma
CASE 
    WHEN payment_status = 0
        THEN 'Not paid, need to pay'
    WHEN payment_status = 1
        THEN 'Paid'
    ELSE 'Payment error' # payment_status != 0 and payment_status != 1
END AS 'Comment'
FROM film;


-- IF (condition, true value, false value)
SELECT IF (200 > 100, '+', '-') AS 'result';

-- Type of film:
-- up to 50 minutes - short film
-- 50 - 140 -  medium-length film
-- 141 - 150 - full-length film
-- 151+ - we don't go to the cinema

SELECT
    title AS 'Film name',
    duration_min AS 'Duration',
    IF(duration_min < 50, 'Shorts',
        IF(duration_min < 140, 'Medium-length',
            IF(duration_min <= 150, 'Full-length', "We don't go to the cinema")))
    AS 'Type film'
FROM film;