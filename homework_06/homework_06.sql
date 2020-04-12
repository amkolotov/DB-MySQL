USE my_vk;

SHOW TABLES;

DESC posts;

DESC profiles;

ALTER TABLE profiles 
  ADD CONSTRAINT profiles_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;

-- ALTER TABLE profiles DROP FOREIGN KEY profiles_user_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT UNSIGNED;

DESC messages;

ALTER TABLE messages 
  ADD CONSTRAINT messages_from_user_id_fk
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk
    FOREIGN KEY (to_user_id) REFERENCES users(id);
   
DESC target_types;

DESC posts;
   
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT post_communiny_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id),
  ADD CONSTRAINT posts_media_id_fk
    FOREIGN KEY (media_id) REFERENCES media(id);
   
DESC media_types;

DESC media;

ALTER TABLE media 
  ADD CONSTRAINT media_media_type_id_fk
    FOREIGN KEY (media_type_id) REFERENCES media_types(id),
  ADD CONSTRAINT media_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id);
   
DESC likes;

ALTER TABLE likes 
  ADD CONSTRAINT likes_users_id_fk
    FOREIGN KEY (users_id) REFERENCES users(id),
  ADD CONSTRAINT likes_target_type_id_fk
    FOREIGN KEY (target_type_id) REFERENCES target_types(id);
   
DESC friendship_statuses;

DESC friendship;

ALTER TABLE friendship 
  ADD CONSTRAINT friendship_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_friend_id_fk
    FOREIGN KEY (friend_id) REFERENCES users(id),
  ADD CONSTRAINT friendship_status_id_fk
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);

DESC communities;

DESC communities_users;
 
ALTER TABLE communities_users 
  ADD CONSTRAINT communities_users_community_id_fk
    FOREIGN KEY (community_id) REFERENCES communities(id)
      ON DELETE CASCADE,
  ADD CONSTRAINT communities_users_user_id_fk
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;
     
 
-- Подсчитать количество лайков, которые получили 10 самых молодых пользователей

SELECT 
  (SELECT CONCAT(first_name, ' ', last_name) 
    FROM users WHERE id = likes.target_id) AS full_name,
  COUNT(*) AS count_likes
    FROM likes
      WHERE target_type_id = 
	    (SELECT id FROM target_types WHERE name = 'users')
GROUP BY target_id
ORDER BY (SELECT birthday FROM profiles WHERE user_id = likes.target_id) DESC
LIMIT 10;
	
-- Опеределить кто больше поставил лайков (всего) - мужчины или женщины

SELECT COUNT(*) AS count_likes,
  (SELECT gender FROM profiles WHERE user_id = likes.users_id) AS sex
FROM likes 
GROUP BY sex;

-- Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети

SELECT CONCAT(first_name, ' ', last_name) AS user_name,
   (SELECT COUNT(*) FROM likes
      WHERE users_id = users.id)
        AS activity
FROM users
GROUP BY id
ORDER BY activity
LIMIT 10;

   
   
   
