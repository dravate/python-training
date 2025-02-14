-- Insert projects
INSERT INTO projects (name) VALUES ('Website Redesign');
INSERT INTO projects (name) VALUES ('Mobile App Development');

-- Insert tasks under projects
INSERT INTO tasks (project_id, title, status, due_date) 
VALUES (1, 'Create Wireframes', 'Pending', '2025-02-20');

INSERT INTO tasks (project_id, title, status, due_date) 
VALUES (1, 'Develop UI Components', 'In Progress', '2025-02-25');

INSERT INTO tasks (project_id, title, status, due_date) 
VALUES (2, 'Set Up Database', 'Pending', '2025-03-01');

