FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    wget default-jdk htop net-tools vim psmisc unzip locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

RUN wget /tmp/gisgraphy.zip -O http://download.gisgraphy.com/releases/gisgraphy-5.0-beta3.zip && \
    unzip /tmp/gisgraphy.zip -d /usr/local/gisgraphy/ && \
    cp -r /usr/local/gisgraphy/gisgraphy-5.0-beta3/* /usr/local/gisgraphy/ && \
    rm -rf /usr/local/gisgraphy/gisgraphy-5.0-beta3/* && \
    rm /tmp/gisgraphy.zip
    
RUN chmod a+rx /usr/local/gisgraphy/*.sh
