# Day 32 – Docker Volumes & Networking

# Task 1: The Problem

## Run a MySQL Container Without Volume

```bash
docker run -d \
  --name mysql-no-volume \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -e MYSQL_DATABASE=devopsdb \
  mysql:8
```

---

## Enter MySQL Container

```bash
docker exec -it mysql-no-volume mysql -uroot -proot123
```

---

## Create Table and Insert Data

```sql
USE devopsdb;

CREATE TABLE students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50)
);

INSERT INTO students (name) VALUES ('Raj');
INSERT INTO students (name) VALUES ('DevOps Learner');

SELECT * FROM students;
```

---

## Stop and Remove Container

```bash
docker stop mysql-no-volume
docker rm mysql-no-volume
```

---

## Run a New MySQL Container

```bash
docker run -d \
  --name mysql-new \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -e MYSQL_DATABASE=devopsdb \
  mysql:8
```

---

## Check Data Again

```bash
docker exec -it mysql-new mysql -uroot -proot123
```

```sql
USE devopsdb;
SELECT * FROM students;
```

---

## Observation

The data was not available in the new container.

---

## What Happened and Why?

Containers are temporary by default.  
When the MySQL container was removed, the data stored inside the container filesystem was also removed.

This shows why we need Docker volumes for databases and persistent data.

---

# Task 2: Named Volumes

## Create Named Volume

```bash
docker volume create mysql-data
```

---

## Verify Volume

```bash
docker volume ls
```

---

## Run MySQL With Named Volume

```bash
docker run -d \
  --name mysql-volume \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -e MYSQL_DATABASE=devopsdb \
  -v mysql-data:/var/lib/mysql \
  mysql:8
```

---

## Insert Data

```bash
docker exec -it mysql-volume mysql -uroot -proot123
```

```sql
USE devopsdb;

CREATE TABLE students (
  id INT AUTO_INCREMENT PRIMARY KEY,
  name VARCHAR(50)
);

INSERT INTO students (name) VALUES ('Raj');
INSERT INTO students (name) VALUES ('Docker Volume Test');

SELECT * FROM students;
```

---

## Stop and Remove Container

```bash
docker stop mysql-volume
docker rm mysql-volume
```

---

## Run New Container With Same Volume

```bash
docker run -d \
  --name mysql-volume-new \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -e MYSQL_DATABASE=devopsdb \
  -v mysql-data:/var/lib/mysql \
  mysql:8
```

---

## Verify Data

```bash
docker exec -it mysql-volume-new mysql -uroot -proot123
```

```sql
USE devopsdb;
SELECT * FROM students;
```

---

## Observation

The data was still available.

---

## Why?

The data was stored in the named volume `mysql-data`, not inside the container filesystem.

Even after deleting the container, the volume stayed safe.

---

## Inspect Volume

```bash
docker volume inspect mysql-data
```

---

# Task 3: Bind Mounts

## Create Host Folder

```bash
mkdir nginx-bind-demo
cd nginx-bind-demo
```

---

## Create index.html

```bash
cat > index.html <<EOF
<!DOCTYPE html>
<html>
<head>
  <title>Docker Bind Mount</title>
</head>
<body>
  <h1>Hello from Docker Bind Mount!</h1>
  <p>This file is coming from my host machine.</p>
</body>
</html>
EOF
```

---

## Run Nginx With Bind Mount

```bash
docker run -d \
  --name nginx-bind \
  -p 8080:80 \
  -v $(pwd):/usr/share/nginx/html \
  nginx
```

---

## Access in Browser

```text
http://localhost:8080
```

---

## Edit index.html on Host

```bash
echo "<h1>Updated from host machine!</h1>" > index.html
```

---

## Refresh Browser

The browser showed the updated content immediately.

---

## Difference Between Named Volume and Bind Mount

| Named Volume | Bind Mount |
|---|---|
| Managed by Docker | Managed by host filesystem |
| Stored in Docker volume location | Stored in any host path |
| Best for database data | Best for local development |
| More portable | Depends on host path |
| Safer for production | Useful for live file editing |

---

# Task 4: Docker Networking Basics

## List Docker Networks

```bash
docker network ls
```

Default networks:

```text
bridge
host
none
```

---

## Inspect Default Bridge Network

```bash
docker network inspect bridge
```

---

