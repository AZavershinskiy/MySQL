-- Single line comment, after "--" need space
# Single line comment
/*
 Multiline 
 Comment
 */
-- snake_case - names COLUMNS, TABLE, DATABASE

-- 1. Create database
CREATE DATABASE
    IF NOT EXISTS lesson_1; -- CREATE DATABASE lesson_1 IF DOES NOT EXIST
-- 1.1 Delete database
# DROP DATABASE IF EXISTS lesson_1 -- DELETE DATABASE lesson_1 IF EXIST

-- 2. Database connection
USE lesson_1;

# interaction with lesson_1 DATABASE
-- 3. Create the table: student
DROP TABLE IF EXISTS student;

-- DROP TABLE student IF it EXISTS
CREATE TABLE
    student (
        -- name_column type_data restrictions
        id INT PRIMARY KEY AUTO_INCREMENT,
        firstname VARCHAR(45),
        email VARCHAR(45),
        phone VARCHAR(45)
    );
ALTER TABLE
    student -- Edit the TABLE student
    AUTO_INCREMENT = 10; -- AUTO_INCREMENT starts at 100

-- 4. Fill the table with data
INSERT
    student(firstname, email, phone)
VALUES ('Andrew','12345@gmail.com','+7-987-654-32-10'), -- id = 0 
    ('Anatoliy', '12345@gmail.com','+7-111-111-11-11'), -- id = 1 
    ('Alex', '12345@gmail.com','+7-222-222-22-22'), -- id = 2 
    ('Anastasiya','12345@gmail.com','+7-333-333-33-33'), -- id = 3 
    ('Victoriya','12345@gmail.com','+7-444-444-44-44'), -- id = 4 
    ('Vladimir','12345@gmail.com','+7-555-555-55-55'); -- id = 5

-- 5. Display tables
SELECT * FROM student; -- Bad taste (don't do that)

-- 6. Display a limited number of columns (firstname and email)
SELECT firstname, email FROM student;

-- 7. Get the phone and email of a student named Andrew
SELECT phone, email, firstname
FROM student
WHERE firstname = 'Andrew';
DESCRIBE student; -- TABLE COLUMNS analytics of the TABLE student

-- 8. Get student phones and emails without Andrew
SELECT phone, email, firstname
FROM student
WHERE firstname <> 'Andrew'; -- "<>" or "!=" - same

-- 9. Display a list of all students whose names start with 'A'
SELECT
    id,
    phone,
    email,
    firstname
FROM student
WHERE firstname LIKE 'a%';