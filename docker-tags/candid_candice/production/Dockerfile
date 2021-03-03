FROM ubuntu:18.04

LABEL author="Juan Pedro Perez"
LABEL email="jp.perez.alcantara@gmail.com"


# Environment
ENV PG_VERSION 10.4
ENV GEOS_VERSION 3.6.3
ENV PROJ4_VERSION 4.9.3
ENV GDAL_VERSION 2.3.1
ENV POSTGIS_VERSION 2.4.4
ENV ENCODING UTF-8
ENV PASSWORD postgres
ENV LOCALE en_US
ENV TERM xterm


# Load assets
WORKDIR /usr/local
ADD packages/run.sh bin/
ADD packages/setup.sh bin/
ADD packages/psqlrc /root/.psqlrc
ADD packages/setup_datastore.sh bin/
ADD packages/gosu bin/


# Copy default configs
COPY packages/*.conf /default_confs/


# Install binaries
ADD packages/binaries/ /


# Setup and binaries installation
RUN chmod 777 bin/*
RUN bin/setup.sh


# Port
EXPOSE 5432


# Volume
VOLUME /data


# Start & Stop
STOPSIGNAL SIGINT
ENTRYPOINT ["/usr/local/bin/run.sh"]

