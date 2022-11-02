FROM debian:bullseye-slim

ARG VERSION=5.0-beta3
ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    wget default-jdk unzip gettext-base postgresql-client && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget -O /tmp/gisgraphy.zip http://download.gisgraphy.com/releases/gisgraphy-${VERSION}.zip && \
    unzip /tmp/gisgraphy.zip -d /usr/local/gisgraphy/ && \
    cp -r /usr/local/gisgraphy/gisgraphy-${VERSION}/* /usr/local/gisgraphy/ && \
    rm -rf /usr/local/gisgraphy/gisgraphy-${VERSION}/* && \
    rm /tmp/gisgraphy.zip
    
RUN chmod a+rx /usr/local/gisgraphy/*.sh

WORKDIR /usr/local/gisgraphy/

COPY ./files/jdbc.properties /usr/local/gisgraphy/jdbc.properties

COPY entrypoint.sh .

ENTRYPOINT ["./entrypoint.sh"]

CMD ["bash","launch.sh"]