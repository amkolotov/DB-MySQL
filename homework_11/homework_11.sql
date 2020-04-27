-- 9.1 

USE shop;

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
  create_writes DATETIME DEFAULT CURRENT_TIMESTAMP,
  table_name VARCHAR(255),
  id_table INT UNSIGNED,
  column_name VARCHAR(255)
) ENGINE=Archive;

DELIMITER //
CREATE TRIGGER insert_users AFTER INSERT ON users
FOR EACH ROW  
BEGIN 
  INSERT INTO logs
    SET table_name = 'users', id_table = NEW.id, column_name = NEW.name;
END//

INSERT INTO users (name) VALUES ('Anna');

SELECT * FROM logs;

CREATE TRIGGER insert_catalogs AFTER INSERT ON catalogs
FOR EACH ROW 
BEGIN 
	INSERT INTO logs 
	  SET table_name = 'catalogs', id_table = NEW.id, column_name = NEW.name;
END//

INSERT INTO catalogs (name) VALUES ('differents');

SELECT * FROM logs;

CREATE TRIGGER insert_products AFTER INSERT ON products
FOR EACH ROW 
BEGIN 
	INSERT INTO logs 
	  SET table_name = 'products', id_table = NEW.id, column_name = NEW.name;
END//

INSERT INTO products (name) VALUES ('keyboard');

SELECT * FROM logs;

-- 10.1

ZADD visits 0 222.222.222.222 0 222.222.222.222

ZINCRBY visits 1 111.111.111.111

ZSCORE visits 111.111.111.111

-- 10.2

HMSET users_email bob bob@bob.com tom tom@tom.com

HMSET email_users bob@bob.com bob tom@tom.com tom

HGET users_email bob

HGET email_users tom@tom.com

-- 10.3

db.shop.insert(
{
  catalogs: 'Процессоры',
  products: [
    {
      name: 'Intel Core i3-8100',
      description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
      price: 7890.00
    },
    {
      name: 'Intel Core i5-7400',
      description: 'Процессор для настольных персональных компьютеров, основанных на платформе Intel.',
      price: 12700.00
    },
    {
      name: 'AMD FX-8320E',
      description: 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.',
      price: 4780.00
    },
    {
      name: 'AMD FX-8320',
      description: 'Процессор для настольных персональных компьютеров, основанных на платформе AMD.',
      price: 7120.00
    }
  ]
 }
)

db.shop.insert(
{
  catalogs: 'Материнские платы',
  products: [
    {
      name: 'ASUS ROG MAXIMUS X HERO',
      description: 'Материнская плата ASUS ROG MAXIMUS X HERO, Z370, Socket 1151-V2, DDR4, ATX',
      price: 19310.00
    },
    {
      name: 'Gigabyte H310M S2H',
      description: 'Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2, DDR4, mATX',
      price: 4790.00
    },
    {
      name: 'MSI B250M GAMING PRO',
      description: 'Материнская плата MSI B250M GAMING PRO, B250, Socket 1151, DDR4, mATX',
      price: 5060.00
    }
  ]
 }
)