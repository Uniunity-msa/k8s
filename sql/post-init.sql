-- DB 생성 및 사용
SET character_set_client = utf8mb4;
SET character_set_connection = utf8mb4;
SET character_set_results = utf8mb4;

CREATE DATABASE IF NOT EXISTS post_service_db;
USE post_service_db;

-- Post 테이블 생성 (user_nickname 추가됨)
CREATE TABLE IF NOT EXISTS Post (
    post_id INT AUTO_INCREMENT PRIMARY KEY,
    post_title VARCHAR(255),
    post_content TEXT,
    category VARCHAR(50),
    post_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    view_count INT DEFAULT 0,
    like_count INT DEFAULT 0,
    scrap_count INT DEFAULT 0,
    comment_count INT DEFAULT 0,
    user_email VARCHAR(255) NOT NULL,
    user_nickname VARCHAR(100) NOT NULL,
    university_id INT NOT NULL
);

-- PostImage 테이블 생성
CREATE TABLE IF NOT EXISTS PostImage (
    image_id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT NOT NULL,
    image_url TEXT,
    image_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES Post(post_id)
);

-- Post 테이블에 게시글 3개 추가 (이미지 포함된 HTML 포함)
INSERT INTO Post (
  user_email, user_nickname, university_id, post_title, post_content, category, post_date, view_count,
  like_count, scrap_count, comment_count
) VALUES
(
  'asdf1234@gmail.com', 'asdf',
  1,
  '테스트 게시글 1 (이미지 포함)',
  '<p>첫 번째 강아지 이미지가 포함된 게시글입니다.</p><img src="https://storage.googleapis.com/uniunity_bucket/강아지이미지.png" alt="강아지" contenteditable="false" />',
  '잡담',
  NOW(),
  4,
  1, 1, 0
),
(
  'asdf1234@gmail.com', 'asdf',
  1,
  '테스트 게시글 2 (이미지 포함)',
  '<p>두 번째 강아지 이미지가 포함된 게시글입니다.</p><img src="https://storage.googleapis.com/uniunity_bucket/강아지이미지2.png" alt="강아지2" contenteditable="false" />',
  '잡담',
  NOW(),
  2,
  0, 0, 0
),
(
  'asdf1234@gmail.com', 'asdf',
  1,
  '테스트 게시글 3 (이미지 포함)',
  '<p>고양이 이미지가 포함된 게시글입니다.</p><img src="https://storage.googleapis.com/uniunity_bucket/고양이이미지.png" alt="고양이" contenteditable="false" />',
  '잡담',
  NOW(),
  6,
  2, 0, 1
);

-- PostImage 테이블에 각 게시글에 해당하는 이미지 URL 등록
-- (주의: post_id는 컨테이너 초기화 시 AUTO_INCREMENT 1부터 시작 기준)
INSERT INTO PostImage (post_id, image_url) VALUES
(1, 'https://storage.googleapis.com/uniunity_bucket/강아지이미지.png'),
(2, 'https://storage.googleapis.com/uniunity_bucket/강아지이미지2.png'),
(3, 'https://storage.googleapis.com/uniunity_bucket/고양이이미지.png');