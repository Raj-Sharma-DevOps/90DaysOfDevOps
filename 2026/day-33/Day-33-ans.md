# Day 33 – Docker Compose: Multi-Container Basics

# Task 1: Install & Verify

## Check Docker Compose Version

```bash
docker compose version
```

---

## Example Output

```text
Docker Compose version v2.x.x
```

---

## Observation

Docker Compose was available on my machine.  
It is used to manage multi-container applications using a single YAML file.

---

# Task 2: Your First Compose File

## Create Folder

```bash
mkdir -p 2026/day-33/compose-basics
cd 2026/day-33/compose-basics
```

---

## docker-compose.yml

```yaml
version: "3.8"

services:
  nginx:
    image: nginx
    container_name: compose-nginx
    ports:
      - "8080:80"
```

---

## Start Container

```bash
docker compose up
```

---

## Start Container in Detached Mode

```bash
docker compose up -d
```

---

## Access in Browser

```text
http://localhost:8080
```

---

## Stop Compose App

```bash
docker compose down
```

---

## Observation

Nginx started successfully using Docker Compose.  
Instead of running a long `docker run` command, Compose handled the container and port mapping from the YAML file.

---

# Task 3: Two-Container Setup

## Create Folder

```bash
mkdir wordpress-mysql-compose
cd wordpress-mysql-compose
```

---

## docker-compose.yml

```yaml
version: "3.8"

services:
  mysql:
    image: mysql:8
    container_name: compose-mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: wordpress_db
      MYSQL_USER: wordpress_user
      MYSQL_PASSWORD: wordpress_pass
    volumes:
      - mysql-data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    container_name: compose-wordpress
    restart: always
    depends_on:
      - mysql
    ports:
      - "8081:80"
    environment:
      WORDPRESS_DB_HOST: mysql:3306
      WORDPRESS_DB_USER: wordpress_user
      WORDPRESS_DB_PASSWORD: wordpress_pass
      WORDPRESS_DB_NAME: wordpress_db

volumes:
  mysql-data:
```

---

## Start WordPress + MySQL

```bash
docker compose up -d
```

---

## Check Running Services

```bash
docker compose ps
```

---

## Access WordPress in Browser

```text
http://localhost:8081
```

---

## Observation

WordPress connected to MySQL using the MySQL service name:

```text
mysql
```

Compose automatically created a network where both services could communicate.

---

## Verify Data Persistence

## Stop Containers

```bash
docker compose down
```

---

## Start Again

```bash
docker compose up -d
```

---

## Result

WordPress data was still available because MySQL data was stored in the named volume:

```text
mysql-data
```

---

# Task 4: Compose Commands

## Start Services in Foreground

```bash
docker compose up
```

---

## Start Services in Detached Mode

```bash
docker compose up -d
```

---

## View Running Services

```bash
docker compose ps
```

---

## View Logs of All Services

```bash
docker compose logs
```

---

## View Real-Time Logs of All Services

```bash
docker compose logs -f
```

---

## View Logs of Specific Service

```bash
docker compose logs mysql
```

```bash
docker compose logs wordpress
```

---

## Stop Services Without Removing

```bash
docker compose stop
```

---

## Start Stopped Services

```bash
docker compose start
```

---

## Remove Containers and Network

```bash
docker compose down
```

---

## Remove Containers, Network, and Volumes

```bash
docker compose down -v
```

---

## Rebuild Images After Changes

```bash
docker compose up --build
```

---

# Task 5: Environment Variables

# Method 1: Environment Variables Directly in docker-compose.yml

```yaml
environment:
  MYSQL_ROOT_PASSWORD: root123
  MYSQL_DATABASE: wordpress_db
  MYSQL_USER: wordpress_user
  MYSQL_PASSWORD: wordpress_pass
```

---

# Method 2: Using .env File

## Create .env File

```bash
touch .env
```

---

## .env

```env
MYSQL_ROOT_PASSWORD=root123
MYSQL_DATABASE=wordpress_db
MYSQL_USER=wordpress_user
MYSQL_PASSWORD=wordpress_pass

WORDPRESS_DB_HOST=mysql:3306
WORDPRESS_DB_USER=wordpress_user
WORDPRESS_DB_PASSWORD=wordpress_pass
WORDPRESS_DB_NAME=wordpress_db
```

---

## docker-compose.yml Using .env Variables

