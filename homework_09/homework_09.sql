-- 1.1. В базе данных shop и sample присутствуют одни и те же таблицы, учебной базы данных. Переместите запись id = 1 из таблицы shop.users в таблицу sample.users. Используйте транзакции.

CREATE DATABASE sample;

USE sample;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

START TRANSACTION;

INSERT INTO sample.users SELECT * FROM shop.users WHERE id = 1;

COMMIT;

SELECT * FROM sample.users;



-- 1.2. Создайте представление, которое выводит название name товарной позиции из таблицы products и соответствующее название каталога name из таблицы catalogs.

USE shop;

CREATE OR REPLACE VIEW prod AS
SELECT p.name AS product_name, c.name AS catalog_name
  FROM products p
JOIN
  catalogs c
ON p.catalog_id = c.id;

SELECT * FROM prod;

-- 3.1. Создайте хранимую функцию hello(), которая будет возвращать приветствие, в зависимости от текущего времени суток. С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро", с 12:00 до 18:00 функция должна возвращать фразу "Добрый день", с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

DELIMITER //
DROP FUNCTION IF EXISTS hello//
CREATE FUNCTION hello()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	IF (TIME(NOW()) BETWEEN '06:00:00' AND '11:59:59') THEN
	  RETURN 'Доброе утро';
	ELSEIF (TIME(NOW()) BETWEEN '12:00:00' AND '17:59:59') THEN
	  RETURN 'Добрый день';
	ELSEIF (TIME(NOW()) BETWEEN '18:00:00' AND '23:59:59') THEN
	  RETURN 'Добрый вечер';
	ELSE
	  RETURN 'Доброй ночи';
	END IF;
END//

-- 3.2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

CREATE TRIGGER update_notnull BEFORE UPDATE ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.desription IS NULL THEN
	  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'UPDATE canceled';
	END IF;
END//

CREATE TRIGGER insert_notnull BEFORE INSERT ON products
FOR EACH ROW 
BEGIN 
	IF NEW.name IS NULL AND NEW.desription IS NULL THEN
	  SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'INSERT canceled';
	END IF;
END//


