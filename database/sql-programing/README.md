# Database Session 




##  SQL Language 



### Create Tables  

```
# create_table.sql

CREATE TABLE projects (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE tasks (
    id INT PRIMARY KEY AUTO_INCREMENT,
    project_id INT,
    title VARCHAR(255) NOT NULL,
    status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    due_date DATE,
    FOREIGN KEY (project_id) REFERENCES projects(id) ON DELETE CASCADE
);


```

### Inserting Data (DML - Data Manipulation Language)

```
# insert_table.sql

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

```

###  Querying Data (DQL - Data Query Language)

```
# query_table.sql

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


```

### Updating Data (DML - Data Manipulation Language)

```

#update_table.sql

# Change task status
 
UPDATE tasks
SET status = 'Completed'
WHERE id = 1;

# Postpone a due date

UPDATE tasks
SET due_date = '2025-03-10'
WHERE title = 'Set Up Database';

```

### Deleting Data (DML - Data Manipulation Language)


```
# delate_table.sql 

# Delete a specific task 
DELETE FROM tasks WHERE id = 3;

# Delete a project (cascades to tasks due to FOREIGN KEY constraint)
DELETE FROM projects WHERE id = 1;


```

### Advanced Queries

```
# advance_table.sql

#Find overdue tasks
SELECT * FROM tasks
WHERE due_date < CURDATE() AND status != 'Completed';

#List all projects with their latest task's due date
SELECT p.name, MAX(t.due_date) AS last_task_due_date
FROM projects p
JOIN tasks t ON p.id = t.project_id
GROUP BY p.name;


```




