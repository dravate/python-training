# Change task status
 
UPDATE tasks
SET status = 'Completed'
WHERE id = 1;

# Postpone a due date

UPDATE tasks
SET due_date = '2025-03-10'
WHERE title = 'Set Up Database';

