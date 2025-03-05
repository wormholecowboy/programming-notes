
# MISC 
Containers are composed of layers (os, deps, updates, etc.)

```
podman machine start/stop
podman machine ls   # running machines
podman ps   # running containers, us -a for all

podman run <image-name>
podman info  # settings

podman ps -aq -f --status=exited  # see dead containers
podman container prune  # del dead containers
```

pull down an image from configured repo  
`podman pull <image>:<version>`  latest is default  
check stored images  
`podman images`  
browse inside image  
`podman run -it <image-name> sh`  
stop container  
`podman stop <container-id>`  

run containers w/o keeping snapshots on disk  
`podman run --rm -it <image>`  
port mapping - bind a local port to the container  
`podman run -d -P --name <port-name> <image>`  # capital P picks random port, port name is opt  
see port info  
`podman port <port-name>`  


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

`podman build .`  
`podman build -t <tag-name> .`  


# COMPOSE
multi image containers  
create a `docker-compose.yaml`  
containers are under the `services` header  
