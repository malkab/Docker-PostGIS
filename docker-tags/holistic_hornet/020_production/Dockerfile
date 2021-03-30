FROM ubuntu:20.04

LABEL author="Juan Pedro Perez"
LABEL email="jp.perez.alcantara@gmail.com"

# Build args
ARG PG_VERSION
ARG GEOS_VERSION
ARG PROJ_VERSION
ARG GDAL_VERSION
ARG POSTGIS_VERSION

# Environment
ENV PG_VERSION $PG_VERSION
ENV GEOS_VERSION $GEOS_VERSION
ENV PROJ_VERSION $PROJ_VERSION
ENV GDAL_VERSION $GDAL_VERSION
ENV POSTGIS_VERSION $POSTGIS_VERSION
ENV PASSWORD postgres
ENV TERM xterm

# Default user mapping
ENV POSTGRESUSERID 0
ENV POSTGRESGROUPID 0

# Load assets
WORKDIR /usr/local

ADD packages/run.sh bin/
ADD packages/setup.sh bin/
ADD packages/create_user.sh bin/
ADD packages/run_psql.sh bin/
ADD packages/psqlrc /root/.psqlrc
ADD packages/setup_datastore.sh bin/
ADD packages/gosu bin/

# Copy default configs
COPY packages/*.conf /default_confs/

# Install binaries
ADD packages/binaries/ /

# Setup user and binaries installation
RUN chmod 777 bin/*
RUN bin/setup.sh

# The locale
ENV LANG en_US.UTF-8

# Port
EXPOSE 5432

# Volume
VOLUME /data

# Start & Stop
STOPSIGNAL SIGINT
ENTRYPOINT ["/usr/local/bin/run.sh"]
