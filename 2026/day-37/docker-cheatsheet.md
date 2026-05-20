# Docker Cheat Sheet

Quick reference for daily Docker work. One line per command.

---

## Container Commands

| Command | Description |
|---|---|
| `docker run IMAGE` | Create and start a container |
| `docker run -d IMAGE` | Run in detached (background) mode |
| `docker run -it IMAGE bash` | Run interactively with a shell |
| `docker run -p 8080:80 IMAGE` | Map host port 8080 to container port 80 |
| `docker run --name myapp IMAGE` | Assign a container name |
| `docker run --rm IMAGE` | Auto-remove container when it stops |
| `docker ps` | List running containers |
| `docker ps -a` | List all containers (including stopped) |
| `docker stop CONTAINER` | Gracefully stop a container |
| `docker start CONTAINER` | Start a stopped container |
| `docker restart CONTAINER` | Restart a container |
| `docker rm CONTAINER` | Remove a stopped container |
| `docker rm -f CONTAINER` | Force remove a running container |
| `docker exec -it CONTAINER bash` | Open a shell inside a running container |
| `docker logs CONTAINER` | View container logs |
| `docker logs -f CONTAINER` | Follow (stream) container logs |
| `docker inspect CONTAINER` | Detailed container metadata (JSON) |
| `docker stats` | Live CPU/memory usage of containers |

---

## Image Commands

| Command | Description |
|---|---|
| `docker images` | List local images |
| `docker pull IMAGE:TAG` | Download image from registry |
| `docker push USER/REPO:TAG` | Upload image to registry |
| `docker build -t NAME:TAG .` | Build image from Dockerfile in current dir |
| `docker build -f Dockerfile.custom .` | Build using a specific Dockerfile |
| `docker tag SOURCE TARGET` | Create a new tag for an existing image |
| `docker rmi IMAGE` | Remove a local image |
| `docker history IMAGE` | Show layers and size of an image |
| `docker save -o file.tar IMAGE` | Export image to a tar archive |
| `docker load -i file.tar` | Import image from a tar archive |

---

## Volume Commands

| Command | Description |
|---|---|
| `docker volume create NAME` | Create a named volume |
| `docker volume ls` | List all volumes |
| `docker volume inspect NAME` | Show volume details and mount point |
| `docker volume rm NAME` | Delete a volume |
| `docker run -v NAME:/path IMAGE` | Mount named volume at path |
| `docker run -v /host/path:/container/path IMAGE` | Bind mount host directory |

---

## Network Commands

| Command | Description |
|---|---|
| `docker network create NAME` | Create a custom bridge network |
| `docker network ls` | List all networks |
| `docker network inspect NAME` | Show connected containers and config |
| `docker network connect NET CONTAINER` | Attach container to a network |
| `docker network disconnect NET CONTAINER` | Detach container from a network |
| `docker network rm NAME` | Remove a network |

---

## Compose Commands

| Command | Description |
|---|---|
| `docker compose up` | Start all services (foreground) |
| `docker compose up -d` | Start all services (detached) |
| `docker compose up --build` | Rebuild images before starting |
| `docker compose down` | Stop and remove containers and networks |
| `docker compose down -v` | Also remove named volumes |
| `docker compose ps` | List compose service status |
| `docker compose logs` | View logs from all services |
| `docker compose logs -f SERVICE` | Follow logs for one service |
| `docker compose exec SERVICE bash` | Shell into a running service |
| `docker compose restart SERVICE` | Restart a specific service |
| `docker compose config` | Validate and print resolved compose file |

---

## Cleanup Commands

| Command | Description |
|---|---|
| `docker system df` | Show disk usage by images, containers, volumes |
| `docker system prune` | Remove unused containers, networks, dangling images |
| `docker system prune -a` | Also remove unused images (not just dangling) |
| `docker system prune --volumes` | Also remove unused volumes |
| `docker container prune` | Remove all stopped containers |
| `docker image prune` | Remove dangling images |
| `docker volume prune` | Remove unused volumes |

---

## Dockerfile Instructions

| Instruction | Description |
|---|---|
| `FROM image:tag` | Base image to start from |
| `WORKDIR /path` | Set working directory for subsequent instructions |
| `COPY src dest` | Copy files from build context into image |
| `ADD src dest` | Like COPY but supports URLs and auto-extracts tar archives |
| `RUN command` | Execute command during build (creates a layer) |
| `ENV KEY=value` | Set environment variable |
| `EXPOSE port` | Document which port the container listens on |
| `CMD ["cmd"]` | Default command when container starts (overridable) |
| `ENTRYPOINT ["cmd"]` | Main command (not easily overridden) |
| `USER username` | Run subsequent instructions as non-root user |
| `VOLUME ["/path"]` | Declare a mount point for persistent data |
| `ARG name=default` | Build-time variable (not available at runtime) |
| `HEALTHCHECK` | Define how Docker checks container health |

---

## Quick Tips

- **Image vs Container**: Image is the blueprint; container is a running instance
- **CMD vs ENTRYPOINT**: CMD is the default command; ENTRYPOINT is the fixed executable
- **COPY vs ADD**: Prefer COPY unless you need URL download or tar extraction
- **Multi-stage**: Use `FROM ... AS builder` then `COPY --from=builder` for small images
- **Container DNS**: Services on the same Compose network reach each other by service name
- **Data persistence**: Container filesystem is ephemeral; use volumes for data that must survive restarts
