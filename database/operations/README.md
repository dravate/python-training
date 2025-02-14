# Database Programming 

## Create Database using Schema File


### create_db.py

```

#create_db.py

import os
import sqlite3

db_filename = 'todo.db'
new_db = not os.path.exists(db_filename)

conn = sqlite3.connect(db_filename)

if new_db:
    print('Please create Schema')
else:
    print('Database already created - mostly schema exists')
conn.close()

```

### create_schema.py

```

#create_schema.py
import os
import sqlite3

db_filename = 'todo.db'
schema_filename = 'todo_schema.sql'

new_db = not os.path.exists(db_filename)

with sqlite3.connect(db_filename) as conn:
    if new_db:
        print('Let us create schema')
        with open(schema_filename, 'r') as f:
            schema = f.read()
        conn.executescript(schema)

        print('Inserting initial data')

        conn.executescript("""
        insert into project (name, description, deadline)
        values ('assignments', 'Assignments - Python for Data Science', '2017-05-24');

        insert into task (details, status, deadline, project)
        values ('assignment 1', 'done', '2017-01-29', 'assignments');

        insert into task (details, status, deadline, project)
        values ('assignment 2', 'in progress', '2017-02-22', 'assignments');

        insert into task (details, status, deadline, project)
        values ('assignment 3', 'active', '2017-03-31', 'assignments');
        """)
    else:
        print('Database exists, assume schema does, too.')


```

## Retrive Data 

### select_task.py
```
# select_task.py
import sqlite3

db_filename = 'todo.db'

with sqlite3.connect(db_filename) as conn:
    cursor = conn.cursor()

    cursor.execute(""" select id, priority, details, status, deadline from task where project = 'assignments' """)

    for row in cursor.fetchall():
    #for row in cursor.fetchmany(2):
        task_id, priority, details, status, deadline = row
        print('{:2d} [{:d}] {:<25} [{:<8}] ({})'.format( task_id, priority, details, status, deadline))


```


###  Argument Named Programm

```
# argument_named.py

import sqlite3
import sys

db_filename = 'todo.db'
project_name = sys.argv[1]

with sqlite3.connect(db_filename) as conn:
    cursor = conn.cursor()

    query = """ select id, priority, details, status, deadline from task where project = :project_name order by deadline, priority """

    cursor.execute(query, {'project_name': project_name})

    for row in cursor.fetchall():
        task_id, priority, details, status, deadline = row
        print('{:2d} [{:d}] {:<25} [{:<8}] ({})'.format(task_id, priority, details, status, deadline))

```

### Update 

```

#argument_update.py

import sqlite3
import sys

db_filename = 'todo.db'
id = int(sys.argv[1])
status = sys.argv[2]

with sqlite3.connect(db_filename) as conn:
    cursor = conn.cursor()
    query = "update task set status = :status where id = :id"
    cursor.execute(query, {'status': status, 'id': id})

```

###  Load from CSV

```
import csv
import sqlite3
import sys

db_filename = 'todo.db'
data_filename = sys.argv[1]

SQL = """ insert into task (details, priority, status, deadline, project) values (:details, :priority, 'active', :deadline, :project) """

with open(data_filename, 'r') as csv_file:
    csv_reader = csv.DictReader(csv_file)
    with sqlite3.connect(db_filename) as conn:
        cursor = conn.cursor()
        cursor.executemany(SQL, csv_reader)
```

The tasks file used here is: 

```
deadline,project,priority,details
2017-03-01,assignments,2,"Submission of all assignments"
2017-03-08,assignments,3,"Work on Project"
2017-03-16,assignments,1,"Finish Documentation"
```

