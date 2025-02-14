# Retrieve all projects
SELECT * FROM projects;

# Retrieve all tasks for a specific project
SELECT t.id, t.title, t.status, t.due_date 
FROM tasks t
JOIN projects p ON t.project_id = p.id
WHERE p.name = 'Website Redesign';

#Count tasks per project
SELECT p.name, COUNT(t.id) AS total_tasks
FROM projects p
LEFT JOIN tasks t ON p.id = t.project_id
GROUP BY p.name;


