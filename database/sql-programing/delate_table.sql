# Delete a specific task 
DELETE FROM tasks WHERE id = 3;

# Delete a project (cascades to tasks due to FOREIGN KEY constraint)
DELETE FROM projects WHERE id = 1;


