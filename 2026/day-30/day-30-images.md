# Day 30 – Docker Images & Container Lifecycle

# Task 1: Docker Images

# Pull Images from Docker Hub

## Pull Nginx Image

```bash
docker pull nginx
```

---

## Pull Ubuntu Image

```bash
docker pull ubuntu
```

---

## Pull Alpine Image

```bash
docker pull alpine
```

---

# List All Images

```bash
docker images
```

Example Output:

```text
REPOSITORY   TAG       IMAGE ID       SIZE
nginx        latest    xxxxxxxx       190MB
ubuntu       latest    xxxxxxxx       77MB
alpine       latest    xxxxxxxx       8MB
```

---

# Why is Alpine Much Smaller?

Alpine Linux is designed to be extremely lightweight.

Reasons:

- Minimal packages
- Smaller libraries
- BusyBox utilities instead of full GNU tools
- Optimized for containers

Ubuntu contains many default utilities and packages, making it larger.

---

# Inspect an Image

```bash
docker inspect nginx
```

---

# Information Seen in Inspect Output

- Image ID
- Creation date
- Architecture
- Environment variables
- Entrypoint
- Layers
- Operating system

---

# Remove an Image

```bash
docker rmi ubuntu
```

---

# Task 2: Image Layers

# View Image History

```bash
docker image history nginx
```

---

# Observation

Each line represented a layer used to build the image.

Some layers showed:

```text
0B
```

because metadata instructions do not always create filesystem changes.

---

# What are Docker Layers?

Docker images are built in layers.

Each command in a Dockerfile creates a new layer.

Example:

```Dockerfile
FROM ubuntu
RUN apt update
RUN apt install nginx
COPY . /app
```

Each instruction becomes a separate layer.

---

# Why Does Docker Use Layers?

Docker uses layers because:

- Faster builds through caching
- Reduced storage usage
- Easier image sharing
- Reusable components across images

If one layer changes, Docker only rebuilds that layer and layers after it.

---

# Task 3: Container Lifecycle

# Create Container Without Starting

```bash
docker create --name my-container nginx
```

---

# Check Status

```bash
docker ps -a
```

State:

```text
Created
```

---

# Start Container

```bash
docker start my-container
```

---

# Check Status

```bash
docker ps -a
```

State:

```text
Up
```

---

# Pause Container

```bash
docker pause my-container
```

---

# Check Status

```bash
docker ps -a
```

State:

```text
Paused
```

---

# Unpause Container

```bash
docker unpause my-container
```

---

# Stop Container

```bash
docker stop my-container
```

---

# Restart Container

```bash
docker restart my-container
```

---

# Kill Container

```bash
docker kill my-container
```

---

# Remove Container

```bash
docker rm my-container
```

---

# Full Container Lifecycle Flow

```text
Create → Start → Pause → Unpause → Stop → Restart → Kill → Remove
```

---

# Task 4: Working with Running Containers

# Run Nginx in Detached Mode

```bash
docker run -d --name nginx-server -p 8080:80 nginx
```

---

# View Logs

```bash
docker logs nginx-server
```

---

# View Real-Time Logs

```bash
docker logs -f nginx-server
```

---

# Exec Into Container

```bash
docker exec -it nginx-server bash
```

---

# Explore Filesystem

Commands used:

```bash
ls
cd /usr/share/nginx/html
pwd
```

---

# Run Single Command Inside Container

```bash
docker exec nginx-server ls /
```

---

# Inspect Container

```bash
docker inspect nginx-server
```

---

# Information Found

## IP Address

```text
172.xx.xx.xx
```

---

## Port Mapping

```text
8080 -> 80
```

---

## Mounts

Showed mounted volumes and bind mounts if present.

---

# Task 5: Cleanup

# Stop All Running Containers

```bash
docker stop $(docker ps -q)
```

---

# Remove All Stopped Containers

```bash
docker rm $(docker ps -aq)
```

---

# Remove Unused Images

```bash
docker image prune -a
```

---

# Check Docker Disk Usage

```bash
docker system df
```

Example Output:

```text
TYPE            TOTAL     ACTIVE    SIZE
Images          5         2         1.2GB
Containers      3         1         120MB
Local Volumes   2         2         50MB
```

---

# Cleanup Everything

```bash
docker system prune -a
```

---

# Important Docker Commands Learned

```bash
docker pull
docker images
docker image history
docker inspect
docker create
docker start
docker pause
docker unpause
docker stop
docker restart
docker kill
docker rm
docker logs
docker logs -f
docker exec
docker system df
docker system prune
```

---

# Key Learnings

## Image vs Container

| Image | Container |
|---|---|
| Blueprint/template | Running instance |
| Read-only | Read-write |
| Static | Dynamic |

---

## What Surprised Me

- Containers have many lifecycle states
- Alpine image was extremely small
- Docker layers improve performance using caching
- Containers can be paused like processes

---

# Screenshots

## Docker Images

```text
Add screenshot here
```

---

## Container Lifecycle Commands

```text
Add screenshot here
```

---

## Docker Logs & Inspect

```text
Add screenshot here
```

---

# Summary

Today I learned:

- Difference between Docker images and containers
- Docker image layers and caching
- Full container lifecycle
- Running and inspecting containers
- Viewing logs and executing commands inside containers
- Cleaning unused Docker resources

Docker images are reusable templates, while containers are live running environments created from those images.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
