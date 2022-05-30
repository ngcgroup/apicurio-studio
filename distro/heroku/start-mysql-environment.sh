#!/bin/bash

#docker-compose -f docker-compose.keycloak.yml build
#docker-compose -f docker-compose.keycloak.yml -f docker-compose.microcks.yml -f docker-compose.apicurio.yml -f docker-compose-as-mysql.yml up

docker-compose -f docker-compose.apicurio.yml -f docker-compose-as-mysql.yml up

