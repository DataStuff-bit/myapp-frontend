-- Create the database if it doesn't exist
CREATE DATABASE IF NOT EXISTS anil_ps;

-- Select the database to use
USE anil_ps;

-- Table for user login information
CREATE TABLE IF NOT EXISTS users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    email VARCHAR(120) UNIQUE NOT NULL,
    password_hash VARCHAR(128) NOT NULL,
    username VARCHAR(80) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table for general post information related to child models
CREATE TABLE IF NOT EXISTS posts (
    id INT AUTO_INCREMENT PRIMARY KEY,
    owner_email VARCHAR(120) NOT NULL,
    title VARCHAR(200) NOT NULL,
    type VARCHAR(50) NOT NULL, -- e.g., "Findings", "Blocked Report", "Playbook Chatbot"
    content TEXT NOT NULL,
    is_public BOOLEAN DEFAULT FALSE,
    user_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(id)
);

-- Table specifically for findings-related information
CREATE TABLE IF NOT EXISTS findings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    post_id INT UNIQUE NOT NULL,
    severity VARCHAR(50),
    impact TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (post_id) REFERENCES posts(id)
);
ALTER TABLE users MODIFY password_hash VARCHAR(255);
-- CREATE TABLE page_visits (
--     id INT AUTO_INCREMENT PRIMARY KEY,
--     page_name VARCHAR(255) NOT NULL,
--     visit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP
--     -- Optional: Add a user_id column if you have user authentication
--     -- user_id INT,
--     -- FOREIGN KEY (user_id) REFERENCES users(id)
-- );

-- Table for tracking page visits per user
CREATE TABLE IF NOT EXISTS page_visits (
    id INT AUTO_INCREMENT PRIMARY KEY,
    page_name VARCHAR(255) NOT NULL,
    visit_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    user_id INT NOT NULL, -- Add user_id column
    FOREIGN KEY (user_id) REFERENCES users(id) ON DELETE CASCADE -- Link to the users table
);
-- Grant privileges (Optional - adjust as needed for your setup)
-- This grants all privileges on the anil_ps database to the user 'root' from localhost
--  You might need to change the username and host depending on your MySQL configuration.
GRANT ALL PRIVILEGES ON anil_ps.* TO 'root'@'localhost';
FLUSH PRIVILEGES;
select * from users;