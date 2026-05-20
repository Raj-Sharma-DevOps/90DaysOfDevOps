# Day 35 – Multi-Stage Builds & Docker Hub

# Task 1: The Problem with Large Images

## App Created

I created a simple Go HTTP server in `multistage-app/`.

---

## Single-Stage Dockerfile

```Dockerfile
FROM golang:1.22

WORKDIR /app

COPY go.mod ./
COPY main.go ./

RUN go build -o server main.go

EXPOSE 8080

CMD ["./server"]
```

---

## Build Single-Stage Image

```bash
cd 2026/day-35
docker build -f Dockerfile.single-stage -t day35-go:single-stage ./multistage-app
```

---

## Check Image Size

```bash
docker images day35-go:single-stage
```

---

## Observation

| Image | Size (approx) |
|---|---|
| `day35-go:single-stage` | ~850 MB |

The single-stage image includes the full Go compiler, build tools, and OS packages even though only the compiled binary is needed at runtime.

---

# Task 2: Multi-Stage Build

## Multi-Stage Dockerfile

```Dockerfile
FROM golang:1.22-alpine AS builder

WORKDIR /app

COPY go.mod main.go ./

RUN CGO_ENABLED=0 GOOS=linux go build -ldflags="-s -w" -o server main.go

FROM alpine:3.19

RUN adduser -D -u 10001 appuser

WORKDIR /app

COPY --from=builder /app/server ./server

USER appuser

EXPOSE 8080

CMD ["./server"]
```

---

## Build Multi-Stage Image

```bash
docker build -f Dockerfile.multistage -t day35-go:multistage ./multistage-app
```

---

## Compare Sizes

```bash
docker images day35-go
```

---

## Observation

| Image | Size (approx) |
|---|---|
| `day35-go:single-stage` | ~850 MB |
| `day35-go:multistage` | ~15 MB |

The multi-stage image is dramatically smaller because:

- Stage 1 (`builder`) compiles the app with the full Go toolchain
- Stage 2 copies only the compiled binary into a minimal Alpine image
- Build dependencies, source code, and compiler are discarded

---

## Why Is the Multi-Stage Image So Much Smaller?

- Single-stage keeps the entire Go SDK in the final image
- Multi-stage uses Alpine (~5 MB) as the runtime base
- Only the static binary is copied to the final layer
- Smaller images = faster pulls, less attack surface, lower storage cost

---

# Task 3: Push to Docker Hub

## Login

```bash
docker login
```

---

## Tag Image

Replace `yourusername` with your Docker Hub username:

```bash
docker tag day35-go:multistage yourusername/day35-go:multistage
docker tag day35-go:multistage yourusername/day35-go:latest
```

---

## Push

```bash
docker push yourusername/day35-go:multistage
docker push yourusername/day35-go:latest
```

---

## Verify Pull

```bash
docker rmi yourusername/day35-go:multistage
docker pull yourusername/day35-go:multistage
docker run -d -p 8080:8080 --name day35-test yourusername/day35-go:multistage
curl http://localhost:8080
curl http://localhost:8080/health
docker stop day35-test && docker rm day35-test
```

---

## Observation

The image pulled from Docker Hub and ran successfully on a clean machine without local build artifacts.

---

# Task 4: Docker Hub Repository

## Steps Completed

1. Opened Docker Hub and verified the pushed image
2. Added repository description: "Day 35 DevOps challenge - Go multi-stage build demo"
3. Explored the **Tags** tab — each push creates a new tag
4. Compared pulling `latest` vs a specific tag like `multistage`

---

## Tag vs Latest

| Command | Result |
|---|---|
| `docker pull user/day35-go:latest` | Pulls the most recently pushed `latest` tag |
| `docker pull user/day35-go:multistage` | Pulls the specific versioned tag |

Using specific tags in production avoids unexpected changes when `latest` is updated.

---

# Task 5: Image Best Practices

## Best-Practices Dockerfile Applied

Improvements made:

1. **Minimal base image** — `alpine:3.19.1` instead of Ubuntu
2. **Non-root user** — `appuser` (UID 10001)
3. **Reduced layers** — combined user creation in one RUN
4. **Specific base tag** — `alpine:3.19.1` not `alpine:latest`
5. **Healthcheck** — added for container orchestration readiness

---

## Build and Compare

```bash
docker build -f Dockerfile.best-practices -t day35-go:best ./multistage-app
docker images day35-go
```

---

## Observation

| Image | Size (approx) |
|---|---|
| Single-stage (golang:1.22) | ~850 MB |
| Multi-stage (alpine) | ~15 MB |
| Best-practices (alpine + non-root) | ~15 MB |

The best-practices image is similar in size but more secure and production-ready due to non-root execution and healthcheck.

---

# Useful Commands

```bash
docker build -f Dockerfile.single-stage -t day35-go:single-stage ./multistage-app
docker build -f Dockerfile.multistage -t day35-go:multistage ./multistage-app
docker build -f Dockerfile.best-practices -t day35-go:best ./multistage-app
docker images day35-go
docker history day35-go:multistage
docker login
docker tag day35-go:multistage yourusername/day35-go:latest
docker push yourusername/day35-go:latest
docker pull yourusername/day35-go:latest
docker run -d -p 8080:8080 day35-go:multistage
curl http://localhost:8080
docker inspect day35-go:multistage --format='{{.Config.User}}'
```

---

# Screenshots

## Image Size Comparison

```text
Add screenshot here
```

---

## Docker Hub Repository

```text
Add screenshot here
```

---

## App Running from Pulled Image

```text
Add screenshot here
```

---

# Final Summary

Today I learned:

- Why single-stage images are unnecessarily large for compiled languages
- How multi-stage builds separate build and runtime environments
- How to tag and push images to Docker Hub
- Why specific tags beat `latest` in production
- Image best practices: minimal base, non-root user, pinned tags, healthchecks

Multi-stage builds are essential for shipping small, secure container images in real DevOps pipelines.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
