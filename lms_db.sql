-- ===============================================
-- LMS Database Full Setup with Sample Data & Queries
-- ===============================================

-- 1. DROP DATABASE IF EXISTS & CREATE DATABASE
DROP DATABASE IF EXISTS lms_db;
CREATE DATABASE lms_db;
USE lms_db;

-- ===============================================
-- 2. CREATE TABLES
-- ===============================================

-- Students Table
CREATE TABLE students (
    student_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    dob DATE,
    enrollment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (student_id)
);

-- Instructors Table
CREATE TABLE instructors (
    instructor_id INT NOT NULL AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (instructor_id)
);

-- Courses Table
CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

-- Modules Table
CREATE TABLE modules (
    module_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    module_name VARCHAR(100),
    module_order INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Enrollments Table
CREATE TABLE enrollments (
    enrollment_id INT NOT NULL AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL DEFAULT (CURRENT_DATE),
    PRIMARY KEY (enrollment_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

-- Grades Table
CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    module_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

-- Attendance Table
CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    module_id INT,
    status BOOLEAN DEFAULT TRUE,
    attendance_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

-- ===============================================
-- 3. INSERT SAMPLE DATA
-- ===============================================

-- Instructors (10)
INSERT INTO instructors (name, email, hire_date) VALUES
('Alice Johnson','alice.johnson@example.com','2020-01-15'),
('Bob Smith','bob.smith@example.com','2019-03-10'),
('Carol Lee','carol.lee@example.com','2021-06-25'),
('David Brown','david.brown@example.com','2018-09-05'),
('Eva Green','eva.green@example.com','2020-11-12'),
('Frank White','frank.white@example.com','2019-08-18'),
('Grace Kim','grace.kim@example.com','2021-02-20'),
('Henry Adams','henry.adams@example.com','2020-05-30'),
('Ivy Clark','ivy.clark@example.com','2019-07-22'),
('Jack Turner','jack.turner@example.com','2018-12-01');

-- Courses (15)
INSERT INTO courses (course_name, description, instructor_id) VALUES
('Math 101','Basic Mathematics',1),
('Physics 101','Introduction to Physics',2),
('Chemistry 101','Basic Chemistry',3),
('Biology 101','Introduction to Biology',4),
('English 101','English Grammar & Writing',5),
('History 101','World History Overview',6),
('Computer Science 101','Introduction to CS',7),
('Economics 101','Basic Economics',8),
('Art 101','Introduction to Art',9),
('Music 101','Basic Music Theory',10),
('Math 102','Intermediate Mathematics',1),
('Physics 102','Intermediate Physics',2),
('Chemistry 102','Intermediate Chemistry',3),
('Biology 102','Intermediate Biology',4),
('English 102','Advanced English',5);

-- Modules (3 per course)
INSERT INTO modules (course_id, module_name, module_order) VALUES
(1,'Math Basics',1),
(1,'Algebra',2),
(1,'Geometry',3),
(2,'Physics Basics',1),
(2,'Mechanics',2),
(2,'Optics',3),
(3,'Chemistry Basics',1),
(3,'Organic Chemistry',2),
(3,'Inorganic Chemistry',3),
(4,'Biology Basics',1),
(4,'Human Anatomy',2),
(4,'Genetics',3),
(5,'Grammar',1),
(5,'Writing Skills',2),
(5,'Literature',3),
(6,'Ancient History',1),
(6,'Medieval History',2),
(6,'Modern History',3),
(7,'Programming Basics',1),
(7,'Data Structures',2),
(7,'Algorithms',3),
(8,'Microeconomics',1),
(8,'Macroeconomics',2),
(8,'Econometrics',3),
(9,'Drawing',1),
(9,'Painting',2),
(9,'Sculpture',3),
(10,'Music Theory',1),
(10,'Singing',2),
(10,'Instruments',3),
(11,'Advanced Algebra',1),
(11,'Trigonometry',2),
(11,'Calculus',3),
(12,'Advanced Mechanics',1),
(12,'Electromagnetism',2),
(12,'Thermodynamics',3),
(13,'Advanced Organic',1),
(13,'Advanced Inorganic',2),
(13,'Chemical Reactions',3),
(14,'Advanced Anatomy',1),
(14,'Physiology',2),
(14,'Biotechnology',3),
(15,'Advanced Writing',1),
(15,'Poetry',2),
(15,'Creative Writing',3);

-- Students (50)
INSERT INTO students (name, email, dob, enrollment_date) VALUES
('Student1','student1@example.com','2000-01-01','2023-01-01'),
('Student2','student2@example.com','2000-02-01','2023-01-02'),
('Student3','student3@example.com','2000-03-01','2023-01-03'),
('Student4','student4@example.com','2000-04-01','2023-01-04'),
('Student5','student5@example.com','2000-05-01','2023-01-05'),
('Student6','student6@example.com','2000-06-01','2023-01-06'),
('Student7','student7@example.com','2000-07-01','2023-01-07'),
('Student8','student8@example.com','2000-08-01','2023-01-08'),
('Student9','student9@example.com','2000-09-01','2023-01-09'),
('Student10','student10@example.com','2000-10-01','2023-01-10'),
('Student11','student11@example.com','2000-11-01','2023-01-11'),
('Student12','student12@example.com','2000-12-01','2023-01-12'),
('Student13','student13@example.com','2001-01-01','2023-01-13'),
('Student14','student14@example.com','2001-02-01','2023-01-14'),
('Student15','student15@example.com','2001-03-01','2023-01-15'),
('Student16','student16@example.com','2001-04-01','2023-01-16'),
('Student17','student17@example.com','2001-05-01','2023-01-17'),
('Student18','student18@example.com','2001-06-01','2023-01-18'),
('Student19','student19@example.com','2001-07-01','2023-01-19'),
('Student20','student20@example.com','2001-08-01','2023-01-20'),
('Student21','student21@example.com','2001-09-01','2023-01-21'),
('Student22','student22@example.com','2001-10-01','2023-01-22'),
('Student23','student23@example.com','2001-11-01','2023-01-23'),
('Student24','student24@example.com','2001-12-01','2023-01-24'),
('Student25','student25@example.com','2002-01-01','2023-01-25'),
('Student26','student26@example.com','2002-02-01','2023-01-26'),
('Student27','student27@example.com','2002-03-01','2023-01-27'),
('Student28','student28@example.com','2002-04-01','2023-01-28'),
('Student29','student29@example.com','2002-05-01','2023-01-29'),
('Student30','student30@example.com','2002-06-01','2023-01-30'),
('Student31','student31@example.com','2002-07-01','2023-01-31'),
('Student32','student32@example.com','2002-08-01','2023-02-01'),
('Student33','student33@example.com','2002-09-01','2023-02-02'),
('Student34','student34@example.com','2002-10-01','2023-02-03'),
('Student35','student35@example.com','2002-11-01','2023-02-04'),
('Student36','student36@example.com','2002-12-01','2023-02-05'),
('Student37','student37@example.com','2003-01-01','2023-02-06'),
('Student38','student38@example.com','2003-02-01','2023-02-07'),
('Student39','student39@example.com','2003-03-01','2023-02-08'),
('Student40','student40@example.com','2003-04-01','2023-02-09'),
('Student41','student41@example.com','2003-05-01','2023-02-10'),
('Student42','student42@example.com','2003-06-01','2023-02-11'),
('Student43','student43@example.com','2003-07-01','2023-02-12'),
('Student44','student44@example.com','2003-08-01','2023-02-13'),
('Student45','student45@example.com','2003-09-01','2023-02-14'),
('Student46','student46@example.com','2003-10-01','2023-02-15'),
('Student47','student47@example.com','2003-11-01','2023-02-16'),
('Student48','student48@example.com','2003-12-01','2023-02-17'),
('Student49','student49@example.com','2004-01-01','2023-02-18'),
('Student50','student50@example.com','2004-02-01','2023-02-19');

-- ===============================================
-- 4. INDEXES FOR OPTIMIZATION
-- ===============================================
CREATE INDEX idx_enrollment_student ON enrollments(student_id);
CREATE INDEX idx_enrollment_course ON enrollments(course_id);
CREATE INDEX idx_grades_module ON grades(module_id);
CREATE INDEX idx_attendance_module ON attendance(module_id);

-- ===============================================
-- 5. STANDARD QUERIES
-- ===============================================

-- a) Courses a student is enrolled in
SELECT s.name AS student_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = 1;

-- b) Student’s grade for a specific module
SELECT s.name AS student_name, m.module_name, g.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
JOIN modules m ON g.module_id = m.module_id
WHERE s.student_id = 1 AND m.module_id = 2;

-- c) Attendance record for a student in a course
SELECT s.name AS student_name, m.module_name, a.status, a.attendance_date
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN attendance a ON e.enrollment_id = a.enrollment_id
JOIN modules m ON a.module_id = m.module_id
WHERE s.student_id = 1 AND e.course_id = 1
ORDER BY a.attendance_date;

