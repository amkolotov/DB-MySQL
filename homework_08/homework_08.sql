USE my_vk;

-- ���������� ���������� ������, ������� �������� 10 ����� ������� �����������

SELECT COUNT(*) AS likes
  FROM likes l
JOIN
  (SELECT * FROM profiles ORDER BY birthday LIMIT 10) p
  ON l.target_id = p.user_id
  WHERE target_type_id = 2;


-- ����������� ��� ������ �������� ������ (�����) - ������� ��� �������  

SELECT p.gender AS sex, COUNT(*) AS likes
  FROM likes l
JOIN
  profiles p
  ON l.users_id = p.user_id
GROUP BY p.gender
ORDER BY p.gender DESC
LIMIT 1;
  
-- ����� 10 �������������, ������� ��������� ���������� ���������� � ������������� ���������� ����

SELECT u.first_name, u.last_name, COUNT(*) AS total_activity
  FROM users u
JOIN
  likes l
  ON u.id = l.users_id
JOIN
  media m
  ON u.id = m.user_id
JOIN
  messages mg
  ON u.id = mg.from_user_id
GROUP BY u.id
ORDER BY total_activity
LIMIT 10;

