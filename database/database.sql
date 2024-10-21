CREATE DATABASE sampledb;
USE sampledb;

CREATE TABLE users (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(100),
  email VARCHAR(100)
);
INSERT INTO users (name, email) VALUES ('John Doe', 'john@example.com');
