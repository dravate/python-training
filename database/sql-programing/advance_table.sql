#Find overdue tasks
SELECT * FROM tasks
WHERE due_date < CURDATE() AND status != 'Completed';

#List all projects with their latest task's due date
SELECT p.name, MAX(t.due_date) AS last_task_due_date
FROM projects p
JOIN tasks t ON p.id = t.project_id
GROUP BY p.name;

