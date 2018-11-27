# Docker images for the Olog logging service

This Docker image is based on https://github.com/lnls-sirius/docker-olog-server.

## Running

### Cloning the repos and using convenience run scripts:

1) Start the `olog-mysql-db` container in the daemon mode first:
  - `git clone https://github.com/mrakitin/docker-olog-mysql-db`
  - `cd docker-olog-mysql-db`
  - `./run-docker-olog-db.sh`
2) Start the `olog-server` container in the daemon mode:
  - `git clone https://github.com/mrakitin/docker-olog-server`
  - `cd docker-olog-server`
  - `./run-docker-olog-server.sh`
3) Access this page in your browser: https://localhost:8181 (accept the security certificate warning)

### Using Docker commands directly:

0) Create a network:
  - `docker network create olog-network`
1) Start the `olog-mysql-db` container in the daemon mode first:
  - `docker run -d --name=olog-mysql-db -e MYSQL_USER=olog_user -e MYSQL_ROOT_PASSWORD=password -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=olog -p 3306:3306 --network=olog-network mrakitin/olog-mysql-db:latest`
2) Start the `olog-server` container in the daemon mode:
  - `docker run -d --name=olog-server -p 4848:4848 -p 8181:8181 --network=olog-network mrakitin/olog-server:latest asadmin --user=admin --passwordfile=/tmp/glassfishpwd start-domain -v`
3) Access this page in your browser: https://localhost:8181 (accept the security certificate warning)

That should spin 2 Docker containers with the following exposed ports:
```
CONTAINER ID        IMAGE                           COMMAND                  CREATED             STATUS              PORTS                                            NAMES
18a99712603a        mrakitin/olog-server:latest     "asadmin --user=admi…"   5 minutes ago       Up 5 minutes        0.0.0.0:4848->4848/tcp, 0.0.0.0:8181->8181/tcp   olog-server
ad314a3f34d9        mrakitin/olog-mysql-db:latest   "docker-entrypoint.s…"   17 minutes ago      Up 17 minutes       0.0.0.0:3306->3306/tcp, 33060/tcp                olog-mysql-db
```

## Dockerhub

The following images are pushed to Dockerhub:
- https://hub.docker.com/r/mrakitin/olog-server
- https://hub.docker.com/r/mrakitin/olog-mysql-db
