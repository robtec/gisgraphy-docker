FROM debian:bullseye-slim

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update -y && \
    apt-get install --no-install-recommends -y \
    wget default-jdk htop net-tools vim psmisc unzip locales && \
    apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
