# Day 37 – Docker Revision & Self-Check

# Self-Assessment Checklist

| Skill | Status |
|---|---|
| Run a container from Docker Hub (interactive + detached) | Can do |
| List, stop, remove containers and images | Can do |
| Explain image layers and how caching works | Can do |
| Write a Dockerfile from scratch with FROM, RUN, COPY, WORKDIR, CMD | Can do |
| Explain CMD vs ENTRYPOINT | Can do |
| Build and tag a custom image | Can do |
| Create and use named volumes | Can do |
| Use bind mounts | Can do |
| Create custom networks and connect containers | Can do |
| Write a docker-compose.yml for a multi-container app | Can do |
| Use environment variables and .env files in Compose | Can do |
| Write a multi-stage Dockerfile | Can do |
| Push an image to Docker Hub | Can do |
| Use healthchecks and depends_on | Can do |

---

# Quick-Fire Questions

## 1. What is the difference between an image and a container?

An **image** is a read-only template with layers (OS, dependencies, app code). A **container** is a running instance of that image with its own writable layer on top.

---

## 2. What happens to data inside a container when you remove it?

Data in the container's writable layer is **lost**. Data stored in **named volumes** or **bind mounts** persists after the container is removed.

---

## 3. How do two containers on the same custom network communicate?

They use **DNS-based service discovery**. Docker provides internal DNS so containers can reach each other by **container name** or **Compose service name** on the shared network.

---

## 4. What does `docker compose down -v` do differently from `docker compose down`?

`docker compose down` stops and removes containers and networks. Adding `-v` also **removes named volumes**, deleting persistent data like database files.

---

## 5. Why are multi-stage builds useful?

They separate the **build environment** (compilers, SDKs) from the **runtime environment** (minimal base + binary). This produces smaller, more secure images without build tools in production.

---

## 6. What is the difference between `COPY` and `ADD`?

`COPY` simply copies files from the build context. `ADD` can also fetch URLs and auto-extract tar archives. Best practice: use `COPY` unless you specifically need `ADD`'s extra features.

---

## 7. What does `-p 8080:80` mean?

Map **host port 8080** to **container port 80**. Traffic to `localhost:8080` on the host is forwarded to port 80 inside the container.

---

## 8. How do you check how much disk space Docker is using?

```bash
docker system df
```

For detailed breakdown:

```bash
docker system df -v
```

---

# Weak Spots Revisited

## Weak Spot 1: Multi-Stage Builds (Day 35)

Re-did the Go multi-stage build exercise:

```bash
cd 2026/day-35
docker build -f Dockerfile.single-stage -t day35-go:single-stage ./multistage-app
docker build -f Dockerfile.multistage -t day35-go:multistage ./multistage-app
docker images day35-go
```

Confirmed single-stage ~850 MB vs multi-stage ~15 MB.

---

## Weak Spot 2: Compose Healthchecks & depends_on (Day 34)

Re-tested the healthcheck pattern:

```yaml
depends_on:
  postgres-db:
    condition: service_healthy
```

Verified the app waits for PostgreSQL to be truly ready, not just started.

---

# Key Takeaways from Days 29–36

1. **Containers** package apps with dependencies; **images** are the blueprints
2. **Dockerfiles** define how images are built layer by layer
3. **Volumes** persist data; **networks** enable container-to-container communication
4. **Compose** orchestrates multi-container apps with one YAML file
5. **Multi-stage builds** keep production images small and secure
6. **Docker Hub** distributes images to any environment

---

# Final Summary

Docker revision complete. All checklist items marked "can do" after hands-on practice across Days 29–36. Cheat sheet created at `docker-cheatsheet.md` for quick reference on the job.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
