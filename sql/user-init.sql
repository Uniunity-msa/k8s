CREATE DATABASE IF NOT EXISTS user_service_db;
USE user_service_db;

SET character_set_client = utf8mb4;
SET character_set_connection = utf8mb4;
SET character_set_results = utf8mb4;


-- university 테이블 구조
CREATE TABLE university (
  university_id INT NOT NULL,
  university_name VARCHAR(255) NOT NULL,
  university_location VARCHAR(255) NOT NULL,
  council_id INT NOT NULL,
  university_url VARCHAR(255) NOT NULL,
  council_open_status TINYINT(1) NOT NULL,
  latitude DOUBLE NOT NULL,
  longitude DOUBLE NOT NULL,
  PRIMARY KEY (university_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- 더미 데이터 삽입
INSERT INTO university (
  university_id, university_name, university_location, council_id,
  university_url, council_open_status, latitude, longitude
)
VALUES
(1, '성신여자대학교', '서울특별시 성북구', 1, 'sungshin', 1, 37.5926, 127.0165),
(2, '건국대학교', '서울특별시 광진구', 2, 'konkuk', 1, 37.5409, 127.0796);



-- user 테이블
CREATE TABLE user (
  user_email VARCHAR(255) NOT NULL,
  user_name VARCHAR(255) NOT NULL,
  psword VARCHAR(255) NOT NULL,
  user_type VARCHAR(225) NOT NULL,
  user_nickname VARCHAR(255) NOT NULL,
  university_id INT NOT NULL,
  user_marketing TINYINT NOT NULL,
  PRIMARY KEY (user_email),
  KEY university_id (university_id),
  CONSTRAINT user_ibfk_1 FOREIGN KEY (university_id) REFERENCES university (university_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

INSERT INTO user (user_email, user_name, psword, user_type, user_nickname, university_id, user_marketing) VALUES 
('asdf1234@gmail.com', 'asdf', '$2b$10$MCBwQQ7X.rlYbqFkwJLRsONJDtmsmwYAdOLxZ6vTtzTfaH6tQhcRS', 'student', 'asdf', 1, 1),
('student@sungshin.ac.kr', '김학생', '$2b$10$MCBwQQ7X.rlYbqFkwJLRsONJDtmsmwYAdOLxZ6vTtzTfaH6tQhcRS', 'student', '학생1', 1, 1),
('partner@gmail.com', '김상인', '$2b$10$MCBwQQ7X.rlYbqFkwJLRsONJDtmsmwYAdOLxZ6vTtzTfaH6tQhcRS', 'retailer', '상인1', 2, 1);

-- refresh_token 테이블
CREATE TABLE refresh_token (
  user_email VARCHAR(50) NOT NULL,
  refresh_token VARCHAR(255) NOT NULL,
  expires_at DATETIME DEFAULT NULL,
  PRIMARY KEY (user_email)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