```yaml
version: "3.8"

services:
  mysql:
    image: mysql:8
    container_name: compose-mysql-env
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - mysql-env-data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    container_name: compose-wordpress-env
    restart: always
    depends_on:
      - mysql
    ports:
      - "8082:80"
    environment:
      WORDPRESS_DB_HOST: ${WORDPRESS_DB_HOST}
      WORDPRESS_DB_USER: ${WORDPRESS_DB_USER}
      WORDPRESS_DB_PASSWORD: ${WORDPRESS_DB_PASSWORD}
      WORDPRESS_DB_NAME: ${WORDPRESS_DB_NAME}

volumes:
  mysql-env-data:
```

---

## Start Using .env File

```bash
docker compose up -d
```

---

## Verify Environment Variables

```bash
docker compose config
```

---

## Observation

Docker Compose successfully picked variables from the `.env` file and replaced them inside the compose file.

---

# Compose Network Explanation

Docker Compose automatically creates a default network for services.

Example:

```text
wordpress-mysql-compose_default
```

Inside this network:

- `wordpress` can reach MySQL using hostname `mysql`
- Service names work as DNS names
- No manual `docker network create` command is required

---

# Compose Volume Explanation

Named volume used:

```yaml
volumes:
  - mysql-data:/var/lib/mysql
```

This means:

- MySQL stores data inside Docker volume
- Data stays safe even if containers are deleted
- Data is only removed if volume is deleted using `docker compose down -v`

---

# All Compose Files Created

# 1. compose-basics/docker-compose.yml

```yaml
version: "3.8"

services:
  nginx:
    image: nginx
    container_name: compose-nginx
    ports:
      - "8080:80"
```

---

# 2. wordpress-mysql-compose/docker-compose.yml

```yaml
version: "3.8"

services:
  mysql:
    image: mysql:8
    container_name: compose-mysql
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: root123
      MYSQL_DATABASE: wordpress_db
      MYSQL_USER: wordpress_user
      MYSQL_PASSWORD: wordpress_pass
    volumes:
      - mysql-data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    container_name: compose-wordpress
    restart: always
    depends_on:
      - mysql
    ports:
      - "8081:80"
    environment:
      WORDPRESS_DB_HOST: mysql:3306
      WORDPRESS_DB_USER: wordpress_user
      WORDPRESS_DB_PASSWORD: wordpress_pass
      WORDPRESS_DB_NAME: wordpress_db

volumes:
  mysql-data:
```

---

# 3. wordpress-mysql-compose-env/.env

```env
MYSQL_ROOT_PASSWORD=root123
MYSQL_DATABASE=wordpress_db
MYSQL_USER=wordpress_user
MYSQL_PASSWORD=wordpress_pass

WORDPRESS_DB_HOST=mysql:3306
WORDPRESS_DB_USER=wordpress_user
WORDPRESS_DB_PASSWORD=wordpress_pass
WORDPRESS_DB_NAME=wordpress_db
```

---

# 4. wordpress-mysql-compose-env/docker-compose.yml

```yaml
version: "3.8"

services:
  mysql:
    image: mysql:8
    container_name: compose-mysql-env
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: ${MYSQL_ROOT_PASSWORD}
      MYSQL_DATABASE: ${MYSQL_DATABASE}
      MYSQL_USER: ${MYSQL_USER}
      MYSQL_PASSWORD: ${MYSQL_PASSWORD}
    volumes:
      - mysql-env-data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    container_name: compose-wordpress-env
    restart: always
    depends_on:
      - mysql
    ports:
      - "8082:80"
    environment:
      WORDPRESS_DB_HOST: ${WORDPRESS_DB_HOST}
      WORDPRESS_DB_USER: ${WORDPRESS_DB_USER}
      WORDPRESS_DB_PASSWORD: ${WORDPRESS_DB_PASSWORD}
      WORDPRESS_DB_NAME: ${WORDPRESS_DB_NAME}

volumes:
  mysql-env-data:
```

---

# Important Commands Learned

```bash
docker compose version
docker compose up
docker compose up -d
docker compose ps
docker compose logs
docker compose logs -f
docker compose logs mysql
docker compose stop
docker compose start
docker compose down
docker compose down -v
docker compose up --build
docker compose config
```

---

# Screenshots

## Docker Compose Version

```text
Add screenshot here
```

---

## Nginx Running with Compose

```text
Add screenshot here
```

---

## WordPress + MySQL Running

```text
Add screenshot here
```

---

## Compose Logs

```text
Add screenshot here
```

---

# Summary

Today I learned:

- Docker Compose manages multi-container apps using YAML
- Compose automatically creates networks
- Service names work as DNS names
- Named volumes persist database data
- WordPress can connect to MySQL using the MySQL service name
- `.env` files make compose files cleaner and reusable
- One command can start or stop the complete application stack

Docker Compose makes multi-container DevOps workflows much easier and more repeatable.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
