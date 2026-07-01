-- Database creation
CREATE DATABASE IF NOT EXISTS surveydb;
USE surveydb;

-- Drop the table if it already exists so you can safely re-run this script while testing
DROP TABLE IF EXISTS survey_data;

CREATE TABLE survey_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    fullName VARCHAR(100),
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    age INT, 
    gender VARCHAR(10),
    qualification VARCHAR(50),
    employment VARCHAR(50),
    skills VARCHAR(255),
    proficiency INT,
    comments TEXT,
    resume VARCHAR(255) NULL 
);