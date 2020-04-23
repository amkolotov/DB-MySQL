
USE my_vk;

-- 1. Проанализировать какие запросы могут выполняться наиболее часто в процессе работы приложения и добавить необходимые индексы.
-- в дополнение к рассмотреным на уроке думаю возможно создать следующие индексы:

-- для поиска медиафайлов пользователя

CREATE INDEX media_user_id_idx ON media(user_id);

-- для выборки членов сообщества

CREATE INDEX communities_users_communiti_id_idx ON communities_users(community_id);

-- поиск постов пользователя

CREATE INDEX posts_user_id_idx ON posts(user_id);


-- 2. Задание на оконные функции

SELECT DISTINCT communities.name, community_id,
  ROUND(SUM(communities_users.user_id) OVER() / SUM(communities.id) OVER()) AS average,
  MAX(profiles.birthday) OVER w AS min_age,
  MIN(profiles.birthday) OVER w AS max_age,
  COUNT(communities_users.user_id) OVER w AS count_users,
  COUNT(profiles.user_id) OVER() AS count_users,
  COUNT(communities_users.user_id) OVER w / COUNT(profiles.user_id) OVER() * 100 AS '%%'
FROM (communities
  JOIN communities_users 
    ON communities.id = communities_users.community_id
  JOIN profiles 
    ON communities.id = profiles.user_id)
    WINDOW w AS (PARTITION BY communities.id);
   