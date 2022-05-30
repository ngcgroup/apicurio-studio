FROM adoptopenjdk/openjdk11:jdk-11.0.11_9-alpine


ARG RELEASE_VERSION=""
WORKDIR /opt/apicurio-studio
RUN addgroup -S apicurio -g 1001 && adduser -u 1001 -S -G apicurio -s /sbin/nologin apicurio && chown -R apicurio:apicurio /opt/apicurio-studio/

ADD --chown=apicurio:apicurio ./target/apicurio-studio-$RELEASE_VERSION-quickstart/apicurio-studio-$RELEASE_VERSION/  /opt/apicurio-studio/wildfly

RUN chmod 755 /opt/apicurio-studio/wildfly/bin/standalone.sh 

USER 1001
EXPOSE 8080 8443

ENTRYPOINT ["/opt/apicurio-studio/wildfly/bin/standalone.sh"]
CMD ["-c", "standalone-apicurio.xml", "-b", "0.0.0.0"]

