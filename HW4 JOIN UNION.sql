USE `hw4_cats`;
-- Используя JOIN-ы, выполните следующие операции:
-- 1.Вывести всех котиков по магазинам по id (условие соединения shops.id = cats.shops_id)
SELECT
	cats.id AS ID_cat,
    name,
    COALESCE(shopname, 'не определено') -- на случай если в правой таблице NULL
FROM
	cats
LEFT JOIN
	shops
ON shops.id = cats.shops_id;

-- 2.Вывести магазин, в котором продается кот “Мурзик” (попробуйте выполнить 2 способами)
SELECT
    shopname
FROM
	shops
JOIN
	cats
ON shops.id = cats.shops_id
WHERE 
	name = 'Murzik';
------------------------------------------------
SELECT
    shopname
FROM
	shops
WHERE shops.id IN (
	SELECT
		shops_id
	FROM 
		cats
	WHERE 
		name = 'Murzik');
	
-- 3.Вывести магазины, в которых НЕ продаются коты “Мурзик” и “Zuza”

-- не продают ни “Мурзик”, ни “Zuza”

SELECT
    shopname
FROM
	shops
WHERE shops.id NOT IN (
	SELECT
		shops_id
	FROM 
		cats
	WHERE 
		name = 'Murzik' OR name = 'Zuza');

-- Табличка (после слов “Последнее задание, таблица:”)
-- 4.Вывести название и цену для всех анализов, которые продавались 5 февраля 2020 и всю следующую неделю.
SELECT
	ord_datetime,
    an_name,
    an_price 
FROM
	analysis
JOIN
	orders
ON analysis.an_id = orders.ord_an
WHERE 
	ord_datetime between '2020-02-05 00:00:00' AND '2020-03-12 23:59:59' -- 8 полных дней
order by 
	ord_datetime

-- Дополнительно выведем название группы, общую сумму продаж, себестоимость и маржу по видам анализов
SELECT
    groupsan.gr_name,
    an_name,
    sum(an_price) AS sales_sum,
    sum(an_cost) AS cost,
    sum(an_price) - sum(an_cost) AS margin
FROM
	analysis
JOIN
	orders
ON analysis.an_id = orders.ord_an
LEFT JOIN
	groupsan
ON analysis.an_group = groupsan.gr_id
WHERE 
	ord_datetime between '2020-02-05 00:00:00' AND '2020-03-12 23:59:59' -- 8 полных дней
group by 
    groupsan.gr_name,
    an_name
order by 
    groupsan.gr_name,
    an_name
    