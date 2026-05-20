from flask import Flask, jsonify
import os
import psycopg2

app = Flask(__name__)

def get_db_connection():
    return psycopg2.connect(
        host=os.getenv("DB_HOST", "db"),
        database=os.getenv("DB_NAME", "taskdb"),
        user=os.getenv("DB_USER", "devops"),
        password=os.getenv("DB_PASSWORD", "devops123"),
        port=int(os.getenv("DB_PORT", "5432")),
    )

@app.route("/")
def home():
    return jsonify({
        "message": "Day 36 Docker Project - Task Manager API",
        "status": "running"
    })

@app.route("/health")
def health():
    return jsonify({"status": "healthy"}), 200

@app.route("/tasks", methods=["GET"])
def list_tasks():
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("SELECT id, title, done FROM tasks ORDER BY id;")
    rows = cur.fetchall()
    cur.close()
    conn.close()
    tasks = [{"id": r[0], "title": r[1], "done": r[2]} for r in rows]
    return jsonify(tasks)

@app.route("/tasks", methods=["POST"])
def add_task():
    from flask import request
    title = request.json.get("title", "Untitled task")
    conn = get_db_connection()
    cur = conn.cursor()
    cur.execute("INSERT INTO tasks (title, done) VALUES (%s, %s) RETURNING id;", (title, False))
    task_id = cur.fetchone()[0]
    conn.commit()
    cur.close()
    conn.close()
    return jsonify({"id": task_id, "title": title, "done": False}), 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
