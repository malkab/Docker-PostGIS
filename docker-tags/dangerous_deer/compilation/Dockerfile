FROM ubuntu:18.04

LABEL author="Juan Pedro Perez"
LABEL email="jp.perez.alcantara@gmail.com"


# Environment
ENV PG_VERSION 10.4
ENV GEOS_VERSION 3.6.3
ENV PROJ4_VERSION 4.9.3
ENV GDAL_VERSION 2.3.1
ENV POSTGIS_VERSION 2.4.4
ENV DEBIAN_FRONTEND noninteractive


# Load assets
WORKDIR /usr/local
ADD packages/postgis_compile.sh /usr/local/src/
ADD packages/export_binaries.sh /usr/local/src/

ADD packages/postgresql-${PG_VERSION}/postgresql-${PG_VERSION}.tar.bz2 /usr/local/src/postgresql

ADD packages/geos-${GEOS_VERSION}/geos-${GEOS_VERSION}.tar.bz2 /usr/local/src/geos

ADD packages/proj-${PROJ4_VERSION}/proj-${PROJ4_VERSION}.tar.gz /usr/local/src/proj
ADD packages/proj-${PROJ4_VERSION}/proj-datumgrid-1.5.tar.gz /usr/local/src/proj-datumgrid
ADD packages/proj-${PROJ4_VERSION}/proj${PROJ4_VERSION}-patch/src/pj_datums.c /usr/local/src/proj-patch/
ADD packages/proj-${PROJ4_VERSION}/proj${PROJ4_VERSION}-patch/nad/PENR2009.gsb /usr/local/src/proj-patch/
ADD packages/proj-${PROJ4_VERSION}/proj${PROJ4_VERSION}-patch/nad/epsg /usr/local/src/proj-patch/
ADD packages/proj-${PROJ4_VERSION}/proj4_test.sh /usr/local/src/proj-patch/

ADD packages/gdal-${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz /usr/local/src/gdal
ADD packages/gdal-${GDAL_VERSION}/data/gcs.csv /usr/local/src/gdal-patch/data/
ADD packages/gdal-${GDAL_VERSION}/data/epsg.wkt /usr/local/src/gdal-patch/data/
ADD packages/gdal-${GDAL_VERSION}/gdal-test.sh /usr/local/src/gdal-patch/

ADD packages/postgis-${POSTGIS_VERSION}/postgis-${POSTGIS_VERSION}.tar.gz /usr/local/src/postgis
ADD packages/postgis-${POSTGIS_VERSION}/spatial_ref_sys.sql /usr/local/src/postgis-patch/
ADD packages/postgis-${POSTGIS_VERSION}/postgis_test.sql /usr/local/src/postgis-patch/

# Compilation
RUN chmod 777 /usr/local/src/*.sh
RUN /usr/local/src/postgis_compile.sh

ENTRYPOINT [ "/usr/local/src/export_binaries.sh" ]
