#!/bin/sh
set -e

echo "Waiting for PostgreSQL..."
until python -c "
import os, psycopg2, time, sys
for i in range(30):
    try:
        conn = psycopg2.connect(
            host=os.getenv('DB_HOST','db'),
            database=os.getenv('DB_NAME','taskdb'),
            user=os.getenv('DB_USER','devops'),
            password=os.getenv('DB_PASSWORD','devops123'),
            port=int(os.getenv('DB_PORT','5432'))
        )
        conn.close()
        sys.exit(0)
    except Exception:
        time.sleep(2)
sys.exit(1)
"; do
  echo "Database not ready, retrying..."
  sleep 2
done

python -c "
import os, psycopg2
conn = psycopg2.connect(
    host=os.getenv('DB_HOST','db'),
    database=os.getenv('DB_NAME','taskdb'),
    user=os.getenv('DB_USER','devops'),
    password=os.getenv('DB_PASSWORD','devops123'),
    port=int(os.getenv('DB_PORT','5432'))
)
cur = conn.cursor()
cur.execute('''
    CREATE TABLE IF NOT EXISTS tasks (
        id SERIAL PRIMARY KEY,
        title VARCHAR(200) NOT NULL,
        done BOOLEAN DEFAULT FALSE
    );
''')
cur.execute(\"INSERT INTO tasks (title, done) SELECT 'Learn Docker end-to-end', false WHERE NOT EXISTS (SELECT 1 FROM tasks);\")
conn.commit()
cur.close()
conn.close()
"

exec gunicorn --bind 0.0.0.0:5000 app:app
