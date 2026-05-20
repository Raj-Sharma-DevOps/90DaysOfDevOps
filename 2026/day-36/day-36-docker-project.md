# Day 36 – Docker Project: Dockerize a Full Application

# Task 1: Pick Your App

## App Chosen

I chose a **Python Flask Task Manager API** with PostgreSQL because:

- It demonstrates a real backend + database stack
- It reuses concepts from Days 31–34 (Dockerfile, Compose, volumes, healthchecks)
- It is small enough to Dockerize in one day but realistic enough for production patterns

---

# Project Structure

```text
2026/day-36/docker-project/
├── app/
│   ├── Dockerfile
│   ├── .dockerignore
│   ├── app.py
│   ├── requirements.txt
│   └── entrypoint.sh
├── docker-compose.yml
├── .env.example
└── README.md
```

---

# Task 2: Write the Dockerfile

## Dockerfile (Multi-Stage, Non-Root)

```Dockerfile
FROM python:3.12-slim AS builder

WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

FROM python:3.12-slim

RUN groupadd -r appuser && useradd -r -g appuser -u 10001 appuser

WORKDIR /app

COPY --from=builder /usr/local/lib/python3.12/site-packages /usr/local/lib/python3.12/site-packages
COPY --from=builder /usr/local/bin /usr/local/bin
COPY app.py entrypoint.sh ./

RUN chmod +x entrypoint.sh && chown -R appuser:appuser /app

USER appuser

EXPOSE 5000

HEALTHCHECK --interval=30s --timeout=5s --start-period=10s --retries=3 \
  CMD python -c "import urllib.request; urllib.request.urlopen('http://localhost:5000/health')" || exit 1

ENTRYPOINT ["./entrypoint.sh"]
```

---

## Key Design Decisions

| Line / Instruction | Purpose |
|---|---|
| `AS builder` | Install Python deps in build stage only |
| `python:3.12-slim` | Smaller runtime base than full Python image |
| `USER appuser` | Run as non-root for security |
| `HEALTHCHECK` | Lets Compose/Orchestrators know when app is ready |
| `entrypoint.sh` | Waits for DB, runs migrations, starts gunicorn |

---

## Build and Test Locally

```bash
cd 2026/day-36/docker-project
docker build -t task-manager-api:latest ./app
docker run -d -p 5000:5000 --name task-test task-manager-api:latest
curl http://localhost:5000/health
docker stop task-test && docker rm task-test
```

---

## Final Image Size

```bash
docker images task-manager-api:latest
```

Approximate size: **~180 MB** (slim Python base + dependencies)

---

# Task 3: Add Docker Compose

## docker-compose.yml

```yaml
services:
  app:
    build: ./app
    container_name: task-manager-api
    ports:
      - "${APP_PORT:-5000}:5000"
    env_file:
      - .env
    depends_on:
      db:
        condition: service_healthy
    networks:
      - task-network
    restart: unless-stopped

  db:
    image: postgres:16-alpine
    container_name: task-manager-db
    environment:
      POSTGRES_DB: ${DB_NAME:-taskdb}
      POSTGRES_USER: ${DB_USER:-devops}
      POSTGRES_PASSWORD: ${DB_PASSWORD:-devops123}
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - task-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U devops -d taskdb"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: always

networks:
  task-network:
    driver: bridge

volumes:
  postgres-data:
```

---

## Run Full Stack

```bash
cp .env.example .env
docker compose up --build -d
docker compose ps
curl http://localhost:5000/tasks
curl -X POST http://localhost:5000/tasks \
  -H "Content-Type: application/json" \
  -d '{"title":"Complete Day 36"}'
curl http://localhost:5000/tasks
```

---

## Observation

Both services started successfully. The app waited for PostgreSQL healthcheck before starting. Tasks persisted in the named volume.

---

# Task 4: Ship It

## Tag and Push

```bash
docker tag task-manager-api:latest yourusername/task-manager-api:latest
docker login
docker push yourusername/task-manager-api:latest
```

---

## Docker Hub Link

```text
https://hub.docker.com/r/yourusername/task-manager-api
```

---

# Task 5: Test the Whole Flow

## Fresh Pull Test

```bash
docker compose down -v
docker rmi task-manager-api:latest yourusername/task-manager-api:latest
docker pull yourusername/task-manager-api:latest
# Update compose to use image instead of build for fresh test
docker compose up -d
curl http://localhost:5000/health
```

---

## Observation

The app ran successfully from a clean pull using only Compose and environment config.

---

# Challenges Faced

| Challenge | Solution |
|---|---|
| App started before DB was ready | Added `entrypoint.sh` with retry loop + Compose `depends_on: service_healthy` |
| Database schema not created | Entrypoint runs `CREATE TABLE IF NOT EXISTS` on startup |
| Large image size | Multi-stage build copies only installed packages to slim runtime |

---

# Useful Commands

```bash
docker compose up --build -d
docker compose ps
docker compose logs -f app
docker compose down
docker compose down -v
curl http://localhost:5000/health
curl http://localhost:5000/tasks
docker push yourusername/task-manager-api:latest
```

---

# Final Summary

Today I Dockerized a complete Flask + PostgreSQL application end-to-end:

- Multi-stage Dockerfile with non-root user
- Docker Compose with healthchecks, volumes, and custom network
- Environment-based configuration via `.env`
- Image pushed to Docker Hub and verified with a fresh pull

This is the same workflow used in real DevOps teams: build, compose, ship, verify.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
