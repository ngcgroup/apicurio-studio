FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine
LABEL authors="Prabhu Inbarajan <prabhu.inbarajan@bhnetwork.com>"
ENV RELEASE_PATH target/apicurio-studio-ws-thorntail.jar
WORKDIR /opt/apicurio

RUN addgroup -S apicurio -g 1001 && adduser -u 1001 -S -G apicurio -s /sbin/nologin apicurio && chown -R apicurio:apicurio /opt/apicurio/

ADD --chown=apicurio:apicurio  ${RELEASE_PATH} entrypoint.sh /opt/apicurio/

RUN chmod 554 /opt/apicurio/entrypoint.sh \
    && chgrp -R 0 /opt/apicurio && chmod -R g=u /opt/apicurio

USER 1001

EXPOSE 8080

ENV JAVA_TOOL_OPTIONS=-Djava.net.preferIPv4Stack=true
ENV APICURIO_PORT_OFFSET=0
ENV APICURIO_DB_DRIVER_NAME=h2
ENV APICURIO_DB_CONNECTION_URL=jdbc:h2:mem:apicuriodb
ENV APICURIO_DB_USER_NAME=sa
ENV APICURIO_DB_PASSWORD=sa
ENV APICURIO_DB_INITIALIZE=true
ENV APICURIO_DB_TYPE=h2
ENV APICURIO_DB_VALID_CONNECTION_CHECKER_CLASS_NAME=org.jboss.jca.adapters.jdbc.extensions.novendor.NullValidConnectionChecker
ENV APICURIO_DB_VALID_ON_MATCH=
ENV APICURIO_DB_BACKGROUND_VALIDATION=
ENV APICURIO_DB_EXCEPTION_SORTER_CLASS_NAME=org.jboss.jca.adapters.jdbc.extensions.novendor.NullExceptionSorter
ENV APICURIO_LOGGING_LEVEL=INFO
ENV APICURIO_MIN_HEAP=768m
ENV APICURIO_MAX_HEAP=2048m


ENTRYPOINT ["/opt/apicurio/entrypoint.sh"]
