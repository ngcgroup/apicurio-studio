FROM centos:7
LABEL authors="Daniel Cesario <dcesario@redhat.com>"
MAINTAINER Eric Wittmann <eric.wittmann@redhat.com>
RUN yum install -y \
    java-1.8.0-openjdk-headless \
    unzip \
  && yum clean all

WORKDIR /opt/apicurio-studio

ENV RELEASE_VERSION 0.1.11
ENV RELEASE_PATH https://github.com/Apicurio/apicurio-studio/releases/download/v$RELEASE_VERSION/apicurio-studio-$RELEASE_VERSION-quickstart.zip


ADD $RELEASE_PATH /opt/apicurio-studio

RUN groupadd -r apicurio -g 1001 \
    && useradd -u 1001 -r -g apicurio -d /opt/apicurio-studio/ -s /sbin/nologin -c "Docker image user" apicurio \
    && chown -R apicurio:apicurio /opt/apicurio-studio/

USER 1001
RUN unzip  /opt/apicurio-studio/apicurio-studio-${RELEASE_VERSION}-quickstart.zip \
    && rm /opt/apicurio-studio/apicurio-studio-${RELEASE_VERSION}-quickstart.zip \
    && mv /opt/apicurio-studio/apicurio-studio-${RELEASE_VERSION} /opt/apicurio-studio/wildfly \
    && find /opt/ -name '*' \
    && chmod 755 /opt/apicurio-studio/wildfly/bin/standalone.sh

EXPOSE 8080

ENTRYPOINT ["/opt/apicurio-studio/wildfly/bin/standalone.sh"]
CMD ["-c", "standalone-apicurio.xml", "-b", "0.0.0.0"]

<build>
  <from>centos:7</from>
  <labels>
  	<authors>Daniel Cesario <dcesario@redhat.com></authors>
  </labels>
  <tags>
    <tag>latest</tag>
    <tag>${project.version}</tag>
  </tags>
  <runCmds>
    <run>yum install -y java-1.8.0-openjdk-headless unzip \
  		&& yum clean all
  	</run>
    <run>groupadd -r apicurio -g 1001 \
    && useradd -u 1001 -r -g apicurio -d /opt/apicurio-studio/ -s /sbin/nologin -c "Docker image user" apicurio \
    && chown -R apicurio:apicurio /opt/apicurio-studio/
    </run>
  </runCmds>
  <ports>
    <port>8080</port>
  </ports>
  
  <shell>
    <exec>
      <arg>/bin/sh</arg>
      <arg>-c</arg>
    </exec>
  </shell>
  <runCmds>
    <run>groupadd -r appUser</run>
    <run>useradd -r -g appUser appUser</run>
  </runCmds>

  <entryPoint>
    <!-- exec form for ENTRYPOINT -->
    <exec>
      <arg>java</arg>
      <arg>-jar</arg>
      <arg>/opt/demo/server.jar</arg>
    </exec>
  </entryPoint>

  <assembly>
    <mode>dir</mode>
    <targetDir>/opt/demo</targetDir>
    <descriptor>assembly.xml</descriptor>
  </assembly>
</build>


<volumes>
    <volume>/path/to/expose</volume>
  </volumes>
  <buildOptions>
    <shmsize>2147483648</shmsize>
  </buildOptions>
