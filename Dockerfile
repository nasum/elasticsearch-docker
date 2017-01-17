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
    && echo "network.bind_host: 0.0.0.0" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && echo "network.publish_host: _eth0:ipv4_" >> /usr/share/elasticsearch/config/elasticsearch.yml \
    && /usr/share/elasticsearch/bin/elasticsearch-plugin install analysis-kuromoji

ENV PATH /usr/share/elasticsearch/bin:$PATH

WORKDIR /usr/share/elasticsearch

VOLUME /usr/share/elasticsearch/data

EXPOSE 9200 9300

User elasticsearch

CMD ["elasticsearch"]
