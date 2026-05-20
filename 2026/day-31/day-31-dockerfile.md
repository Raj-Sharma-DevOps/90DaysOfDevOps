# Day 31 – Dockerfile: Build Your Own Images

# Task 1: Your First Dockerfile

## Folder Created

```bash
mkdir -p 2026/day-31/my-first-image
cd 2026/day-31/my-first-image
```

---

## Dockerfile

```Dockerfile
FROM ubuntu

RUN apt-get update && apt-get install -y curl

CMD ["echo", "Hello from my custom image!"]
```

---

## Build Image

```bash
docker build -t my-ubuntu:v1 .
```

---

## Run Container

```bash
docker run my-ubuntu:v1
```

---

## Output

```text
Hello from my custom image!
```

---

## Observation

The custom Docker image was built successfully using Ubuntu as the base image.  
When I ran the container, it printed the default message from the CMD instruction.

---

# Task 2: Dockerfile Instructions

## Folder Created

```bash
mkdir dockerfile-instructions
cd dockerfile-instructions
```

---

## Create File

```bash
echo "This file was copied into Docker image" > message.txt
```

---

## Dockerfile

```Dockerfile
FROM ubuntu

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY message.txt /app/message.txt

EXPOSE 8080

CMD ["cat", "/app/message.txt"]
```

---

## Build Image

```bash
docker build -t dockerfile-demo:v1 .
```

---

## Run Container

```bash
docker run dockerfile-demo:v1
```

---

## Output

```text
This file was copied into Docker image
```

---

## Dockerfile Instructions Explained

| Instruction | Meaning |
|---|---|
| FROM | Sets the base image |
| RUN | Runs commands during image build |
| WORKDIR | Sets working directory inside image |
| COPY | Copies files from host to image |
| EXPOSE | Documents container port |
| CMD | Default command when container starts |

---

# Task 3: CMD vs ENTRYPOINT

# CMD Example

## Folder Created

```bash
mkdir cmd-example
cd cmd-example
```

---

## Dockerfile

```Dockerfile
FROM alpine

CMD ["echo", "hello"]
```

---

## Build Image

```bash
docker build -t cmd-demo:v1 .
```

---

## Run Normally

```bash
docker run cmd-demo:v1
```

Output:

```text
hello
```

---

## Run With Custom Command

```bash
docker run cmd-demo:v1 echo "custom message"
```

Output:

```text
custom message
```

---

## Observation

When a custom command was passed, it replaced the default CMD.

---

# ENTRYPOINT Example

## Folder Created

```bash
mkdir entrypoint-example
cd entrypoint-example
```

---

## Dockerfile

```Dockerfile
FROM alpine

ENTRYPOINT ["echo"]
```

---

## Build Image

```bash
docker build -t entrypoint-demo:v1 .
```

---

## Run Normally

```bash
docker run entrypoint-demo:v1
```

Output:

```text

```

---

## Run With Arguments

```bash
docker run entrypoint-demo:v1 "hello from entrypoint"
```

Output:

```text
hello from entrypoint
```

---

## Observation

ENTRYPOINT fixed the main executable as `echo`.  
Any arguments passed during `docker run` were added after ENTRYPOINT.

---

## CMD vs ENTRYPOINT

| CMD | ENTRYPOINT |
|---|---|
| Provides default command | Defines fixed executable |
| Can be overridden easily | Arguments are appended |
| Best for default behavior | Best for command-line tools |

---

## When to Use CMD

Use CMD when you want to provide a default command that users can easily replace.

Example:

```Dockerfile
CMD ["npm", "start"]
```

---

## When to Use ENTRYPOINT

Use ENTRYPOINT when the container should always run the same executable.

Example:

```Dockerfile
ENTRYPOINT ["python", "script.py"]
```

---

# Task 4: Build a Simple Web App Image

## Folder Created

```bash
mkdir my-website
cd my-website
```

---

## index.html

```html
<!DOCTYPE html>
<html>
<head>
  <title>My Docker Website</title>
</head>
<body>
  <h1>Hello from my custom Nginx Docker image!</h1>
  <p>This website is running inside a Docker container.</p>
</body>
</html>
```

---

## Dockerfile

```Dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

---

## Build Image

```bash
docker build -t my-website:v1 .
```

---

## Run Container

```bash
docker run -d --name my-website-container -p 8080:80 my-website:v1
```

---

## Access in Browser

```text
http://localhost:8080
```

---

## Observation

The custom HTML page was served successfully using Nginx inside Docker.

---

# Task 5: .dockerignore

## Create .dockerignore

```bash
touch .dockerignore
```

---

## .dockerignore Content

```text
node_modules
.git
*.md
.env
```

---

## Why .dockerignore is Used

`.dockerignore` prevents unnecessary or sensitive files from being copied into the Docker build context.

Benefits:

- Smaller build context
- Faster image builds
- Avoids leaking secrets
- Prevents unnecessary files inside image

---

## Verify Ignored Files

```bash
docker build -t my-website:v2 .
```

Then inspect inside container:

```bash
docker run -it my-website:v2 sh
ls
```

Ignored files like `.git`, `.env`, and markdown files were not included.

---

# Task 6: Build Optimization

## Initial Build

```bash
docker build -t my-website:v1 .
```

---

## Change One Line and Rebuild

```bash
docker build -t my-website:v2 .
```

---

## Observation

Docker reused cached layers for unchanged Dockerfile instructions.

Only the changed layer and layers after it were rebuilt.

---

## Bad Layer Order Example

```Dockerfile
FROM node:alpine

WORKDIR /app

COPY . .

RUN npm install

CMD ["npm", "start"]
```

Problem:

- Every code change invalidates cache
- `npm install` runs again every time

---

## Better Layer Order Example

```Dockerfile
FROM node:alpine

WORKDIR /app

COPY package*.json ./

RUN npm install

COPY . .

CMD ["npm", "start"]
```

---

## Why Layer Order Matters

Docker builds images layer by layer.  
If one layer changes, Docker rebuilds that layer and all layers after it.

So frequently changing files should be copied later, and dependency files should be copied earlier.

This improves build speed.

---

# Dockerfiles Created

## 1. my-first-image/Dockerfile

```Dockerfile
FROM ubuntu

RUN apt-get update && apt-get install -y curl

CMD ["echo", "Hello from my custom image!"]
```

---

## 2. dockerfile-instructions/Dockerfile

```Dockerfile
FROM ubuntu

RUN apt-get update && apt-get install -y curl

WORKDIR /app

COPY message.txt /app/message.txt

EXPOSE 8080

CMD ["cat", "/app/message.txt"]
```

---

## 3. cmd-example/Dockerfile

```Dockerfile
FROM alpine

CMD ["echo", "hello"]
```

---

## 4. entrypoint-example/Dockerfile

```Dockerfile
FROM alpine

ENTRYPOINT ["echo"]
```

---

## 5. my-website/Dockerfile

```Dockerfile
FROM nginx:alpine

COPY index.html /usr/share/nginx/html/index.html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
```

---

# Useful Commands

```bash
docker build -t my-ubuntu:v1 .
docker run my-ubuntu:v1

docker build -t dockerfile-demo:v1 .
docker run dockerfile-demo:v1

docker build -t cmd-demo:v1 .
docker run cmd-demo:v1
docker run cmd-demo:v1 echo "custom message"

docker build -t entrypoint-demo:v1 .
docker run entrypoint-demo:v1 "hello from entrypoint"

docker build -t my-website:v1 .
docker run -d --name my-website-container -p 8080:80 my-website:v1

docker ps
docker logs my-website-container
docker stop my-website-container
docker rm my-website-container
```

---

# Screenshots

## Custom Ubuntu Image Output

```text
Add screenshot here
```

---

## Docker Build Output

```text
Add screenshot here
```

---

## Website Running in Browser

```text
Add screenshot here
```

---

# Summary

Today I learned:

- How to write a Dockerfile
- How to build custom Docker images
- Dockerfile instructions like FROM, RUN, COPY, WORKDIR, EXPOSE, CMD
- Difference between CMD and ENTRYPOINT
- How to build a static website image using Nginx
- How .dockerignore improves builds and security
- How Docker layer caching works
- Why Dockerfile instruction order matters

Dockerfile is important because it turns application setup into repeatable infrastructure.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
