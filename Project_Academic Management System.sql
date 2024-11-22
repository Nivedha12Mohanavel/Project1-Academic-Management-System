--PROJECT 1: Academic Management System

CREATE DATABASE AMS;
USE AMS;

-- TASK 1: DATABASE CREATION

-- StudentInfo Table

CREATE TABLE Studentinfo (
    STU_ID INT PRIMARY KEY,
    STU_NAME NVARCHAR(100) NOT NULL,
    DOB DATE NOT NULL,
    PHONE_NO NVARCHAR(15),
    EMAIL_ID NVARCHAR(100) UNIQUE,
    ADDRESS NVARCHAR(200)
);
-- CoursesInfo Table

CREATE TABLE Coursesinfo (
    COURSE_ID INT PRIMARY KEY,
    COURSE_NAME NVARCHAR(100) NOT NULL,
    COURSE_INSTRUCTOR NVARCHAR(100) NOT NULL
);
-- EnrollmentInfo Table

CREATE TABLE Enrollmentinfo (
    ENROLLMENT_ID INT PRIMARY KEY,
    STU_ID INT NOT NULL,
    COURSE_ID INT NOT NULL,
    ENROLL_STATUS NVARCHAR(15) CHECK (ENROLL_STATUS IN ('Enrolled', 'Not Enrolled')),
    FOREIGN KEY (STU_ID) REFERENCES StudentInfo(STU_ID),
    FOREIGN KEY (COURSE_ID) REFERENCES CoursesInfo(COURSE_ID)
);

-- TASK 2: DATABASE CREATION

--Insert Data for StudentInfo

INSERT INTO Studentinfo (STU_ID, STU_NAME, DOB, PHONE_NO, EMAIL_ID, ADDRESS)
VALUES
(1, 'Abi', '2001-03-15', '1234567890', 'abi@gmail.com', 'Chennai'),
(2, 'Anand', '1999-07-21', '9876543210', 'anand@gmail.com', 'Bangalore'),
(3, 'Anu', '2002-11-10', '5678901234', 'anu@gmail.com', 'Coimbatore'),
(4, 'Sasi', '1998-04-12', '1233333890', 'sasi@gmail.com', 'Salem'),
(5, 'Raja', '1999-06-23', '9876563210', 'raja@gmail.com', 'Erode');

--Insert Data for CoursesInfo

INSERT INTO Coursesinfo (COURSE_ID, COURSE_NAME, COURSE_INSTRUCTOR)
VALUES
(101, 'SQL', 'David'),
(102, 'Data Science', 'Sheela'),
(103, 'Operating Systems', 'John'),
(104, 'Project Management', 'Sharmeli'),
(105, 'Python', 'Nisha');

--Insert Data for EnrollmentInfo

INSERT INTO Enrollmentinfo (ENROLLMENT_ID, STU_ID, COURSE_ID, ENROLL_STATUS)
VALUES
(1, 1, 101, 'Enrolled'),
(2, 2, 103, 'Enrolled'),
(3, 1, 104, 'Enrolled'),
(4, 3, 102, 'Enrolled'),
(5, 2, 105, 'Not Enrolled'),
(6, 4, 102, 'Enrolled'),
(7, 3, 101, 'Enrolled'),
(8, 5, 101, 'Not Enrolled'),
(9, 5, 104, 'Enrolled'),
(10, 4, 105, 'Not Enrolled');

SELECT * FROM Studentinfo;
SELECT * FROM Coursesinfo;
SELECT * FROM Enrollmentinfo;

-- TASK 3: Retrieve the Student Information

-- To retrieve student details, such as student name, contact informations, and Enrollment status

SELECT S.STU_NAME, S.PHONE_NO, S.EMAIL_ID, E.ENROLL_STATUS
FROM Studentinfo S
LEFT JOIN Enrollmentinfo E ON S.STU_ID = E.STU_ID;

-- To retrieve a list of courses in which a specific student is enrolled

SELECT S.STU_NAME, C.COURSE_NAME
FROM Enrollmentinfo E
JOIN Studentinfo S ON E.STU_ID = S.STU_ID
JOIN Coursesinfo C ON E.COURSE_ID = C.COURSE_ID
WHERE S.STU_NAME = 'ANU';

-- To retrieve course information, including course name, instructor information

SELECT COURSE_NAME, COURSE_INSTRUCTOR
FROM Coursesinfo;

-- To retrieve course information for a specific course

SELECT COURSE_NAME, COURSE_INSTRUCTOR
FROM Coursesinfo
WHERE COURSE_NAME = 'SQL';

-- To retrieve course information for multiple courses

SELECT COURSE_NAME, COURSE_INSTRUCTOR
FROM Coursesinfo
WHERE COURSE_NAME IN ('SQL', 'Operating Systems');

-- TASK 4: Reporting and Analytics (Using joining queries)

-- To retrieve the number of students enrolled in each course

SELECT C.COURSE_NAME, COUNT(E.STU_ID) AS Total_Students
FROM Coursesinfo C
LEFT JOIN Enrollmentinfo E ON C.COURSE_ID = E.COURSE_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
GROUP BY C.COURSE_NAME;

-- To retrieve the list of students enrolled in a specific course

SELECT S.STU_NAME, C.COURSE_NAME
FROM Enrollmentinfo E
JOIN Studentinfo S ON E.STU_ID = S.STU_ID
JOIN Coursesinfo C ON E.COURSE_ID = C.COURSE_ID
WHERE C.COURSE_NAME = 'Data Science' AND E.ENROLL_STATUS = 'Enrolled';

-- To retrieve the count of enrolled students for each instructor

SELECT C.COURSE_INSTRUCTOR, COUNT(E.STU_ID) AS Total_Students
FROM Coursesinfo C
LEFT JOIN Enrollmentinfo E ON C.COURSE_ID = E.COURSE_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
GROUP BY C.COURSE_INSTRUCTOR;

-- To retrieve the list of students who are enrolled in multiple courses

SELECT S.STU_NAME
FROM Enrollmentinfo E
JOIN Studentinfo S ON E.STU_ID = S.STU_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
GROUP BY S.STU_NAME
HAVING COUNT(E.COURSE_ID) > 1;

-- To retrieve the courses that have the highest number of enrolled students(arranging from highest to lowest)

SELECT C.COURSE_NAME, COUNT(E.STU_ID) AS Total_Students
FROM Coursesinfo C
LEFT JOIN Enrollmentinfo E ON C.COURSE_ID = E.COURSE_ID
WHERE E.ENROLL_STATUS = 'Enrolled'
GROUP BY C.COURSE_NAME
ORDER BY Total_Students DESC;


