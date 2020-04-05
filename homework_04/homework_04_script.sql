
USE my_vk;

SHOW TABLES;

DESC users;

SELECT * FROM users LIMIT 10;

ALTER TABLE users MODIFY COLUMN phone VARCHAR(13) NOT NULL UNIQUE;

UPDATE users SET phone = CONCAT('+79', FLOOR(100000000 + (RAND() * 99999999)));

DESC profiles;

SELECT * FROM profiles LIMIT 10;

UPDATE profiles SET gender = RAND()

CREATE TEMPORARY TABLE genders (gender CHAR(1));

INSERT INTO genders VALUES ('m'), ('f');

SELECT * FROM genders;

UPDATE profiles SET gender = (SELECT gender FROM genders ORDER BY RAND() LIMIT 1);

SHOW TABLES;

DESC messages;

SELECT * FROM messages LIMIT 10;

SELECT * FROM messages;

DESC media;

SELECT * FROM media LIMIT 10;

SELECT * FROM media_types;

DELETE FROM media_types;

INSERT media_types (name) VALUES 
  ('photo'),
  ('audio'),
  ('video')
 ;

TRUNCATE media_types;

UPDATE media SET media_type_id = FLOOR(1 + (RAND() * 2));

UPDATE media SET user_id = FLOOR(1 + (RAND() * 100));

UPDATE media SET file_path = CONCAT('http//dropbox/vk/file_',
  FLOOR(1 + (RAND() * 10000))
);

UPDATE 	media SET size = FLOOR(10000 + (RAND() * 100000)) WHERE size < 10000;

UPDATE media SET metadata = CONCAT('{"owner":"',
  (SELECT CONCAT(first_name, ' ' , last_name) FROM users WHERE id = user_id),
'"}')

ALTER TABLE media MODIFY COLUMN metadata JSON;

DESC media;

SELECT id, JSON_EXTRACT(metadata, '$.owner') AS owner
  FROM media
  WHERE id = 1;

SHOW TABLES;

DESC friendship;

SELECT * FROM friendship;

UPDATE friendship SET 
  user_id = FLOOR(1 + RAND() * 100),
  friend_id = FLOOR(1 + RAND() * 100)
;

SELECT * FROM friendship_statuses;

TRUNCATE friendship_statuses;

INSERT INTO friendship_statuses (name) VALUES 
  ('requested'),
  ('confirmed'),
  ('rejected');
 
UPDATE friendship SET status_id = FLOOR(1 + (RAND() * 3));
  
UPDATE friendship SET confirmed_at = CURRENT_TIME() WHERE requested_at > confirmed_at;

DESC communities;

SELECT * FROM communities;

DELETE FROM communities WHERE id > 20;

SELECT * FROM communities_users;

RENAME TABLE communutues_users TO communities_users;

UPDATE communities_users SET community_id = FLOOR(1 + (RAND() * 20));

DESC communities_users;

DESC friendship;

UPDATE communities_users SET community_id = FLOOR(1 + (RAND() * 20));







