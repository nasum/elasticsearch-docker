FROM alpine:3.5

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >>  /etc/apk/repositories \
    && apk update \
    && apk add curl openjdk8-jre \
    && curl -o elasticsearch-5.1.1.tar.gz -sSL https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.1.tar.gz \
    && tar -zxf elasticsearch-5.1.1.tar.gz \
    && rm elasticsearch-5.1.1.tar.gz \
    && mv elasticsearch-5.1.1 /usr/share/elasticsearch \
    && mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs /usr/share/elasticsearch/config/scripts \
