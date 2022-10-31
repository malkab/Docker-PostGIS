FROM ubuntu:22.04

LABEL author="Juan Pedro Perez"
LABEL email="jp.perez.alcantara@gmail.com"


# Build args
ARG PG_VERSION
ARG GEOS_VERSION
ARG PROJ_VERSION
ARG PROJ_DATA_VERSION
ARG GDAL_VERSION
ARG POSTGIS_VERSION

# Environment
ENV PG_VERSION $PG_VERSION
ENV GEOS_VERSION $GEOS_VERSION
ENV PROJ_VERSION $PROJ_VERSION
ENV PROJ_DATA_VERSION $PROJ_DATA_VERSION
ENV GDAL_VERSION $GDAL_VERSION
ENV POSTGIS_VERSION $POSTGIS_VERSION
ENV DEBIAN_FRONTEND noninteractive
ENV PROJ_DATA /usr/local/share/proj

# Load assets
WORKDIR /usr/local/src/

ADD packages/postgresql/ /usr/local/src/postgresql
ADD packages/geos/ /usr/local/src/geos
ADD packages/proj/ /usr/local/src/proj
ADD packages/gdal/ /usr/local/src/gdal
ADD packages/postgis/ /usr/local/src/postgis

ENTRYPOINT [ "/bin/bash" ]
