#!/bin/sh

java -jar /opt/apicurio/apicurio-studio-api-runner.jar \
    -Xms${APICURIO_MIN_HEAP} \
    -Xmx${APICURIO_MAX_HEAP} \
    -Dquarkus.http.port=${APICURIO_PORT_OFFSET} \
    -Dquarkus.datasource.jdbc.db-kind=${APICURIO_DB_DRIVER_NAME} \
    -Dquarkus.datasource.jdbc.url=${APICURIO_DB_CONNECTION_URL} \
    -Dquarkus.datasource.username=${APICURIO_DB_USER_NAME} \
    -Dquarkus.datasource.password=${APICURIO_DB_PASSWORD} \
    -Dapicurio.hub.storage.jdbc.init=${APICURIO_DB_INITIALIZE} \
    -Dapicurio.hub.storage.jdbc.type=${APICURIO_DB_TYPE} \
    -Dapicurio.kc.auth.rootUrl=${APICURIO_KC_AUTH_URL} \
    -Dapicurio.kc.auth.realm=${APICURIO_KC_REALM} \
    -Dquarkus.log.level=${APICURIO_LOGGING_LEVEL:=DEBUG}
#    -Dquarkus.log.level=${APICURIO_LOGGING_LEVEL}