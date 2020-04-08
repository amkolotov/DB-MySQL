USE example;

SHOW TABLES;


-- Операторы 1

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR (255) COMMENT 'Пользователи',
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL
);

INSERT INTO users (name) VALUES 
  ('Alexander'), 
  ('Nikolay'),
  ('Ivan');

UPDATE users SET created_at = NOW(), updated_at = NOW();
 
SELECT * FROM users;



-- Операторы 2

DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at VARCHAR(255),
  updated_at VARCHAR(255)
);

INSERT INTO users (name, created_at, updated_at) VALUES 
  ('Alexander', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Nikolay', '20.10.2017 8:10', '20.10.2017 8:10'),
  ('Ivan', '20.10.2017 8:10', '20.10.2017 8:10');

SELECT * FROM users;

DROP TABLE IF EXISTS users_new;

CREATE TABLE users_new (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  created_at DATETIME DEFAULT NULL,
  updated_at DATETIME DEFAULT NULL);
  
INSERT INTO users_new (id, name, created_at, updated_at)
  SELECT
  id,
  name,
  STR_TO_DATE(created_at, '%d.%m.%Y %H:%i'),
  STR_TO_DATE(updated_at, '%d.%m.%Y %H:%i')
  FROM users;

SELECT * FROM users_new;

DROP TABLE users;

ALTER TABLE users_new RENAME users;

SELECT * FROM users;



-- Операторы 3

DROP TABLE IF EXISTS storehouses_products;

CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  name VARCHAR (255),
  value INT UNSIGNED
);

INSERT INTO storehouses_products (name, value) VALUES 
  ('Intel Core i3-8100', 0),
  ('Intel Core i5-7400', 2500),
  ('AMD FX-8320E', 30),
  ('AMD FX-8320', 0),
  ('ASUS ROG MAXIMUS X HERO', 50),
  ('Gigabyte H310M S2H', 70),
  ('MSI B250M GAMING PRO', 1);

SELECT * FROM storehouses_products;

-- Попробовал дв варианта но не понял как вывести нулевые значения в конце
SELECT * FROM storehouses_products WHERE value != 0
  UNION 
  SELECT * FROM storehouses_products WHERE value = 0
  ORDER BY value;
 
SELECT * FROM storehouses_products
  ORDER BY CASE
  WHEN value != 0 THEN 1
  WHEN value = 0 THEN 2
  END;
 
  
 
-- Операторы 4
 
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at VARCHAR(255)
);

INSERT INTO users (name, birthday_at) VALUES 
  ('Alexander', '25 may 1998'),
  ('Nikolay', '10 august 2000'),
  ('Ivan', '25 september 1982');
 
SELECT name, birthday_at FROM users WHERE birthday_at LIKE '%august%' OR birthday_at LIKE '%may%';


-- Операторы 5

DROP TABLE IF EXISTS catalogs;

CREATE TABLE catalogs (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255)
);

INSERT INTO catalogs (name) VALUES 
  ('Процессоры'),
  ('Материнские платы'),
  ('Оперативная память'),
  ('Видеокарты'),
  ('Жесткие диски');

SELECT * FROM catalogs;

SELECT * FROM catalogs WHERE id IN (5, 1, 2)
  ORDER BY CASE
  WHEN id = 5 THEN 1
  WHEN id = 1 THEN 2
  WHEN id = 2 THEN 3
  END;

 
 
-- Агрегация данных 1
 
DROP TABLE IF EXISTS users;

CREATE TABLE users (
  id SERIAL PRIMARY KEY,
  name VARCHAR(255),
  birthday_at VARCHAR(255)
);

INSERT INTO users (name, birthday_at) VALUES 
  ('Alexander', '1982-10-15'),
  ('Nikolay', '1990-01-25'),
  ('Ivan', '1970-03-09'),
  ('Denis', '1990-01-25');

SELECT * FROM users;

SELECT 
  ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) AS avg_age
  FROM users;
 
 
 -- Агрегация данных 2
 
-- не понял как применить функцию COUNT к дням недели
SELECT 
  DAYNAME(CONCAT('2020-', DATE_FORMAT(birthday_at, '%m-%d'))) AS week_day
  FROM users
  GROUP BY week_day;


 
-- Агрегация данных 3 
 
DROP TABLE IF EXISTS storehouses_products;

CREATE TABLE storehouses_products (
  id SERIAL PRIMARY KEY,
  name VARCHAR (255),
  value INT UNSIGNED
);

INSERT INTO storehouses_products (name, value) VALUES 
  ('Intel Core i3-8100', 1),
  ('Intel Core i5-7400', 2),
  ('AMD FX-8320E', 3),
  ('AMD FX-8320', 4),
  ('ASUS ROG MAXIMUS X HERO', 5);  

SELECT * FROM storehouses_products;

SELECT EXP(SUM(LOG(value))) FROM storehouses_products;
