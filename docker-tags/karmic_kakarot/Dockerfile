# --------------------------------------
#
# Build
#
# --------------------------------------
FROM debian:bookworm AS build

LABEL author="Juan Pedro Perez"
LABEL email="jp.perez.alcantara@gmail.com"

# Environment
ARG DOCKER_IMAGE_TAG
ENV DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}
ARG GDAL_VERSION
ENV GDAL_VERSION=${GDAL_VERSION}
ARG GEOS_VERSION
ENV GEOS_VERSION=${GEOS_VERSION}
ARG POSTGIS_VERSION
ENV POSTGIS_VERSION=${POSTGIS_VERSION}
ARG PG_VERSION
ENV PG_VERSION=${PG_VERSION}
ARG PROJ_VERSION
ENV PROJ_VERSION=${PROJ_VERSION}

ADD packages/gdal-${GDAL_VERSION}.tar.gz /usr/local/src/
ADD packages/geos-${GEOS_VERSION}.tar.bz2 /usr/local/src/
ADD packages/postgis-${POSTGIS_VERSION}.tar.gz /usr/local/src/
ADD packages/postgresql-${PG_VERSION}.tar.bz2 /usr/local/src/
ADD packages/proj-${PROJ_VERSION}.tar.gz /usr/local/src/

ADD build_scripts /build_scripts

# Compile
WORKDIR /build_scripts

# RUN /build_scripts/005-build_all.sh


# # --------------------------------------
# #
# # Production
# #
# # --------------------------------------
# FROM debian:bookworm-slim AS production

# # Environment
# ARG DOCKER_IMAGE_TAG
# ENV DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}
# ARG GDAL_VERSION
# ENV GDAL_VERSION=${GDAL_VERSION}
# ARG GEOS_VERSION
# ENV GEOS_VERSION=${GEOS_VERSION}
# ARG POSTGIS_VERSION
# ENV POSTGIS_VERSION=${POSTGIS_VERSION}
# ARG PG_VERSION
# ENV PG_VERSION=${PG_VERSION}
# ARG PROJ_VERSION
# ENV PROJ_VERSION=${PROJ_VERSION}

# WORKDIR /usr/local/src/

# COPY --from=build /usr/local/src/gdal-${GDAL_VERSION} /gdal-${GDAL_VERSION}

# RUN echo ${DOCKER_IMAGE_TAG} > /docker_image_tag


# # --------------------------------------
# #
# # Final
# #
# # --------------------------------------
# FROM scratch

# # Environment
# ARG DOCKER_IMAGE_TAG
# ENV DOCKER_IMAGE_TAG=${DOCKER_IMAGE_TAG}
# ARG GDAL_VERSION
# ENV GDAL_VERSION=${GDAL_VERSION}
# ARG GEOS_VERSION
# ENV GEOS_VERSION=${GEOS_VERSION}
# ARG POSTGIS_VERSION
# ENV POSTGIS_VERSION=${POSTGIS_VERSION}
# ARG PG_VERSION
# ENV PG_VERSION=${PG_VERSION}
# ARG PROJ_VERSION
# ENV PROJ_VERSION=${PROJ_VERSION}

# COPY --from=production / /

# ENTRYPOINT [ "/bin/bash" ]
