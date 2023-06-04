USE `lect_5_window_func`;
-- Создание таблицы
CREATE TABLE IF NOT EXISTS staff 
(
    id INT PRIMARY KEY,
    first_name VARCHAR(30),
    post VARCHAR(30),
    discipline VARCHAR(30),
    salary INT
);

-- Заполнение таблицы данными
INSERT staff (id, first_name, post, discipline, salary)
VALUES
	(100,'Антон', 'Преподаватель', 'Программирование', 50),
	(101,'Василий', 'Преподаватель', 'Программирование', 60),
	(103,'Александр', 'Ассистент', 'Программирование', 25),
	(104,'Владимир', 'Профессор', 'Математика', 120),
	(105,'Иван', 'Профессор', 'Математика', 120),
	(106,'Михаил', 'Доцент', 'Физика', 70),
	(107, 'Анна', 'Доцент', 'Физика', 70),
	(108, 'Вероника', 'Доцент', 'ИКТ', 30),
	(109,'Григорий', 'Преподаватель', 'ИКТ', 25),
	(110,'Георгий', 'Ассистент', 'Программирование', 30);
    

-- SELECT Название_функции (столбец для вычислений) 
-- OVER 
-- (
--       PARTITION BY столбец для группировки
--       ORDER BY столбец для сортировки
--       ROWS или RANGE выражение для ограничения строк в пределах группы
-- )

SELECT id, first_name, post, discipline, salary,
	SUM(salary) OVER() AS 'Sum',
	COUNT(salary) OVER() AS 'Count' 
FROM staff;


SELECT  post, discipline, salary,
	-- SUM(salary) OVER(PARTITION BY post) AS 'Sum',
	SUM(salary) OVER(PARTITION BY post ORDER BY discipline) AS 'Sum_ord',
    SUM(salary) OVER(
		PARTITION BY post 
        ORDER BY discipline
        ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS 'Sum_ord'
FROM staff;

-- Агрегатные функции SUM AVG COUNT
/*
Выведем всех сотрудников, отсортировав их по зарплатам в рамках каждой должности и рассчитаем:ALTER
Общую сумму зарплат каждой должности
Процентное соотношение каждой зарплаты к общей сумме по должности
Среднее зарплату по каждой должности
Процентное соотношение каждой зарплаты к средней зарплате по должности
*/
SELECT
id,
CONCAT(firstname, ' ',lastname) AS `fullname`,
post,
salary,
SUM(salary) OVER w AS `sum_salary`,
ROUND(salary*100/SUM(salary) OVER w) AS `percent_sum`,
AVG(salary) OVER w AS `avg_salary`,
ROUND(salary*100/AVG(salary) OVER w, 3) AS `percent_avg`
FROM staff
WINDOW w AS (PARTITION BY post);

DROP TABLE IF EXISTS academic_record;
CREATE TABLE IF NOT EXISTS academic_record (	student_name varchar(45),
	quartal  varchar(45),
    course varchar(45),
	grade int
);

INSERT INTO academic_record
VALUES	('Александр','1 четверть', 'математика', 4),
	('Александр','2 четверть', 'русский', 4),
	('Александр', '3 четверть','физика', 5),
	('Александр', '4 четверть','история', 4),
	('Антон', '1 четверть','математика', 4),
	('Антон', '2 четверть','русский', 3),
	('Антон', '3 четверть','физика', 5),
	('Антон', '4 четверть','история', 3),
    ('Петя', '1 четверть', 'физика', 4),
	('Петя', '2 четверть', 'физика', 3),
	('Петя', '3 четверть', 'физика', 4),
	('Петя', '4 четверть', 'физика', 5);

-- Получить с помощью оконных функции:
-- 1. Средний балл ученика
USE `lect_5_window_func`;
SELECT
	*,
    AVG(grade) OVER w AS `avg_grade`
FROM
	academic_record
WINDOW w AS (PARTITION BY student_name)
    
-- 2. Наименьшую оценку ученика
SELECT
	*,
    MIN(grade) OVER w AS `min_grade`
FROM
	academic_record
WINDOW w AS (PARTITION BY student_name)

-- 3. Наибольшую оценку ученика
SELECT
	*,
    MAX(grade) OVER w AS `max_grade`
FROM
	academic_record
WINDOW w AS (PARTITION BY student_name)
-- 4. Выведите всех
USE `lect_5_window_func`;
SELECT DISTINCT
	student_name,
    AVG(grade) OVER w AS `avg_grade`,
    MIN(grade) OVER w AS `min_grade`,
    MAX(grade) OVER w AS `max_grade`
FROM
	academic_record
WINDOW w AS (PARTITION BY student_name);


DROP TABLE IF EXISTS teacher;
CREATE TABLE IF NOT EXISTS teacher
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
    
SELECT * from teacher; 

DROP TABLE IF EXISTS lesson;
CREATE TABLE IF NOT EXISTS lesson
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
    ("Базы данных и SQL",4);
    
DROP TABLE IF EXISTS summer_medals;
CREATE TABLE IF NOT EXISTS summer_medals 
(
	year INT,
    city VARCHAR(45),
    sport VARCHAR(45),
    discipline VARCHAR(45),
    athlete VARCHAR(45),
    country VARCHAR(45),
    gender VARCHAR(45),
    event VARCHAR(45),
    medal VARCHAR(45)
);

SELECT *
FROM summer_medals;
INSERT summer_medals
VALUES
	(1896, "Athens", "Aquatics", "Swimming", "HAJOS ALfred", "HUN", "Men","100M Freestyle", "Gold"),
	(1896, "Athens", "Archery", "Swimming", "HERSCHMANN Otto", "AUT", "Men","100M Freestyle", "Silver"),
    (1896, "Athens", "Athletics", "Swimming", "DRIVAC Dimitros", "GRE", "Men","100M Freestyle For Saliors", "Bronze"),
    (1900, "Athens", "Badminton", "Swimming", "MALOKINIS Ioannis", "GRE", "Men","100M Freestyle For Saliors", "Gold"),
    (1896, "Athens", "Aquatics", "Swimming", "CHASAPIS Spiridon", "GRE", "Men","100M Freestyle For Saliors", "Silver"),
    (1896, "Athens", "Aquatics", "Swimming", "CHOROPHAS Elfstathios", "GRE", "Men","1200M Freestele", "Bronze"),
    (1905, "Athens", "Aquatics", "Swimming", "HAJOS ALfred", "HUN", "Men","100M Freestyle For Saliors", "Gold"),
    (1896, "Athens", "Aquatics", "Swimming", "ANDREOU Joannis", "GRE", "Men","1200M Freestyle", "Silver"),
    (1896, "Athens", "Aquatics", "Swimming", "CHOROPHAS Elfstathios", "GRE", "Men","400M Freestyle", "Bronze");

-- 1.	Выберите имеющиеся виды спорта и пронумеруем их в алфавитном порядке

USE `lesson_5`;
SELECT
	row_number() OVER(order by sport) as num,
    sport
FROM
	summer_medals
    
-- 2.	Создайте представление, в которое попадает информация о спортсменах (страна, пол, имя)
-- CREATE OR REPLACE VIEW sportsmen AS
ALTER VIEW sportsmen AS
SELECT
	athlete, country, gender
FROM summer_medals
ORDER BY athlete;


-- 3.Создайте представление, в котором будет храниться информация о спортсменах по конкретному виду спорта (Aquatics)
CREATE OR REPLACE VIEW Aquatics_only AS
SELECT
	*
FROM
	summer_medals
WHERE
	sport = 'Aquatics'