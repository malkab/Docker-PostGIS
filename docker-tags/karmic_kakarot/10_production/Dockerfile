# --------------------------------------
#
# Production
#
# Comment from here on to test build scripts.
#
# --------------------------------------
FROM debian:bookworm-slim

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

# Load assets
WORKDIR /usr/local

ADD packages/run.sh bin/
ADD packages/run_psql.sh bin/
ADD packages/psqlrc /root/.psqlrc
ADD packages/dot.bashrc /root/.bashrc
ADD packages/psqlrc /etc/skel/.psqlrc
ADD packages/dot.bashrc /etc/skel/.bashrc
ADD packages/setup_datastore.sh bin/
ADD packages/gosu bin/

# Copy default configs
WORKDIR /

COPY packages/pg_hba.conf /default_confs/
COPY packages/postgresql.conf /default_confs/
COPY packages/keyboard_selections.conf /

# Setup the container
RUN ln -fs /usr/share/zoneinfo/Europe/Madrid /etc/localtime

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y debconf-utils && \
    apt-get install -y \
        readline-common \
        locales \
        tzdata

# Locales
RUN \
    sed -i -e 's/# en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# en_US.ISO-8859-15 ISO-8859-15/en_US.ISO-8859-15 ISO-8859-15/' /etc/locale.gen && \
    sed -i -e 's/# en_GB ISO-8859-1/en_GB ISO-8859-1/' /etc/locale.gen && \
    sed -i -e 's/# en_GB.ISO-8859-15 ISO-8859-15/en_GB.ISO-8859-15 ISO-8859-15/' /etc/locale.gen && \
    sed -i -e 's/# en_GB.UTF-8 UTF-8/en_GB.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# es_ES ISO-8859-1/es_ES ISO-8859-1/' /etc/locale.gen && \
    sed -i -e 's/# es_ES.UTF-8 UTF-8/es_ES.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# es_ES@euro ISO-8859-15/es_ES@euro ISO-8859-15/' /etc/locale.gen && \
    sed -i -e 's/# de_DE ISO-8859-1/de_DE ISO-8859-1/' /etc/locale.gen && \
    sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# de_DE@euro ISO-8859-15/de_DE@euro ISO-8859-15/' /etc/locale.gen && \
    sed -i -e 's/# fr_FR ISO-8859-1/fr_FR ISO-8859-1/' /etc/locale.gen && \
    sed -i -e 's/# fr_FR.UTF-8 UTF-8/fr_FR.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# fr_FR@euro ISO-8859-15/fr_FR@euro ISO-8859-15/' /etc/locale.gen && \
    sed -i -e 's/# it_IT ISO-8859-1/it_IT ISO-8859-1/' /etc/locale.gen && \
    sed -i -e 's/# it_IT.UTF-8 UTF-8/it_IT.UTF-8 UTF-8/' /etc/locale.gen && \
    sed -i -e 's/# it_IT@euro ISO-8859-15/it_IT@euro ISO-8859-15/' /etc/locale.gen

RUN locale-gen

RUN dpkg-reconfigure --frontend noninteractive tzdata

# Copy the keyboard configuration
RUN debconf-set-selections < /keyboard_selections.conf
RUN rm /keyboard_selections.conf

# Packages
RUN apt-get install -y \
    libcurl4 \
    libjson-c5 \
    libprotobuf-c1 \
    libpython3.10 \
    libgeotiff5 \
    libxml2 && \
    apt-get -y upgrade && \
    ldconfig && \
    rm -rf /var/lib/apt/lists/*

# Make Python3 default
RUN ln -s /usr/bin/python3 /usr/bin/python

# Setting permissions
RUN chmod 755 /usr/local/bin/run.sh && \
    chmod 755 /usr/local/bin/setup_datastore.sh && \
    ldconfig

# Add the postgres user, the user to run the server, with 1000:1000 UID/GID.
RUN groupadd -g 1000 postgres && \
    useradd -u 1000 -m -d '/home/postgres' -g postgres postgres && \
    chown -R postgres:postgres /home/postgres

# Copy assets from build
COPY --from=malkab/postgis_build:latest /usr/local/bin/initdb /usr/local/bin/initdb
COPY --from=malkab/postgis_build:latest /usr/local/bin/postgres /usr/local/bin/postgres
COPY --from=malkab/postgis_build:latest /usr/local/share/postgresql/ /usr/local/share/postgresql/
COPY --from=malkab/postgis_build:latest /usr/local/lib/libpq* /usr/local/lib/
COPY --from=malkab/postgis_build:latest /usr/local/lib/postgresql/* /usr/local/lib/postgresql/
COPY --from=malkab/postgis_build:latest /usr/local/bin/pg_ctl /usr/local/bin/pg_ctl
COPY --from=malkab/postgis_build:latest /usr/local/bin/psql /usr/local/bin/psql
COPY --from=malkab/postgis_build:latest /usr/lib/x86_64-linux-gnu/libreadline.so* /usr/lib/x86_64-linux-gnu/
COPY --from=malkab/postgis_build:latest /usr/local/lib/postgresql/postgis-3.so* /usr/local/lib/postgresql/

COPY --from=malkab/postgis_build:latest /usr/local/lib/libgeos_c.so* /usr/local/lib/

COPY --from=malkab/postgis_build:latest /usr/local/lib/libgeos.so* /usr/local/lib/



RUN ldconfig



# Metadata
RUN echo ${DOCKER_IMAGE_TAG} > /docker_image_tag



# Start & Stop
STOPSIGNAL SIGINT
ENTRYPOINT ["/usr/local/bin/run.sh"]


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
