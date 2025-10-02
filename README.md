# Lms_db
1️⃣ Database Design & Tables

a) Students Table

CREATE TABLE students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    dob DATE,
    enrollment_date DATE DEFAULT CURRENT_DATE
);

Explanation:

student_id INT AUTO_INCREMENT PRIMARY KEY: Each student has a unique ID that auto-increments.

name VARCHAR(100) NOT NULL: Student’s name (cannot be empty).

email VARCHAR(100) NOT NULL UNIQUE: Unique email for each student.

dob DATE: Date of birth.

enrollment_date DATE DEFAULT CURRENT_DATE: Auto-sets the enrollment date if not provided.



---

b) Instructors Table

CREATE TABLE instructors (
    instructor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    hire_date DATE DEFAULT CURRENT_DATE
);

Explanation:

Each instructor has a unique ID.

Stores name, email (unique), and hire_date.



---

c) Courses Table

CREATE TABLE courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    instructor_id INT,
    FOREIGN KEY (instructor_id) REFERENCES instructors(instructor_id)
);

Explanation:

Each course has a unique ID, name, and description.

instructor_id links the course to the instructor.

FOREIGN KEY ensures the instructor exists in instructors table.



---

d) Modules Table

CREATE TABLE modules (
    module_id INT AUTO_INCREMENT PRIMARY KEY,
    course_id INT,
    module_name VARCHAR(100),
    module_order INT,
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

Explanation:

Each course has multiple modules.

module_order indicates sequence of modules.

FOREIGN KEY course_id links module to its course.



---

e) Enrollments Table

CREATE TABLE enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    enrollment_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (student_id) REFERENCES students(student_id),
    FOREIGN KEY (course_id) REFERENCES courses(course_id)
);

Explanation:

Junction table linking students and courses (many-to-many relationship).

enrollment_date defaults to current date.



---

f) Grades Table

CREATE TABLE grades (
    grade_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    module_id INT,
    grade VARCHAR(2),
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

Explanation:

Stores grades per module for each student.

Links to enrollments and modules.



---

g) Attendance Table

CREATE TABLE attendance (
    attendance_id INT AUTO_INCREMENT PRIMARY KEY,
    enrollment_id INT,
    module_id INT,
    status BOOLEAN DEFAULT TRUE,
    attendance_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (enrollment_id) REFERENCES enrollments(enrollment_id),
    FOREIGN KEY (module_id) REFERENCES modules(module_id)
);

Explanation:

Tracks attendance for each student per module.

status TRUE/FALSE indicates present/absent.



---

2️⃣ Indexes for Optimization

CREATE INDEX idx_enrollment_student ON enrollments(student_id);
CREATE INDEX idx_enrollment_course ON enrollments(course_id);
CREATE INDEX idx_grades_module ON grades(module_id);
CREATE INDEX idx_attendance_module ON attendance(module_id);

Explanation:

Indexes make searches faster on columns used in WHERE clauses or JOINs.



---

3️⃣ Sample Queries Explained

a) All courses a student is enrolled in

SELECT s.name AS student_name, c.course_name
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE s.student_id = 1;

Explanation:

JOIN connects students → enrollments → courses.

Fetches all courses for student with student_id=1.



---

b) Student’s grade for a specific module

SELECT s.name AS student_name, m.module_name, g.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
JOIN modules m ON g.module_id = m.module_id
WHERE s.student_id = 1 AND m.module_id = 2;Shows grade of a specific student in a specific module.



---

c) Attendance record for a student in a course

SELECT s.name AS student_name, m.module_name, a.status, a.attendance_date
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN attendance a ON e.enrollment_id = a.enrollment_id
JOIN modules m ON a.module_id = m.module_id
WHERE s.student_id = 1 AND e.course_id = 1
ORDER BY a.attendance_date;

Fetches attendance for student 1 in course 1, sorted by date.



---

d) Top 5 Most Active Students

SELECT s.name AS student_name, COUNT(g.grade_id) AS modules_completed
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
WHERE g.grade IS NOT NULL
GROUP BY s.name
ORDER BY modules_completed DESC
LIMIT 5;

Counts completed modules per student and lists top 5.



---

e) Most Enrolled Courses

SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrolled
FROM courses c
JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_name
ORDER BY total_enrolled DESC
LIMIT 5;

Shows courses with highest number of students.



---

f) Instructor Performance

SELECT i.name AS instructor_name, 
AVG(CASE WHEN g.grade='A' THEN 4 WHEN g.grade='B' THEN 3 
         WHEN g.grade='C' THEN 2 WHEN g.grade='D' THEN 1 ELSE 0 END) AS avg_grade_points
FROM instructors i
JOIN courses c ON i.instructor_id = c.instructor_id
JOIN enrollments e ON c.course_id = e.course_id
JOIN grades g ON e.enrollment_id = g.enrollment_id
GROUP BY i.name
ORDER BY avg_grade_points DESC;

Calculates average grade per instructor.

Grades are converted to points: A=4, B=3, etc.



---

g) Course Completion Rate

SELECT c.course_name,
ROUND((COUNT(DISTINCT g.enrollment_id) / COUNT(DISTINCT e.enrollment_id)) * 100, 2) AS completion_rate
FROM courses c
JOIN modules m ON c.course_id = m.course_id
JOIN enrollments e ON c.course_id = e.course_id
LEFT JOIN grades g ON e.enrollment_id = g.enrollment_id AND m.module_id = g.module_id
GROUP BY c.course_name;

Calculates percentage of students completing all modules.



---

✅ Summary of Design Choices

1. Normalization:

Tables in 3NF → no redundancy.

Modules separate from courses. Grades separate from enrollments.



2. Indexes:

Used on student_id, course_id, module_id to speed up JOINs & queries.



3. Many-to-Many Relationships:

enrollments table connects students & courses.



4. Analytics Queries:

Designed to answer real business questions: top students, course popularity, instructor performance.
