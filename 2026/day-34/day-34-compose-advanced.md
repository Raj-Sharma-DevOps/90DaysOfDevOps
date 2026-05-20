# Day 34 – Docker Compose: Real-World Multi-Container Apps

# Task 1: Build Your Own App Stack

Today I created a production-like Docker Compose setup with three services:

- Web App
- Database
- Cache

I used:

- Node.js for the web app
- PostgreSQL as the database
- Redis as the cache

---

# Project Structure

```text
2026/day-34/
├── app/
│   ├── Dockerfile
│   ├── package.json
│   └── server.js
├── docker-compose.yml
└── day-34-compose-advanced.md
```

---

# app/package.json

```json
{
  "name": "compose-advanced-app",
  "version": "1.0.0",
  "main": "server.js",
  "scripts": {
    "start": "node server.js"
  },
  "dependencies": {
    "express": "^4.18.2",
    "pg": "^8.11.3",
    "redis": "^4.6.7"
  }
}
```

---

# app/server.js

```js
const express = require("express");
const { Pool } = require("pg");
const redis = require("redis");

const app = express();
const PORT = process.env.PORT || 3000;

const db = new Pool({
  host: process.env.DB_HOST || "postgres-db",
  user: process.env.DB_USER || "postgres",
  password: process.env.DB_PASSWORD || "postgres123",
  database: process.env.DB_NAME || "devopsdb",
  port: 5432,
});

const redisClient = redis.createClient({
  url: `redis://${process.env.REDIS_HOST || "redis-cache"}:6379`,
});

async function startServer() {
  try {
    await redisClient.connect();

    await db.query(`
      CREATE TABLE IF NOT EXISTS visits (
        id SERIAL PRIMARY KEY,
        message VARCHAR(100),
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
      );
    `);

    app.get("/", async (req, res) => {
      await db.query("INSERT INTO visits(message) VALUES($1)", [
        "Hello from Docker Compose advanced stack",
      ]);

      const result = await db.query("SELECT COUNT(*) FROM visits");
      const count = result.rows[0].count;

      await redisClient.set("last_visit_count", count);

      res.send(`
        <h1>Hello from Docker Compose Advanced Stack!</h1>
        <p>PostgreSQL is connected successfully.</p>
        <p>Redis is connected successfully.</p>
        <p>Total visits stored in database: ${count}</p>
      `);
    });

    app.listen(PORT, () => {
      console.log(`Web app running on port ${PORT}`);
    });
  } catch (error) {
    console.error("Application startup failed:", error);
    process.exit(1);
  }
}

startServer();
```

---

# app/Dockerfile

```Dockerfile
FROM node:20-alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

EXPOSE 3000

CMD ["npm", "start"]
```

---

# docker-compose.yml

```yaml
version: "3.8"

services:
  web:
    build: ./app
    container_name: advanced-web-app
    ports:
      - "3000:3000"
    environment:
      PORT: 3000
      DB_HOST: postgres-db
      DB_USER: postgres
      DB_PASSWORD: postgres123
      DB_NAME: devopsdb
      REDIS_HOST: redis-cache
    depends_on:
      postgres-db:
        condition: service_healthy
      redis-cache:
        condition: service_started
    networks:
      - app-network
    labels:
      project: "day-34-compose-advanced"
      service: "web-app"

  postgres-db:
    image: postgres:16
    container_name: postgres-db
    restart: always
    environment:
      POSTGRES_USER: postgres
      POSTGRES_PASSWORD: postgres123
      POSTGRES_DB: devopsdb
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - app-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U postgres -d devopsdb"]
      interval: 10s
      timeout: 5s
      retries: 5
    labels:
      project: "day-34-compose-advanced"
      service: "database"

  redis-cache:
    image: redis:7-alpine
    container_name: redis-cache
    restart: unless-stopped
    networks:
      - app-network
    labels:
      project: "day-34-compose-advanced"
      service: "cache"

networks:
  app-network:
    driver: bridge

volumes:
  postgres-data:
```

---

# Run the Stack

```bash
docker compose up -d
```

---

# Check Running Services

```bash
docker compose ps
```

---

# Access Web App

```text
http://localhost:3000
```

---

# Observation

The web app successfully connected to both PostgreSQL and Redis.

The browser showed:

```text
Hello from Docker Compose Advanced Stack!
PostgreSQL is connected successfully.
Redis is connected successfully.
Total visits stored in database: 1
```

---

# Task 2: depends_on & Healthchecks

## depends_on Used

```yaml
depends_on:
  postgres-db:
    condition: service_healthy
  redis-cache:
    condition: service_started
