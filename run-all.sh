#!/bin/bash

# docker network create --subnet=172.18.0.0/16 olog-network
# mysql_ip=172.18.33.06

# docker run -d --name=olog-mysql-db -e MYSQL_USER=olog_user -e MYSQL_ROOT_PASSWORD=password -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=olog --network=olog-network --ip ${mysql_ip} mrakitin/olog-mysql-db:latest
docker run -d --name=olog-mysql-db -e MYSQL_USER=olog_user -e MYSQL_ROOT_PASSWORD=password -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=olog mrakitin/olog-mysql-db:latest

# docker run -d --name=olog-server -p 4848:4848 -p 8181:8181 --network=olog-network --add-host olog-mysql-db:172.18.33.06 mrakitin/olog-server:latest asadmin --user=admin --passwordfile=/tmp/glassfishpwd start-domain -v
docker run -d --name=olog-server -p 4848:4848 -p 8181:8181 --link olog-mysql-db mrakitin/olog-server:latest asadmin --user=admin --passwordfile=/tmp/glassfishpwd start-domain -v

