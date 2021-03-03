FROM ubuntu:18.04

LABEL author="Juan Pedro Perez"
LABEL email="jp.perez.alcantara@gmail.com"

# Build args
ARG PG_VERSION
ARG GEOS_VERSION
ARG PROJ4_VERSION
ARG GDAL_VERSION
ARG POSTGIS_VERSION

# Environment
ENV PG_VERSION $PG_VERSION
ENV GEOS_VERSION $GEOS_VERSION
ENV PROJ4_VERSION $PROJ4_VERSION
ENV GDAL_VERSION $GDAL_VERSION
ENV POSTGIS_VERSION $POSTGIS_VERSION

ENV ENCODING UTF-8
ENV PASSWORD postgres
ENV LOCALE en_US
ENV TERM xterm
ENV PG_HBA "local all all trust#host all all 127.0.0.1/32 trust#host all all 0.0.0.0/0 md5#host all all ::1/128 trust"

# This is a conservative config for a 4GB RAM and 2 CPU, HDD system, 50 connections (testing)
ENV PG_CONF "max_connections=50#shared_buffers=1GB#effective_cache_size=3GB#maintenance_work_mem=256MB#checkpoint_completion_target=0.7#wal_buffers=16MB#default_statistics_target=100#random_page_cost=4#effective_io_concurrency=2#work_mem=104857kB#min_wal_size=1GB#max_wal_size=2GB#max_worker_processes=2#max_parallel_workers_per_gather=1#max_parallel_workers=2#max_wal_senders=5#max_locks_per_transaction=1024#listen_addresses='*'#dynamic_shared_memory_type=posix#log_timezone='UTC'#datestyle='iso, mdy'#timezone='UTC'#log_statement='all'#log_directory='pg_log'#log_filename='postgresql-%Y-%m-%d_%H%M%S.log'#logging_collector=on#client_min_messages=notice#log_min_messages=notice#log_line_prefix='%a %u %d %r %h %m %i %e'#log_destination='stderr,csvlog'#log_rotation_size=500MB#log_error_verbosity=default"


# Load assets
WORKDIR /usr/local
ADD packages/run.sh bin/
ADD packages/setup.sh bin/
ADD packages/pg_hba_conf bin/
ADD packages/postgresql_conf bin/
ADD packages/psqlrc /root/.psqlrc
ADD packages/setup_datastore.sh bin/
ADD packages/gosu bin/


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

