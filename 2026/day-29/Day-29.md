# Day 29 – Introduction to Docker

# Task 1: What is Docker?

## What is a container and why do we need them?

A container is a lightweight, portable environment that packages an application along with its dependencies, libraries, and configuration files.

Containers are needed because:

- Applications run consistently across different systems
- Developers avoid "works on my machine" problems
- Faster deployment and scaling
- Lightweight compared to virtual machines
- Ideal for microservices and CI/CD pipelines

---

## Containers vs Virtual Machines

| Containers | Virtual Machines |
|---|---|
| Lightweight | Heavyweight |
| Share host OS kernel | Each VM has full OS |
| Faster startup | Slower startup |
| Less resource usage | High resource usage |
| Portable | Less portable |

---

## Real Difference Between Containers and VMs

Virtual Machines virtualize hardware and run complete operating systems.

Containers virtualize the operating system and run isolated applications using the host kernel.

---

# Docker Architecture

Docker architecture mainly consists of:

- Docker Client
- Docker Daemon
- Docker Images
- Docker Containers
- Docker Registry

---

## Docker Components

### Docker Client

The command line interface where users run commands like:

```bash
docker run
docker ps
docker pull
```

---

### Docker Daemon

Background service that manages:

- Containers
- Images
- Networks
- Volumes

---

### Docker Images

Read-only templates used to create containers.

Example:

```bash
nginx
ubuntu
mysql
```

---

### Docker Containers

Running instances of Docker images.

---

### Docker Registry

Stores Docker images.

Example:

- Docker Hub
- GitHub Container Registry

---

# Docker Architecture Diagram

```text
+-------------------+
|   Docker Client   |
| docker commands   |
+---------+---------+
          |
          v
+-------------------+
|   Docker Daemon   |
| manages containers|
+---------+---------+
          |
  -------------------
  |        |        |
  v        v        v
Images  Containers Registry
```

---

# Task 2: Install Docker

# Install Docker

## Ubuntu

```bash
sudo apt update
sudo apt install docker.io -y
```

---

## Start Docker Service

```bash
sudo systemctl start docker
sudo systemctl enable docker
```

---

## Verify Installation

```bash
docker --version
```

Example output:

```text
Docker version 28.x.x
```

---

# Run Hello World Container

```bash
docker run hello-world
```

---

# What Happened?

Docker:

1. Checked for image locally
2. Pulled image from Docker Hub
3. Created container
4. Executed program inside container
5. Displayed success message

---

# Task 3: Run Real Containers

# Run Nginx Container

```bash
docker run -d -p 8080:80 nginx
```

---

# Access in Browser

Opened:

```text
http://localhost:8080
```

Nginx welcome page appeared successfully.

---

# Run Ubuntu Container in Interactive Mode

```bash
docker run -it ubuntu bash
```

---

# Explore Ubuntu Container

Commands used:

```bash
ls
pwd
cat /etc/os-release
apt update
```

Container behaved like a small Linux machine.

---

# List Running Containers

```bash
docker ps
```

---

# List All Containers

```bash
docker ps -a
```

---

# Stop Container

```bash
docker stop <container-id>
```

---

# Remove Container

```bash
docker rm <container-id>
```

---

# Task 4: Explore Docker Features

# Run Container in Detached Mode

```bash
docker run -d nginx
```

---

## What is Different?

- Terminal does not attach to container
- Container runs in background
- Useful for servers and applications

---

# Give Custom Name to Container

```bash
docker run -d --name my-nginx nginx
```

---

# Port Mapping

```bash
docker run -d -p 3000:80 nginx
```

---

## Explanation

```text
Host Port : Container Port
3000      : 80
```

Access:

```text
http://localhost:3000
```

---

# Check Container Logs

```bash
docker logs my-nginx
```

---

# Run Command Inside Running Container

```bash
docker exec -it my-nginx bash
```

---

# Useful Docker Commands

```bash
docker images
docker pull ubuntu
docker stop container-id
docker rm container-id
docker exec -it container-name bash
docker logs container-name
docker ps
docker ps -a
```

---

# Why Docker Matters for DevOps

Docker is important because:

- Applications become portable
- CI/CD pipelines use containers heavily
- Kubernetes runs containers
- Easier scaling and deployment
- Infrastructure becomes consistent

Docker is the foundation of modern DevOps workflows.

---

# Screenshots

## Running Containers Screenshot

```text
Add screenshot here
```

---

## Nginx Browser Screenshot

```text
Add screenshot here
```

---

## Ubuntu Interactive Container Screenshot

```text
Add screenshot here
```

---

# Summary

Today I learned:

- What containers are
- Difference between containers and virtual machines
- Docker architecture
- Running containers from Docker Hub
- Interactive and detached mode
- Port mapping
- Viewing logs
- Executing commands inside containers

Docker makes application deployment lightweight, portable, and scalable.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
