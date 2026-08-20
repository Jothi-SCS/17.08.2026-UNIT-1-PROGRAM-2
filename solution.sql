CREATE DATABASE UniverictyDB;
USE UniverictyDB;
CREATE TABLE Student(
   StudentID numeric(5)PRIMARY KEY,
   StudentName VARCHAR(20)NOT NULL,
   DOB Date NOT NULL,
   Gender VARCHAR(18)NOT NULL,
   DepartmentID numeric(5)NOT NULL
);
desc Student;
ALTER TABLE student
ADD (
 Email VARCHAR(30),
 PhoneNumber Numeric(10)
);
 desc Student;
