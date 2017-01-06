FROM alpine:3.5

MAINTAINER Masaya Nasu (tomato.wonder.life@gmail.com)

RUN echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >>  /etc/apk/repositories \
    && apk update \
    && apk add curl openjdk8-jre bash\
    && curl -o elasticsearch-5.1.1.tar.gz -ssl https://artifacts.elastic.co/downloads/elasticsearch/elasticsearch-5.1.1.tar.gz \
    && tar -zxf elasticsearch-5.1.1.tar.gz \
    && rm elasticsearch-5.1.1.tar.gz \
    && mv elasticsearch-5.1.1 /usr/share/elasticsearch \
    && mkdir -p /usr/share/elasticsearch/data /usr/share/elasticsearch/logs /usr/share/elasticsearch/config/scripts \
    && adduser -DH -s /sbin/nologin elasticsearch \
    && chown -R elasticsearch:elasticsearch /usr/share/elasticsearch \
    && apk del curl \
    && rm -rf /var/cache/apk/ \
    && bin/elasticsearch-plugin install analysis-kuromoji

WORKDIR /usr/share/elasticsearch

VOLUME /usr/share/elasticsearch/data

EXPOSE 9200 9300

User elasticsearch

CMD ["/usr/share/elasticsearch/bin/elasticsearch"]
