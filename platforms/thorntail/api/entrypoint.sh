#!/bin/sh


if [ "$DATABASE_URL" != "" ]; then
    echo "Found database configuration in DATABASE_URL=$DATABASE_URL"

    regex='^postgres://([a-zA-Z0-9_-]+):([a-zA-Z0-9]+)@([a-z0-9.-]+):([[:digit:]]+)/([a-zA-Z0-9_-]+)$'
    if [[ $DATABASE_URL =~ $regex ]]; then
        export DB_ADDR=${BASH_REMATCH[3]}
        export DB_PORT=${BASH_REMATCH[4]}
        export DB_DATABASE=${BASH_REMATCH[5]}
        export DB_USER=${BASH_REMATCH[1]}
        export DB_PASSWORD=${BASH_REMATCH[2]}
        export APICURIO_DB_DRIVER_NAME="postgresql"
        export APICURIO_DB_CONNECTION_URL="jdbc:postgresql://$DB_ADDR:$DB_PORT/$DB_DATABASE"
        export APICURIO_DB_USER_NAME=$DB_USER
        export APICURIO_DB_PASSWORD=$DB_PASSWORD
        export APICURIO_DB_TYPE="postgresql9"
        echo "DB_ADDR=$DB_ADDR, DB_PORT=$DB_PORT, DB_DATABASE=$DB_DATABASE, DB_USER=$DB_USER, DB_PASSWORD=$DB_PASSWORD"
        export DB_VENDOR=postgres
    fi

fi

java -jar /opt/apicurio/apicurio-studio-api-thorntail.jar \
    -Xms${APICURIO_MIN_HEAP} \
    -Xmx${APICURIO_MAX_HEAP} \
    -Dthorntail.port.offset=${APICURIO_PORT_OFFSET} \
    -Dthorntail.datasources.data-sources.ApicurioDS.driver-name=${APICURIO_DB_DRIVER_NAME} \
    -Dthorntail.datasources.data-sources.ApicurioDS.connection-url=${APICURIO_DB_CONNECTION_URL} \
    -Dthorntail.datasources.data-sources.ApicurioDS.user-name=${APICURIO_DB_USER_NAME} \
    -Dthorntail.datasources.data-sources.ApicurioDS.password=${APICURIO_DB_PASSWORD} \
    -Dthorntail.datasources.data-sources.ApicurioDS.valid-connection-checker-class-name=${APICURIO_DB_VALID_CONNECTION_CHECKER_CLASS_NAME} \
    -Dthorntail.datasources.data-sources.ApicurioDS.validate-on-match=${APICURIO_DB_VALID_ON_MATCH} \
    -Dthorntail.datasources.data-sources.ApicurioDS.background-validation=${APICURIO_DB_BACKGROUND_VALIDATION} \
    -Dthorntail.datasources.data-sources.ApicurioDS.exception-sorter-class-name=${APICURIO_DB_EXCEPTION_SORTER_CLASS_NAME} \
    -Dapicurio.hub.storage.jdbc.init=${APICURIO_DB_INITIALIZE} \
    -Dapicurio.hub.storage.jdbc.type=${APICURIO_DB_TYPE} \
    -Dapicurio.kc.auth.rootUrl=${APICURIO_KC_AUTH_URL} \
    -Dapicurio.kc.auth.realm=${APICURIO_KC_REALM} \
    -Dthorntail.logging=${APICURIO_LOGGING_LEVEL}