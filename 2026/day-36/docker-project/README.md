# Task Manager API

A simple Flask REST API with PostgreSQL, fully Dockerized for the Day 36 DevOps challenge.

## What It Does

- Lists and creates tasks via REST endpoints
- Connects to PostgreSQL for persistence
- Multi-stage Docker build with non-root user
- Runs via Docker Compose with healthchecks and named volumes

## Quick Start

```bash
cp .env.example .env
docker compose up --build -d
curl http://localhost:5000/health
curl http://localhost:5000/tasks
curl -X POST http://localhost:5000/tasks -H "Content-Type: application/json" -d '{"title":"Complete Day 36"}'
```

## Environment Variables

| Variable | Default | Description |
|---|---|---|
| `DB_HOST` | `db` | PostgreSQL hostname |
| `DB_PORT` | `5432` | PostgreSQL port |
| `DB_NAME` | `taskdb` | Database name |
| `DB_USER` | `devops` | Database user |
| `DB_PASSWORD` | `devops123` | Database password |
| `APP_PORT` | `5000` | Host port mapping |

## Docker Hub

```bash
docker tag task-manager-api:latest yourusername/task-manager-api:latest
docker push yourusername/task-manager-api:latest
```
