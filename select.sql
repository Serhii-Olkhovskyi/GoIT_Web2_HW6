--1 Найти 5 студентов с наибольшим средним баллом по всем предметам
SELECT s.fullname, ROUND(AVG(g.grade),2) as average_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
GROUP BY s.fullname
ORDER BY average_grade DESC
LIMIT 5;

--2 Найти студента с наивысшим средним баллом по определенному предмету
SELECT o.name, s.fullname, ROUND(AVG(g.grade),2) as average_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN objects o ON o.id = g.object_id
WHERE o.id = 7
GROUP BY s.fullname
ORDER BY average_grade DESC
LIMIT 1;

--3 Найти средний балл в группах по определенному предмету
SELECT o.name, gr.name, ROUND(AVG(g.grade),2) as average_grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN objects o ON o.id = g.object_id
LEFT JOIN [groups] gr ON gr.id = s.group_id
WHERE o.id = 1
GROUP BY gr.name, o.name
ORDER BY average_grade DESC;

--4 Найти средний балл на потоке (по всей таблице оценок)
SELECT ROUND(AVG(g.grade),2) as average_grade
FROM grades g;

--5 Найти какие курсы читает определенный преподаватель
SELECT t.fullname, o.name
FROM teachers t
LEFT JOIN objects o ON o.teacher_id = t.id
WHERE t.id = 1;


--6 Найти список студентов в определенной группе
SELECT gr.name, s.fullname
FROM [groups] gr
LEFT JOIN students s ON gr.id = s.group_id
WHERE gr.id = 1;

--7 Найти оценки студентов в отдельной группе по определенному предмету
SELECT s.fullname, g.grade
FROM grades g
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN objects o ON o.id = g.object_id
LEFT JOIN [groups] gr ON gr.id = s.group_id
WHERE o.id = 1 AND gr.id = 1;

--8 Найти средний балл, который ставит определенный преподаватель по своим предметам
SELECT t.fullname, o.name, ROUND(AVG(g.grade),2) as average_grade
FROM grades g
LEFT JOIN objects o ON o.id = g.object_id
LEFT JOIN teachers t ON o.teacher_id = t.id
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN [groups] gr ON gr.id = s.group_id
WHERE t.id = 2
GROUP BY t.fullname, o.name;


--9 Найти список курсов, которые посещает определенный студент
SELECT s.fullname, o.name
FROM grades g
LEFT JOIN objects o ON o.id = g.object_id
LEFT JOIN students s ON s.id = g.student_id
WHERE s.id = 1
GROUP BY s.fullname, o.name;

--10 Список курсов, которые определенному студенту читает определенный преподаватель
SELECT s.fullname, t.fullname, o.name
FROM grades g
LEFT JOIN objects o ON o.id = g.object_id
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN teachers t ON o.teacher_id = t.id
WHERE s.id = 1 and t.id = 1
GROUP BY o.name;

--11 Средний балл, который определенный преподаватель ставит определенному студенту
SELECT t.fullname, o.name, ROUND(AVG(g.grade),2) as average_grade
FROM grades g
LEFT JOIN objects o ON o.id = g.object_id
LEFT JOIN teachers t ON o.teacher_id = t.id
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN [groups] gr ON gr.id = s.group_id
WHERE t.id = 1 and s.id = 1
GROUP BY t.fullname, o.name;

--12 Оценки студентов в определенной группе по определенному предмету на последнем занятии
SELECT s.fullname, o.name, gr.name, g.grade, g.date_of
FROM grades g
LEFT JOIN objects o ON o.id = g.object_id
LEFT JOIN teachers t ON o.teacher_id = t.id
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN [groups] gr ON gr.id = s.group_id
WHERE o.id = 3 and gr.id = 3 and g.date_of = (SELECT MAX(g.date_of) as max_date
FROM grades g
LEFT JOIN objects o ON o.id = g.object_id
LEFT JOIN students s ON s.id = g.student_id
LEFT JOIN [groups] gr ON gr.id = s.group_id
WHERE o.id = 3 and gr.id = 3);











