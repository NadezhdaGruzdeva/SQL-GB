-- лекция https://gb.ru/lessons/317998
-- семинар https://gb.ru/lessons/328112


use lesson3;

-- Условие по таблице staff:

-- Отсортируйте данные по полю заработная плата (salary) в порядке: убывания; возрастания
-- возрастания
select
	*
from
	staff
order by 
	salary;

-- возрастания
select
	*
from
	staff
order by 
	salary;
    
-- возрастания
select
	*
from
	staff
order by 
	salary;

-- убывания
select
	*
from
	staff
order by 
	salary DESC;

-- Выведите 5 максимальных заработных плат (salary)
select
	salary
from
	staff
order by 
	salary DESC
limit 5;

-- Посчитайте суммарную зарплату (salary) по каждой специальности (роst)
select
	post,
    sum(salary)
from
	staff
group by 
	post;

-- Найдите кол-во сотрудников с специальностью (post) «Рабочий» в возрасте от 24 до 49 лет включительно.
select
    count(*)
from
	staff
where
	post = 'Рабочий' and
    age between 24 and 49; -- включительно

-- Найдите количество специальностей
select 
	count(distinct post)
from
	staff

-- Выведите специальности, у которых средний возраст сотрудников меньше 30 лет
select
	post
from
	staff
group by 
	post
having
	avg(age) < 30;