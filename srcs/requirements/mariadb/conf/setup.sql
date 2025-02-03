-- Create Database
CREATE DATABASE IF NOT EXISTS wordpress DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE wordpress;

-- Create MySQL User
CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';
GRANT ALL PRIVILEGES ON wordpress.* TO '${MYSQL_USER}'@'%';
FLUSH PRIVILEGES;

-- Insert Admin User (Change the password hash)
INSERT INTO wp_users (user_login, user_pass, user_registered, user_status) 
VALUES ('${MYSQL_ADM_USER}', MD5('${MYSQL_ADM_PASSWORD}'), NOW(), 0);

-- Insert WordPress Options (Site URL, Home URL)
INSERT INTO wp_options (option_name, option_value, autoload) 
VALUES ('siteurl', '${DOMAIN_NAME}', 'yes'),
       ('home', '${DOMAIN_NAME}', 'yes');

-- Test : Insert a Sample Post
INSERT INTO wp_posts (post_author, post_date, post_content, post_title, post_status, post_name, post_type) 
VALUES (1, NOW(), 'Welcome to WordPress!', 'Hello World', 'publish', 'hello-world', 'post');