## Run Two Containers on Default Bridge

```bash
docker run -dit --name container1 alpine sh
docker run -dit --name container2 alpine sh
```

---

## Install Ping Tool if Needed

```bash
docker exec container1 apk add --no-cache iputils
docker exec container2 apk add --no-cache iputils
```

---

## Try Ping by Container Name

```bash
docker exec container1 ping container2
```

---

## Observation

Name-based ping usually does not work on the default bridge network.

---

## Get Container IP Address

```bash
docker inspect -f '{{range.NetworkSettings.Networks}}{{.IPAddress}}{{end}}' container2
```

---

## Ping by IP Address

```bash
docker exec container1 ping <container2-ip>
```

---

## Observation

Ping by IP worked because containers on the same bridge network can communicate using IP addresses.

---

# Task 5: Custom Networks

## Create Custom Bridge Network

```bash
docker network create my-app-net
```

---

## Run Containers on Custom Network

```bash
docker run -dit --name app1 --network my-app-net alpine sh
docker run -dit --name app2 --network my-app-net alpine sh
```

---

## Install Ping Tool

```bash
docker exec app1 apk add --no-cache iputils
docker exec app2 apk add --no-cache iputils
```

---

## Ping by Container Name

```bash
docker exec app1 ping app2
```

---

## Observation

Ping by container name worked successfully on the custom bridge network.

---

## Why Does Custom Network Allow Name-Based Communication?

Custom Docker bridge networks provide built-in DNS resolution.

That means containers can discover and communicate with each other using container names.

The default bridge network does not provide the same automatic name resolution in the same way.

---

# Task 6: Put It Together

## Create Custom Network

```bash
docker network create fullstack-net
```

---

## Create Database Volume

```bash
docker volume create mysql-fullstack-data
```

---

## Run MySQL Database on Custom Network With Volume

```bash
docker run -d \
  --name mysql-db \
  --network fullstack-net \
  -e MYSQL_ROOT_PASSWORD=root123 \
  -e MYSQL_DATABASE=appdb \
  -v mysql-fullstack-data:/var/lib/mysql \
  mysql:8
```

---

## Run App Container on Same Network

```bash
docker run -dit \
  --name app-container \
  --network fullstack-net \
  alpine sh
```

---

## Install MySQL Client in App Container

```bash
docker exec app-container apk add --no-cache mysql-client
```

---

## Verify App Can Reach Database by Container Name

```bash
docker exec -it app-container sh
```

Inside app container:

```bash
mysql -h mysql-db -uroot -proot123
```

---

## Observation

The app container successfully connected to the database container using the name:

```text
mysql-db
```

---

## Why This Matters

In real applications:

- Backend container connects to database container by service/container name
- Database data stays safe using volumes
- Custom networks keep app services connected and isolated

---

# Cleanup Commands

```bash
docker stop mysql-new mysql-volume-new nginx-bind container1 container2 app1 app2 mysql-db app-container
docker rm mysql-new mysql-volume-new nginx-bind container1 container2 app1 app2 mysql-db app-container

docker network rm my-app-net fullstack-net

docker volume ls
```

---

# Important Commands Learned

```bash
docker volume create mysql-data
docker volume ls
docker volume inspect mysql-data

docker run -v mysql-data:/var/lib/mysql mysql:8
docker run -v $(pwd):/usr/share/nginx/html nginx

docker network ls
docker network inspect bridge
docker network create my-app-net
docker run --network my-app-net alpine

docker exec container1 ping container2
docker inspect container-name
```

---

# Screenshots

## MySQL Without Volume

```text
Add screenshot here
```

---

## Named Volume Persistence

```text
Add screenshot here
```

---

## Bind Mount Nginx Page

```text
Add screenshot here
```

---

## Custom Network Ping

```text
Add screenshot here
```

---

## App Container Connected to Database

```text
Add screenshot here
```

---

# Summary

Today I learned:

- Containers lose data when removed
- Named volumes persist data outside containers
- Bind mounts connect host folders to containers
- Docker has default and custom networks
- Custom bridge networks support name-based communication
- Containers can communicate using container names on custom networks
- Real apps use both volumes and networks together

Docker volumes solve persistence.  
Docker networks solve container communication.

#90DaysOfDevOps #DevOpsKaJosh #TrainWithShubham
