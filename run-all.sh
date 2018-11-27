#!/bin/bash

docker network create --subnet=172.18.0.0/16 olog-network

docker run -d --name=olog-mysql-db -e MYSQL_USER=olog_user -e MYSQL_ROOT_PASSWORD=password -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=olog --ip 172.18.0.22 --network=olog-network mrakitin/olog-mysql-db:latest

docker run -d --name=olog-server -p 4848:4848 -p 8181:8181 --network=olog-network --add-host olog-mysql-db:172.18.0.22 mrakitin/olog-server:latest asadmin --user=admin --passwordfile=/tmp/glassfishpwd start-domain -v

