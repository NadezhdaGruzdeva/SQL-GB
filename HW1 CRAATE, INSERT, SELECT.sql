-- lesson https://gb.ru/lessons/317996
-- seminar https://gb.ru/lessons/328110/homework

use hw1;
-- 1. Создайте таблицу с мобильными телефонами, используя графический интерфейс. 
CREATE TABLE IF NOT EXISTS phones (
  id INT PRIMARY KEY AUTO_INCREMENT,
  model VARCHAR(30) NOT NULL,
  maker VARCHAR(30) NOT NULL,
  count INT NOT NULL,
  price decimal(8,2) not NULL);

-- Заполните БД данными
INSERT INTO phones 
  (`model`, `maker`, `price`, `count`) 
VALUES 
('Galaxy S22 Ultra', 'Samsung', 91575, 2),
('Galaxy A03 4/64 Gb', 'Samsung', 7451, 100),
('Galaxy A23 4/64 Gb', 'Samsung', 12395, 50),
('Galaxy Note20 Ultra 12/256 Gb', 'Samsung', 52196, 1),
('iPhone 11 128 Gb', 'Apple', 37453, 2),
('iPhone 12 64 Gb', 'Apple', 46296, 15),
('iPhone 13 128 Gb', 'Apple', 52544, 72),
('Redmi Note 10 Pro 6/128 Gb', 'Xiaomi', 17566, 23),
('Redmi 10 2022 4/64 Gb', 'Xiaomi', 11553, 2),
('Redmi A1+ 2/32 Gb', 'Xiaomi', 5911, 88);
 
-- 2. Выведите название, производителя и цену для товаров, количество которых превышает 2
SELECT 
	model, 
	maker, 
    price
FROM 
	phones
WHERE count > 2;

-- 3. Выведите весь ассортимент товаров марки “Samsung”
SELECT 
	* 
FROM 
	phones
WHERE LOWER(maker) = 'samsung';

-- 4.1. Товары, в которых есть упоминание "Iphone"

SELECT 
	* 
FROM 
	phones
WHERE 
	LOWER(maker) LIKE '%iphone%' OR
	LOWER(model) LIKE '%iphone%';

-- 4.2. "Samsung"

SELECT 
	* 
FROM 
	phones
WHERE 
	LOWER(maker) LIKE '%Samsung%' OR
	LOWER(model) LIKE '%Samsung%';
    
-- 4.3. Товары, в которых есть ЦИФРА 8
-- не самая четкая формулировка, как и в некоторых др предыдущих пунктах))) 
-- Пусть будет "Товары, в модели которых есть ЦИФРА 8"

SELECT 
	* 
FROM 
	phones
WHERE 
	LOWER(model) LIKE '%8%';

/* 
*/  
