-- создаем базу данных top_hotels
CREATE DATABASE top_hotels;

-- делаем ее текущей
USE top_hotels;

-- создаем таблицу пользователей
DROP TABLE IF EXISTS users;
CREATE TABLE users (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  type_user ENUM('tourist', 'agent', 'hoteller', 'guide') NOT NULL,
  name VARCHAR(255) NOT NULL UNIQUE,
  gender ENUM('male', 'female') NOT NULL,
  email VARCHAR(255) NOT NULL UNIQUE,
  phone VARCHAR(13) NOT NULL UNIQUE,
  password VARCHAR(255) NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- создаем таблицу стран расположения отелей  
DROP TABLE IF EXISTS countries;
CREATE TABLE countries (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
  );

-- создаем таблицу регионов расположения отелей 
 DROP TABLE IF EXISTS regions;
 CREATE TABLE regions (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  country_id INT UNSIGNED NOT NULL
);

-- создаем таблицу городов расположения отелей
DROP TABLE IF EXISTS cities;
CREATE TABLE cities (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  region_id INT UNSIGNED NOT NULL 
);

-- создаем таблицу типов размещения в отелях
DROP TABLE IF EXISTS type_hotels;
CREATE TABLE type_hotels (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- создаем таблицу категорий отелей
DROP TABLE IF EXISTS star_categories;
CREATE TABLE star_categories (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- создаем таблицу типов расположения отелей
DROP TABLE IF EXISTS type_locations;
CREATE TABLE type_locations (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- создаем таблицу отелей
DROP TABLE IF EXISTS hotels;
CREATE TABLE hotels (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE,
  type_hotel_id INT UNSIGNED,
  star_category_id INT UNSIGNED,
  type_location_id INT UNSIGNED,
  description TEXT,
  city_id INT UNSIGNED,
  adress VARCHAR(255) NOT NULL,
  contacts VARCHAR(255) NOT NULL,
  building_date DATE NOT NULL,
  reconstruct_date DATE,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- создаем таблицу категорий мест фотографий и видео отеля
DROP TABLE IF EXISTS categories_media;
CREATE TABLE categories_media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(255) NOT NULL UNIQUE
);

-- создаем таблицу медиафайлов
DROP TABLE IF EXISTS media;
CREATE TABLE media (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  user_id INT UNSIGNED,
  hotel_id INT UNSIGNED,
  media_type ENUM('photo', 'video'),
  category_media_id INT UNSIGNED NOT NULL,
  file_path VARCHAR(255) NOT NULL,
  file_size INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP  
);

-- создаем таблицу отзывов и рекомендаций
DROP TABLE IF EXISTS reviews;
CREATE TABLE reviews (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  type_reviеw ENUM('reviеw', 'recommend'),
  from_user_id INT UNSIGNED NOT NULL,
  to_hotel_id INT UNSIGNED NOT NULL,
  body TEXT NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- создаем таблицу подписок на отели
DROP TABLE IF EXISTS subscriptions;
CREATE TABLE subscriptions (
  hotel_id INT UNSIGNED NOT NULL,
  user_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (hotel_id, user_id)
);

-- создаем таблицу лайков
DROP TABLE IF EXISTS likes;
CREATE TABLE likes (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_user_id INT UNSIGNED NOT NULL,
  to_hotel_id INT UNSIGNED NOT NULL,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- создаем таблицу выставления рейтинга отеля
DROP TABLE IF EXISTS ratings;
CREATE TABLE ratings (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  from_user_id INT UNSIGNED NOT NULL,
  to_hotel_id INT UNSIGNED NOT NULL,
  rating ENUM ('1', '2', '3', '4', '5'),
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- создаем таблицу новостей
DROP TABLE IF EXISTS news;
CREATE TABLE news (
  id INT UNSIGNED NOT NULL AUTO_INCREMENT PRIMARY KEY,
  head VARCHAR(255),
  body TEXT NOT NULL,
  media_id INT UNSIGNED,
  created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);



-- добавляем внешний ключ к таблице регионов
ALTER TABLE regions
  ADD CONSTRAINT regions_country_id_fk
    FOREIGN KEY (country_id) REFERENCES countries(id)
     ON DELETE CASCADE;
    
-- добавляем внешний ключ к таблице городов
ALTER TABLE cities
  ADD CONSTRAINT cities_region_id_fk
    FOREIGN KEY (region_id) REFERENCES regions(id)
      ON DELETE CASCADE;
    
-- добавляем внешние ключи к таблице отелей
ALTER TABLE hotels
  ADD CONSTRAINT hotels_type_hotel_id_fk
    FOREIGN KEY (type_hotel_id) REFERENCES type_hotels(id)
      ON DELETE SET NULL,
  ADD CONSTRAINT hotels_star_category_id_fk
    FOREIGN KEY (star_category_id) REFERENCES star_categories(id)
      ON DELETE SET NULL,
  ADD CONSTRAINT hotels_type_location_id_fk
    FOREIGN KEY (type_location_id) REFERENCES type_locations(id)
      ON DELETE SET NULL,
  ADD CONSTRAINT hotels_city_id_fk
    FOREIGN KEY (city_id) REFERENCES cities(id)
      ON DELETE CASCADE;
    
-- добавляем внешние ключи к таблице медиафайлов
ALTER TABLE media
  ADD CONSTRAINT media_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE SET NULL,
  ADD CONSTRAINT media_category_media_id_fk
    FOREIGN KEY (category_media_id) REFERENCES categories_media(id),
  ADD CONSTRAINT media_hotel_id_fk
    FOREIGN KEY (hotel_id) REFERENCES hotels(id)
      ON DELETE CASCADE;
     
-- добавляем внешние ключи к таблице отзывов и рекомендаций
ALTER TABLE reviews
  ADD CONSTRAINT reviews_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT reviews_to_hotel_id_fk
    FOREIGN KEY (to_hotel_id) REFERENCES hotels(id)
      ON DELETE CASCADE;

-- добавляем внешние ключи к таблице подписок на отели
ALTER TABLE subscriptions
  ADD CONSTRAINT subscriptions_hotel_id_fk
    FOREIGN KEY (hotel_id) REFERENCES hotels(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT subscriptions_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

-- добавляем внешние ключи к таблице лайков
ALTER TABLE likes
  ADD CONSTRAINT likes_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT likes_to_hotel_id_fk
    FOREIGN KEY (to_hotel_id) REFERENCES hotels(id)
      ON DELETE CASCADE;
    
-- добавляем внешние ключи к таблице рейтинга отеля
ALTER TABLE ratings
  ADD CONSTRAINT ratings_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT ratings_to_hotel_id_fk
    FOREIGN KEY (to_hotel_id) REFERENCES hotels(id)
      ON DELETE CASCADE;
     
 -- добавляем внешний ключ к таблице новостей
 ALTER TABLE news
   ADD CONSTRAINT news_media_id_fk
     FOREIGN KEY (media_id) REFERENCES media(id)
       ON DELETE SET NULL;
     
      

-- создаем индекс на имена пользователей
CREATE INDEX users_name_idx ON users(name);

-- создаем индекс на имэйлы пользователей
CREATE UNIQUE INDEX users_email_idx ON users(email);

-- создаем индекс на наименование стран расположения отелей
CREATE UNIQUE INDEX countries_name_idx ON countries(name);

-- создаем индекс на наименование регионов расположения отелей
CREATE UNIQUE INDEX regions_name_idx ON regions(name);

-- создаем индекс на наименование городов расположения отелей
CREATE INDEX cities_name_idx ON cities(name);
     
-- создаем индекс на наименование отелей
CREATE INDEX hotels_name_idx ON hotels(name);

-- создаем составные индексы для таблицы отзывов и рекомендаций
CREATE INDEX reviews_from_user_id_to_hotel_id_idx ON reviews(from_user_id, to_hotel_id);
CREATE INDEX reviews_to_hotel_id_from_user_id_idx ON reviews(to_hotel_id, from_user_id);

-- создаем составные индексы для таблицы подписок
CREATE INDEX subscriptions_hotel_id_user_id_idx ON subscriptions(hotel_id, user_id);
CREATE INDEX subscriptions_user_id_hotel_id_idx ON subscriptions(user_id, hotel_id);



-- запрос на вывод наименования отелей, расположенных в стране Guadeloupe
SELECT name FROM hotels 
  WHERE id = (SELECT id FROM countries WHERE name = 'Guadeloupe');
 
-- запрос на вывод наименования отелей, с сортировкой по среднему рейтингу
SELECT h.name, ROUND(AVG(r.rating), 2) AS avg_rating
  FROM hotels h
    JOIN ratings r
      ON h.id = r.to_hotel_id 
  GROUP BY r.to_hotel_id 
  ORDER BY avg_rating DESC;
 
-- запрос на нахождение 5 пятизвездочных отелей, имеющих большее количество отзывов
SELECT h.name, COUNT(r.id) AS sum_reviews 
  FROM hotels h 
    JOIN reviews r
      ON h.id = r.to_hotel_id
  WHERE h.star_category_id = (SELECT id FROM star_categories WHERE name = 5)
  GROUP BY r.to_hotel_id
  ORDER BY COUNT(r.id) DESC
  LIMIT 5;
 
 -- запрос на нахождение самого нового отеля на первой линии у моря с указанием страны
 SELECT h.name, c.name, h.building_date
   FROM hotels h
     JOIN cities cit
       ON h.city_id = cit.id 
     JOIN regions r
       ON cit.region_id = r.id
     JOIN countries c 
       ON r.country_id = c.id
   WHERE h.type_location_id = (SELECT id FROM type_locations WHERE name = 'beach first line')
   GROUP BY h.name 
   ORDER BY h.building_date DESC
   LIMIT 1;

  -- запрос на нахождение 5 самых активных путешественника
  SELECT name, 
    (SELECT COUNT(id) FROM ratings WHERE ratings.from_user_id = users.id) +
    (SELECT COUNT(id) FROM likes WHERE likes.from_user_id = users.id) +
    (SELECT COUNT(id) FROM reviews WHERE reviews.from_user_id = users.id) AS activity
  FROM users 
  ORDER BY activity DESC 
  LIMIT 5;
  
 
 
 -- cоздаем предствление на вывод пользователей и их подписок на отели с сортировкой по имени пользователя
 CREATE OR REPLACE VIEW users_subscription AS 
   SELECT u.name AS user, h.name AS hotel
     FROM 
       users u 
     JOIN
       subscriptions s
     ON u.id = s.user_id
     JOIN
       hotels h
     ON h.id = s.hotel_id
   ORDER BY u.name;
       
-- создаем представление на вывод отелей с указанием города, категории звездности и типа размещения
CREATE OR REPLACE VIEW hotels_city_type AS
  SELECT h.name AS hotel, c.name AS city, s.name AS star, t.name AS type, l.name AS location
    FROM
      hotels h 
    JOIN 
      cities c 
    ON h.city_id = c.id
    JOIN 
      star_categories s 
    ON h.star_category_id = s.id 
    JOIN 
      type_hotels t 
    ON h.type_hotel_id = t.id 
    JOIN 
      type_locations l 
    ON h.type_location_id = l.id 
  ORDER BY h.name;
      
 -- создаем процедуру для выборки 5 последних добавленных отелей в определенной стране
 
DELIMITER //
 
 CREATE PROCEDURE last_hotels(IN for_country_id INT)
   BEGIN 
	   SELECT h.name, c.name, h.created_at 
	     FROM hotels h 
	       JOIN cities cit
             ON h.city_id = cit.id 
           JOIN regions r
             ON cit.region_id = r.id
           JOIN countries c 
             ON r.country_id = c.id
	   WHERE c.id = for_country_id 
	   ORDER BY h.created_at DESC 
	   LIMIT 5;
   END//
   
DELIMITER ;
  
-- создаем триггер для хранения количества отелей после вставки нового

DELIMITER //

CREATE TRIGGER hotels_count AFTER INSERT ON hotels
  FOR EACH ROW 
    BEGIN 
	    SELECT COUNT(id) INTO @total_hotels FROM hotels;
    END//
    
DELIMITER ;
