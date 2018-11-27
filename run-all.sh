#!/bin/bash

docker network create olog-network

docker run -d --name=olog-mysql-db -e MYSQL_USER=olog_user -e MYSQL_ROOT_PASSWORD=password -e MYSQL_PASSWORD=password -e MYSQL_DATABASE=olog -p 3306:3306 --network=olog-network mrakitin/olog-mysql-db:latest

docker run -d --name=olog-server -p 4848:4848 -p 8181:8181 --network=olog-network mrakitin/olog-server:latest asadmin --user=admin --passwordfile=/tmp/glassfishpwd start-domain -v

