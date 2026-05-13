DROP DATABASE IF EXISTS tutoring_center_db;
CREATE DATABASE tutoring_center_db;
USE tutoring_center_db;

CREATE TABLE STUDENT (
    StudentID INT PRIMARY KEY,
    StudentName VARCHAR(100),
    StudentEmail VARCHAR(100),
    Major VARCHAR(50)
);

CREATE TABLE TUTOR (
    TutorID INT PRIMARY KEY,
    TutorName VARCHAR(100),
    TutorEmail VARCHAR(100)
);

CREATE TABLE COURSE (
    CourseID INT PRIMARY KEY,
    CourseTitle VARCHAR(100),
    Department VARCHAR(50)
);

CREATE TABLE ROOM (
    RoomID INT PRIMARY KEY,
    RoomBuilding VARCHAR(50),
    RoomCapacity INT
);

CREATE TABLE SESSION (
    SessionID INT PRIMARY KEY,
    SessionDate DATE,
    SessionTime TIME,
    StudentID INT,
    TutorID INT,
    CourseID INT,
    RoomID INT,
    SessionType VARCHAR(50),
    HourlyRate DECIMAL(6,2),
    DurationMinutes INT,
    FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    FOREIGN KEY (TutorID) REFERENCES TUTOR(TutorID),
    FOREIGN KEY (CourseID) REFERENCES COURSE(CourseID),
    FOREIGN KEY (RoomID) REFERENCES ROOM(RoomID)
);

SHOW TABLES;

DESCRIBE STUDENT;
DESCRIBE TUTOR;
DESCRIBE COURSE;
DESCRIBE ROOM;
DESCRIBE SESSION;

INSERT INTO STUDENT (StudentID, StudentName, StudentEmail, Major) VALUES
(101, 'Alice Nguyen', 'alice.nguyen@cwu.edu', 'Computer Science'),
(102, 'Brian Lee', 'brian.lee@cwu.edu', 'Biology'),
(103, 'Carla Martinez', 'carla.martinez@cwu.edu', 'Mathematics'),
(104, 'David Kim', 'david.kim@cwu.edu', 'Physics'),
(105, 'Emma Johnson', 'emma.johnson@cwu.edu', 'Chemistry');

INSERT INTO TUTOR (TutorID, TutorName, TutorEmail) VALUES
(201, 'Michael Brown', 'michael.brown@cwu.edu'),
(202, 'Sophia Davis', 'sophia.davis@cwu.edu'),
(203, 'Daniel Wilson', 'daniel.wilson@cwu.edu'),
(204, 'Olivia Taylor', 'olivia.taylor@cwu.edu'),
(205, 'James Anderson', 'james.anderson@cwu.edu');

INSERT INTO COURSE (CourseID, CourseTitle, Department) VALUES
(301, 'Database Systems', 'Computer Science'),
(302, 'Calculus I', 'Mathematics'),
(303, 'General Biology', 'Biology'),
(304, 'College Physics', 'Physics'),
(305, 'Organic Chemistry', 'Chemistry');

INSERT INTO ROOM (RoomID, RoomBuilding, RoomCapacity) VALUES
(401, 'Science Hall', 30),
(402, 'Discovery Hall', 25),
(403, 'Math Center', 20),
(404, 'Johnson Tower', 35),
(405, 'Library Annex', 15);

INSERT INTO SESSION (
    SessionID, SessionDate, SessionTime, StudentID, TutorID, CourseID, RoomID,
    SessionType, HourlyRate, DurationMinutes
) VALUES
(501, '2026-05-20', '09:00:00', 101, 201, 301, 401, 'One-on-One', 25.00, 60),
(502, '2026-05-20', '10:30:00', 102, 202, 303, 402, 'Group', 20.00, 90),
(503, '2026-05-21', '11:00:00', 103, 203, 302, 403, 'One-on-One', 25.00, 60),
(504, '2026-05-21', '01:00:00', 104, 204, 304, 404, 'Group', 22.50, 120),
(505, '2026-05-22', '02:30:00', 105, 205, 305, 405, 'One-on-One', 30.00, 75);

SELECT * FROM STUDENT;
SELECT * FROM TUTOR;
SELECT * FROM COURSE;
SELECT * FROM ROOM;
SELECT * FROM SESSION;

-- Display all tutoring sessions with student name, tutor name, course title, and room ID
SELECT 
    S.SessionID,
    ST.StudentName,
    T.TutorName,
    C.CourseTitle,
    R.RoomID
FROM SESSION S
JOIN STUDENT ST ON S.StudentID = ST.StudentID
JOIN TUTOR T ON S.TutorID = T.TutorID
JOIN COURSE C ON S.CourseID = C.CourseID
JOIN ROOM R ON S.RoomID = R.RoomID;

-- List all sessions for a specific student
SELECT 
    S.SessionID,
    S.SessionDate,
    S.SessionTime,
    ST.StudentName,
    C.CourseTitle
FROM SESSION S
JOIN STUDENT ST ON S.StudentID = ST.StudentID
JOIN COURSE C ON S.CourseID = C.CourseID
WHERE ST.StudentName = 'Alice Nguyen';

-- List all sessions conducted by a specific tutor
SELECT 
    S.SessionID,
    S.SessionDate,
    S.SessionTime,
    T.TutorName,
    C.CourseTitle
FROM SESSION S
JOIN TUTOR T ON S.TutorID = T.TutorID
JOIN COURSE C ON S.CourseID = C.CourseID
WHERE T.TutorName = 'Michael Brown';

-- Count the number of sessions per course
SELECT 
    C.CourseTitle,
    COUNT(*) AS SessionCount
FROM SESSION S
JOIN COURSE C ON S.CourseID = C.CourseID
GROUP BY C.CourseTitle;

-- Count the number of sessions per room
SELECT 
    R.RoomID,
    COUNT(*) AS SessionCount
FROM SESSION S
JOIN ROOM R ON S.RoomID = R.RoomID
GROUP BY R.RoomID;








