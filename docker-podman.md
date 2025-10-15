
# MISC 
Containers are composed of layers (os, deps, updates, etc.)

```
docker machine start/stop
docker machine ls   # running machines
docker ps   # running containers, us -a for all

docker run <image-name>
docker info  # settings

docker ps -aq -f --status=exited  # see dead containers
docker container prune  # del dead containers
```

pull down an image from configured repo  
`docker pull <image>:<version>`  latest is default  
check stored images  
`docker images`  
browse inside image  
`docker run -it <image-name> sh`  
stop container  
`docker stop <container-id>`  

run containers w/o keeping snapshots on disk  
`docker run --rm -it <image>`  
port mapping - bind a local port to the container  
`docker run -d -P --name <port-name> <image>`  # capital P picks random port, port name is opt  
see port info  
`docker port <port-name>`  

deleteing  
`docker image prune`  # delete dangling images  
`docker image prune -a`  # delete any image not tied to a container
`docker rmi <image-id>` # delete image
`docker container prune` # delete all stopped containers
`docker rm <container-id>`
`docker system prune -a` # delete all unused conatianers and images


# BUILDING IMAGES
`nvim Dockerfile`  # optional name: Containerfile  

```docker
FROM golang:version
WORKDIR /app  # container path to work with
COPY  main.go .  # copy local files to build, source target
RUN go build -o main.go .
EXPOSE 8080  # optional
CMD ["./main"]   # run bin when container starts
```

`docker build .`  
`docker build -t <tag-name> .`  


# COMPOSE
multi image containers  
create a `docker-compose.yaml`  
containers are under the `services` header  

## Basic config example

```yml
# docker-compose.yml
version: '3'

services:
  web:
    build: .
    # build from Dockerfile
    context: ./Path
    dockerfile: Dockerfile
    ports:
     - "5000:5000"
    volumes:
     - .:/code
  redis:
    image: redis
```

## Common commands

```bash
# Starts existing containers for a service.
docker-compose start

# Stops running containers without removing them.
docker-compose stop

# Pauses running containers of a service.
docker-compose pause

# Unpauses paused containers of a service.
docker-compose unpause

# Lists containers.
docker-compose ps

# Builds, (re)creates, starts, and attaches to containers for a service.
docker-compose up

# Stops containers and removes containers, networks, volumes, and images created by up.
docker-compose down
```

## Config file reference

### Building

```yml
web:
  # build from Dockerfile
  build: .
  # build from custom Dockerfile
  build:
    context: ./dir
    dockerfile: Dockerfile.dev
  # build from image
  image: ubuntu
  image: ubuntu:14.04
  image: tutum/influxdb
  image: example-registry:4000/postgresql
  image: a4bc65fd
```

### Ports

```yml
ports:
  - "3000"
  - "8000:80"  # guest:host
# expose ports to linked services (not to host)
expose: ["3000"]
```

### Commands

```yml
# command to execute
command: bundle exec thin -p 3000
command: [bundle, exec, thin, -p, 3000]

# override the entrypoint
entrypoint: /app/start.sh
entrypoint: [php, -d, vendor/bin/phpunit]
```

### Environment variables

```yml
# environment vars
environment:
  RACK_ENV: development
environment:
  - RACK_ENV=development

# environment vars from file
env_file: .env
env_file: [.env, .development.env]
```

### Dependencies

```yml
# makes the `db` service available as the hostname `database`
# (implies depends_on)
links:
  - db:database
  - redis

# make sure `db` is alive before starting
depends_on:
  - db
```

### Other options

```yml
# make this service extend another
extends:
  file: common.yml  # optional
  service: webapp
volumes:
  - /var/lib/mysql
  - ./_data:/var/lib/mysql
```



### TO ORGANIZE

Give me a single markdown block of all the docker commands we used. Include explanations for each one, including the flags used. 
markdown
•  docker compose: Use Docker Compose to manage multi-container applications
•  --profile server: Only start services tagged with the "server" profile (excludes transcribe services)
•  up: Create and start containers
•  -d: Run in detached mode (in the background)

2. Check Running Container Status
bash
•  docker compose: Docker Compose command
•  --profile server: Target only "server" profile services
•  ps: Show status of containers (similar to docker ps but for compose services)

3. Restart All Services
bash
•  docker compose: Docker Compose command
•  --profile server: Target only "server" profile services
•  restart: Stop and then start containers (preserves volumes and networks)

4. View Container Logs
bash
•  docker compose: Docker Compose command
•  --profile server: Target only "server" profile services
•  logs: Display log output from services

5. View Logs with Tail Limit
bash
•  docker compose: Docker Compose command
•  --profile server: Target only "server" profile services
•  logs: Display log output from services
•  --tail 20: Only show the last 20 lines of logs

6. View Logs for Specific Service
bash
•  docker compose: Docker Compose command
•  --profile server: Target only "server" profile services
•  logs: Display log output from services
•  app: Only show logs from the "app" service (Joplin Server)

7. View Logs with Filtering
bash
•  docker compose --profile server logs app: Get logs from app service
•  |: Pipe output to next command
•  tail -10: Show only the last 10 lines

8. Filter Logs with Grep
bash
•  docker compose --profile server logs app: Get logs from app service
•  |: Pipe output to next command
•  grep -i: Search for patterns (case-insensitive)
•  "base\|url\|listening\|server": Search for lines containing any of these words

9. Execute Command Inside Running Container
bash
•  docker exec: Execute a command in a running container
•  joplin-app-1: Name of the container (auto-generated by compose)
•  env: Command to run inside container (show environment variables)
•  |: Pipe output to next command
•  grep APP_BASE_URL: Filter to show only lines containing "APP_BASE_URL"

10. Stop and Remove All Services
bash
•  docker compose: Docker Compose command
•  --profile server: Target only "server" profile services
•  down: Stop containers and remove containers, networks, and volumes created by up

11. Start Services After Full Cleanup
bash
•  Same as command #1 - start services in detached mode
•  Used after down to completely recreate containers with fresh configuration

Key Points:
•  Profiles: The --profile server flag ensures we only manage the Joplin server and PostgreSQL, excluding transcribe services
•  Service Names: Container names are auto-generated as {directory}-{service}-{number} (e.g., joplin-app-1)
•  Detached Mode: The -d flag runs containers in background, returning control to terminal
•  Log Management: Various log commands help debug issues and monitor server status
•  Environment: docker exec allows inspecting running container's environment and configuration

