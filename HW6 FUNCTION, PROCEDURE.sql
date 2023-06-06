USE lesson6;
-- 1.  процедуру, которая принимает кол-во сек и формат их в кол-во дней часов. 
-- Пример: 123456 ->'1 days 10 hours 17 minutes 36 seconds '
DROP PROCEDURE proc3;

DELIMITER //
CREATE PROCEDURE proc3(sec INT)
	BEGIN
		CASE
			WHEN sec BETWEEN 0 AND 59 THEN
				SELECT CONCAT(sec, ' seconds');
 			WHEN sec BETWEEN 60 AND 3599 THEN
 				SELECT  CONCAT(sec DIV 60, ' minutes ',sec % 60, ' seconds');
 			WHEN sec BETWEEN 3600 AND 86400 THEN
				SELECT  CONCAT(sec DIV 3600, ' hours ', (sec % 3600) DIV 60, ' minutes ',sec % 60, ' seconds');
			ELSE
				SELECT  CONCAT(sec DIV 86400, ' days ', (sec % 86400) DIV 3600, ' hours ', 
							(sec % 7200) DIV 60, ' minutes ',sec % 60, ' seconds');
		END CASE;
	END //
    DELIMITER ;
    
    CALL proc3(95450);

-- 2. Создайте функцию, которая выводит только четные числа от 1 до 10. 
-- Пример: 2,4,6,8,10 
DROP FUNCTION even_list;

DELIMITER //
CREATE FUNCTION even_list(start INT, finish int)
RETURNS VARCHAR(1000)
DETERMINISTIC
BEGIN 
DECLARE iterations INT DEFAULT 1; 
DECLARE even INT DEFAULT 0; 
DECLARE result VARCHAR(1000) DEFAULT '0';
IF start % 2 = 0 THEN
	SET even = start;
ELSE 
	SET even = start + 1;
END IF;
SET iterations = (finish - start) DIV 2;
SET result = even;
WHILE iterations > 0
DO        
	SET even = even + 2;
	SET result = CONCAT(result, ', ', even);
	SET iterations = iterations - 1;
END WHILE;
 RETURN result;
 END //
 delimiter ;
 
 select even_list(1, 10);
