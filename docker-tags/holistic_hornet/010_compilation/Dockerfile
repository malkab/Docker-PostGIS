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
ENV DEBIAN_FRONTEND noninteractive

# Load assets
WORKDIR /usr/local/src/

ADD packages/postgis_compile.sh /usr/local/src/

ADD packages/export_binaries.sh /usr/local/src/

ADD packages/postgresql/ /usr/local/src/postgresql

ADD packages/geos/ /usr/local/src/geos

ADD packages/proj/ /usr/local/src/proj

ADD packages/gdal/ /usr/local/src/gdal

ADD packages/postgis/ /usr/local/src/postgis

# Compilation
RUN chmod 777 /usr/local/src/*.sh
RUN /usr/local/src/postgis_compile.sh

ENTRYPOINT [ "/usr/local/src/export_binaries.sh" ]
