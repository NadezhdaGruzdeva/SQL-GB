DROP DATABASE IF EXISTS HW5;
CREATE DATABASE HW5;
USE HW5;

CREATE TABLE cars
(
	id INT NOT NULL PRIMARY KEY,
    name VARCHAR(45),
    cost INT
);

INSERT cars
VALUES
	(1, "Audi", 52642),
    (2, "Mercedes", 57127 ),
    (3, "Skoda", 9000 ),
    (4, "Volvo", 29000),
	(5, "Bentley", 350000),
    (6, "Citroen ", 21000 ), 
    (7, "Hummer", 41400), 
    (8, "Volkswagen ", 21600);
    

-- 1. Создайте представление, в которое попадут автомобили стоимостью до 25 000 долларов
CREATE OR REPLACE VIEW econom_cars AS
SELECT
	*
FROM
	cars
WHERE
	cost < 25000;
    
-- 2. Изменить в существующем представлении порог для стоимости: пусть цена будет до 30 000 долларов (используя оператор ALTER VIEW)
ALTER VIEW econom_cars AS
SELECT
	*
FROM
	cars
WHERE
	cost < 30000;

-- 3. Создайте представление, в котором будут только автомобили марки “Шкода” и “Ауди”
CREATE OR REPLACE VIEW Skoda_Audi_cars AS
SELECT
	*
FROM
	cars
WHERE
	name = 'Skoda' or
    name = 'Audi';