-- ===============================================
-- 6. ADVANCED REPORTING QUERIES
-- ===============================================

-- Top 5 Most Active Students
SELECT s.name AS student_name, COUNT(g.grade_id) AS modules_completed
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
WHERE g.grade IS NOT NULL
GROUP BY s.name
ORDER BY modules_completed DESC
LIMIT 5;

-- Most Enrolled Courses
SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrolled
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY total_enrolled DESC
LIMIT 5;

-- Course Completion Rate
SELECT c.course_name,
ROUND((COUNT(DISTINCT g.enrollment_id) / COUNT(DISTINCT e.enrollment_id)) * 100, 2) AS completion_rate
FROM courses c
JOIN modules m ON c.course_id = m.course_id
JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN grades g ON e.enrollment_id = g.enrollment_id AND m.module_id = g.module_id
GROUP BY c.course_name;

-- Instructor Performance
SELECT i.name AS instructor_name, 
AVG(CASE WHEN g.grade='A' THEN 4 WHEN g.grade='B' THEN 3 
         WHEN g.grade='C' THEN 2 WHEN g.grade='D' THEN 1 ELSE 0 END) AS avg_grade_points
FROM instructors i
JOIN courses c ON i.instructor_id = c.instructor_id
JOIN enrollments e ON c.course_id = e.course_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
GROUP BY i.name
ORDER BY avg_grade_points DESC;

-- Student Attendance Report
SELECT s.name AS student_name, m.module_name, a.status, a.attendance_date
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN attendance a ON e.enrollment_id = a.enrollment_id
JOIN modules m ON a.module_id = m.module_id
WHERE s.student_id = 1
ORDER BY a.attendance_date;
