-- Student Table Assignment
-- Student Name:
-- Register Number:

-- Write your SQL program below.

-- Requirements:
-- StudentID      - INT(5), PRIMARY KEY, NOT NULL
-- StudentName    - VARCHAR(20), UNIQUE, NOT NULL
-- DOB            - DATE, NOT NULL
-- Gender         - VARCHAR(10), NOT NULL
-- DepartmentID   - INT(5), NOT NULL
CREATE DATABASE IF NOT EXISTS CollegeDB;

USE CollegeDB;

CREATE TABLE Student (
    StudentID INT(5) NOT NULL PRIMARY KEY,
    StudentName VARCHAR(20) NOT NULL UNIQUE,
    DOB DATE NOT NULL,
    Gender VARCHAR(10) NOT NULL,
    DepartmentID INT(5) NOT NULL
);