```

---

## Database Healthcheck

```yaml
healthcheck:
  test: ["CMD-SHELL", "pg_isready -U postgres -d devopsdb"]
  interval: 10s
  timeout: 5s
  retries: 5
```

---

## What This Does

The web app waits until PostgreSQL is healthy before starting.

Without healthcheck:

- Database container may start
- But database service may not be ready yet
- App may crash while trying to connect

With healthcheck:

- Compose checks PostgreSQL readiness
- Web app starts only after database becomes healthy

---

## Test

```bash
docker compose down
docker compose up -d
docker compose ps
```

---

## Observation

The app waited for the database to become healthy before starting.

---

# Task 3: Restart Policies

## restart: always

```yaml
restart: always
```

Used for database service.

---

## Kill Database Container

```bash
docker kill postgres-db
```

---

## Check Containers

```bash
docker compose ps
```

---

## Observation

The PostgreSQL container came back automatically.

---

## restart: on-failure

```yaml
restart: on-failure
```

This restarts the container only if it exits with an error code.

---

## Difference Between Restart Policies

| Restart Policy | Meaning |
|---|---|
| no | Never restart automatically |
| always | Always restart if stopped or crashed |
| on-failure | Restart only when container exits with error |
| unless-stopped | Restart unless manually stopped |

---

## When Would I Use Each?

- `always` → databases or important services that should always stay running
- `on-failure` → batch jobs or scripts that should retry only after failure
- `unless-stopped` → long-running apps that should restart after reboot but not if manually stopped
- `no` → temporary testing containers

---

# Task 4: Custom Dockerfiles in Compose

## build Used in Compose

```yaml
web:
  build: ./app
```

This tells Compose to build the web app image using the Dockerfile inside the `app` folder.

---

## Make Code Change

Example change in `server.js`:

```js
res.send("<h1>Updated Docker Compose App!</h1>");
```

---

## Rebuild and Restart

```bash
docker compose up --build -d
```

---

## Observation

Docker Compose rebuilt the web image and restarted the updated container with one command.

---

# Task 5: Named Networks & Volumes

## Explicit Network

```yaml
networks:
  app-network:
    driver: bridge
```

---

## Services Attached to Network

```yaml
networks:
  - app-network
```

---

## Named Volume

```yaml
volumes:
  postgres-data:
```

---

## Volume Attached to PostgreSQL

```yaml
volumes:
  - postgres-data:/var/lib/postgresql/data
```

---

## Labels

```yaml
labels:
  project: "day-34-compose-advanced"
  service: "web-app"
```

---

## Why This Is Useful

- Named networks improve clarity
- Named volumes persist database data
- Labels help organize containers in larger environments
- Service names work as DNS names inside the network

---

# Task 6: Scaling

## Try Scaling Web App

```bash
docker compose up -d --scale web=3
```

---

## What Happened?

Scaling failed or caused a port conflict because all three web containers tried to bind to the same host port:

```text
3000:3000
```

Only one container can use host port `3000` at a time.

---

## Why Simple Scaling Breaks With Port Mapping

When using:

```yaml
ports:
  - "3000:3000"
```

Docker maps host port `3000` to container port `3000`.

If we scale to 3 replicas, all replicas try to use the same host port, which is not allowed.

---

## Better Approach

Remove fixed host port mapping or use a reverse proxy/load balancer like:

- Nginx
- Traefik
- HAProxy

Example:

```yaml
ports:
  - "3000"
```

or use a load balancer in front of replicas.

---

# Useful Commands

```bash
docker compose up -d
docker compose down
docker compose ps
docker compose logs
docker compose logs -f web
docker compose up --build -d
docker compose restart web
docker compose up -d --scale web=3
docker kill postgres-db
docker volume ls
docker network ls
docker inspect postgres-db
```

---

# Screenshots

## Docker Compose Services Running

```text
Add screenshot here
```

---

## Web App Browser Output

```text
Add screenshot here
```

---

## PostgreSQL Healthcheck Status

```text
Add screenshot here
```

---

## Restart Policy Test

```text
Add screenshot here
```

---

## Scaling Error / Port Conflict

```text
Add screenshot here
```

---

# Final Summary

Today I learned:

- How to build a real 3-service app stack with Docker Compose
- How web app, database, and cache communicate using service names
- How to build custom app images using Dockerfile and Compose
- Why healthchecks are important
- How depends_on with service_healthy works
- Difference between restart policies
- How named networks and volumes improve structure
- Why simple scaling breaks when fixed host ports are used

Docker Compose is very useful for running production-like multi-container setups locally.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
