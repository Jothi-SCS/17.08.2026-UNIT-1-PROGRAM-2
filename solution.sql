CREATE DATABASE CollegeDB;
USE CollegeDB;
CREATE TABLE Student (StudentID Number(5) Primary Key,
                      StudentName VARCHAR(20),
                      DOB DATE,
                      Gender VARCHAR(10),
                      DepartmentID Number(5)
);
DESC Student;



