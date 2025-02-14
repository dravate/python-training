# 1. Install Required Packages

You need the psycopg2 library to interact with PostgreSQL from Python.

```
pip install psycopg2

```
Or install the binary version (easier to set up):

```
pip install psycopg2-binary

```

# 2. Connect to PostgreSQL

```

import psycopg2

# Database connection parameters
conn = psycopg2.connect(
    dbname="mydatabase",
    user="myuser",
    password="mypassword",
    host="localhost",
    port="5432"
)

# Create a cursor object to execute SQL commands
cur = conn.cursor()

print("Connected to the database successfully!")

# Close connection
cur.close()
conn.close()


```

# 3. Create a Table (Project & Tasks Example)

Let's create a Projects table and a Tasks table.

```
cur = conn.cursor()

# Create Projects table
cur.execute("""
CREATE TABLE IF NOT EXISTS projects (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    description TEXT
);
""")

# Create Tasks table
cur.execute("""
CREATE TABLE IF NOT EXISTS tasks (
    id SERIAL PRIMARY KEY,
    project_id INT REFERENCES projects(id) ON DELETE CASCADE,
    title VARCHAR(255) NOT NULL,
    status VARCHAR(50) CHECK (status IN ('Pending', 'In Progress', 'Completed'))
);
""")

conn.commit()
print("Tables created successfully!")

cur.close()
conn.close()

```
# 4. Insert Data into Tables

Let's insert a project and some tasks.

```
conn = psycopg2.connect( ... )  # Use your connection details
cur = conn.cursor()

# Insert a project
cur.execute("INSERT INTO projects (name, description) VALUES (%s, %s) RETURNING id;", 
            ("Karmantika Platform", "A job portal and e-commerce system"))
project_id = cur.fetchone()[0]

# Insert tasks related to the project
cur.execute("INSERT INTO tasks (project_id, title, status) VALUES (%s, %s, %s);",
            (project_id, "Set up PostgreSQL database", "Pending"))

cur.execute("INSERT INTO tasks (project_id, title, status) VALUES (%s, %s, %s);",
            (project_id, "Build the API with Django", "In Progress"))

conn.commit()
print("Data inserted successfully!")

cur.close()
conn.close()

```

# 5. Retrieve Data (Fetching Tasks for a Project)

```
conn = psycopg2.connect( ... )  
cur = conn.cursor()

# Fetch tasks for a specific project
cur.execute("""
SELECT tasks.id, tasks.title, tasks.status 
FROM tasks 
JOIN projects ON tasks.project_id = projects.id
WHERE projects.name = %s;
""", ("Karmantika Platform",))

tasks = cur.fetchall()
for task in tasks:
    print(task)

cur.close()
conn.close()

```

# 6. Update and Delete Data

## Update a Task's Status

```
cur.execute("UPDATE tasks SET status = %s WHERE id = %s;", ("Completed", 1))
conn.commit()

```

## Delete a Task

```
cur.execute("DELETE FROM tasks WHERE id = %s;", (1,))
conn.commit()
```


