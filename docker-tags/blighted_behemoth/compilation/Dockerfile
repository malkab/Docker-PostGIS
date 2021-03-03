FROM ubuntu:latest

LABEL author="Juan Pedro Perez"
LABEL email="jpperezalcantara@us.es"


# Environment
ENV PG_VERSION 10.0
ENV GEOS_VERSION 3.6.2
ENV PROJ4_VERSION 4.9.3
ENV GDAL_VERSION 2.2.2
ENV POSTGIS_VERSION 2.4.1


# Load assets
WORKDIR /usr/local
ADD packages/compile.sh /usr/local/src/
ADD packages/export_binaries.sh /usr/local/bin/
ADD https://ftp.postgresql.org/pub/source/v${PG_VERSION}/postgresql-${PG_VERSION}.tar.bz2 /usr/local/src/
ADD http://download.osgeo.org/geos/geos-${GEOS_VERSION}.tar.bz2 /usr/local/src/
ADD http://download.osgeo.org/proj/proj-${PROJ4_VERSION}.tar.gz /usr/local/src/
ADD http://download.osgeo.org/proj/proj-datumgrid-1.5.tar.gz /usr/local/src/
ADD https://raw.githubusercontent.com/malkab/Spanish-Geodetics-Patches/master/proj4/proj${PROJ4_VERSION}-patch/src/pj_datums.c /usr/local/src/
ADD https://raw.githubusercontent.com/malkab/Spanish-Geodetics-Patches/master/proj4/proj${PROJ4_VERSION}-patch/nad/PENR2009.gsb /usr/local/src/
ADD https://raw.githubusercontent.com/malkab/Spanish-Geodetics-Patches/master/proj4/proj${PROJ4_VERSION}-patch/nad/epsg /usr/local/src/
ADD http://download.osgeo.org/gdal/${GDAL_VERSION}/gdal-${GDAL_VERSION}.tar.gz /usr/local/src/
ADD https://raw.githubusercontent.com/malkab/Spanish-Geodetics-Patches/master/gdal/data/gcs.csv /usr/local/src/
ADD https://raw.githubusercontent.com/malkab/Spanish-Geodetics-Patches/master/gdal/data/epsg.wkt /usr/local/src/
ADD http://download.osgeo.org/postgis/source/postgis-${POSTGIS_VERSION}.tar.gz /usr/local/src/
ADD https://raw.githubusercontent.com/malkab/Spanish-Geodetics-Patches/master/postgis/spatial_ref_sys.sql /usr/local/src/


# Compilation
RUN chmod -R 777 /usr/local/bin/*
RUN chmod 777 /usr/local/src/compile.sh
RUN /usr/local/src/compile.sh

ENTRYPOINT [ "/usr/local/bin/export_binaries.sh" ]
