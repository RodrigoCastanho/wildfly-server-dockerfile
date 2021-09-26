FROM ubuntu:20.04 AS build_java_server
ARG LINK_JAVA
ARG LINK_SERVER
#
# Download do java
#
RUN mkdir -p /usr/lib/jvm/jdk \
    && cd /usr/lib/jvm/jdk \
    && apt-get update \
    && apt-get install -y --no-install-recommends curl ca-certificates fontconfig locales \ 
    && echo "en_US.UTF-8 UTF-8" >> /etc/locale.gen \
    && locale-gen en_US.UTF-8 \
    && curl -SL ${LINK_JAVA} -o openjdk-jre.tar.gz \
    && tar -xvf openjdk-jre.tar.gz --strip-components=1 \	 
    && rm -rf /var/lib/apt/lists \
    && rm -rf /var/cache/apt \
    && rm -rf openjdk-jre.tar.gz \ 
    #
    # Download do server
    #	 
    && mkdir -p /opt/serverjava \
    && cd /opt/serverjava \
    && curl -SL ${LINK_SERVER} -o server.tar.gz \
    && tar -xvf server.tar.gz --strip-components=1 \	 
    && rm -rf /var/lib/apt/lists \
    && rm -rf /var/cache/apt \
    && rm -rf server.tar.gz

FROM ubuntu:20.04 AS serve_install
MAINTAINER Rodrigo Castanho

COPY --from=build_java_server /usr/lib/jvm/jdk /usr/lib/jvm/jdk
ENV JAVA_HOME /usr/lib/jvm/jdk 
ENV PATH "$PATH":/${JAVA_HOME}/bin

COPY --from=build_java_server /opt/serverjava /opt/serverjava
WORKDIR /opt/serverjava/bin
EXPOSE 8080 9990 8443
RUN /opt/serverjava/bin/add-user.sh admin admin --silent
CMD ["sh", "standalone.sh", "-b", "0.0.0.0", "-bmanagement", "0.0.0.0"]

