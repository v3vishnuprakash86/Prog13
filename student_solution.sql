
CREATE DATABASE IF NOT EXISTS CollegeDB;
USE CollegeDB;

-- Drop existing tables in reverse dependency order
DROP TABLE IF EXISTS StudentCourse;
DROP TABLE IF EXISTS Course;
DROP TABLE IF EXISTS Faculty;
DROP TABLE IF EXISTS Student;
DROP TABLE IF EXISTS Department;

-- 1. Department Table
CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL
);

-- 2. Student Table
CREATE TABLE Student (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100) NOT NULL
);

-- 3. Faculty Table
CREATE TABLE Faculty (
    FacultyID INT PRIMARY KEY,
    FacultyName VARCHAR(100) NOT NULL,
    DepartmentID INT NOT NULL,
    FOREIGN KEY (DepartmentID)
        REFERENCES Department(DepartmentID)
);

-- 4. Course Table
CREATE TABLE Course (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100) NOT NULL,
    FacultyID INT NOT NULL,
    FOREIGN KEY (FacultyID)
        REFERENCES Faculty(FacultyID)
);

-- 5. StudentCourse Table
CREATE TABLE StudentCourse (
    StudentID INT,
    CourseID INT,
    PRIMARY KEY (StudentID, CourseID),
    FOREIGN KEY (StudentID)
        REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID)
        REFERENCES Course(CourseID)
);

-- Insert Department Records
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES
(10, 'Computer Science'),
(20, 'Mathematics');

-- Insert Student Records
INSERT INTO Student (StudentID, StudentName)
VALUES
(1001, 'Arun'),
(1002, 'Priya'),
(1003, 'Kumar');

-- Insert Faculty Records
INSERT INTO Faculty (FacultyID, FacultyName, DepartmentID)
VALUES
(1, 'Dr. Ravi', 10),
(2, 'Dr. Meena', 20);

-- Insert Course Records
INSERT INTO Course (CourseID, CourseName, FacultyID)
VALUES
(201, 'Database Systems', 1),
(202, 'Data Structures', 1),
(203, 'Mathematics', 2);

-- Insert StudentCourse Records
INSERT INTO StudentCourse (StudentID, CourseID)
VALUES
(1001, 201),
(1001, 202),
(1002, 203),
(1003, 201);

-- Display Normalized Data Using JOIN
SELECT
    s.StudentID,
    s.StudentName,
    c.CourseName,
    f.FacultyName,
    d.DepartmentName
FROM Student s
INNER JOIN StudentCourse sc
    ON s.StudentID = sc.StudentID
INNER JOIN Course c
    ON sc.CourseID = c.CourseID
INNER JOIN Faculty f
    ON c.FacultyID = f.FacultyID
INNER JOIN Department d
    ON f.DepartmentID = d.DepartmentID
ORDER BY s.StudentID, c.CourseID;
