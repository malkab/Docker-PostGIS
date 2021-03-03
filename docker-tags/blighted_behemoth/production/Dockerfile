FROM ubuntu:latest

LABEL author="Juan Pedro Perez"
LABEL email="jpperezalcantara@us.es"


# Environment
ENV PG_VERSION 10.0
ENV GEOS_VERSION 3.6.2
ENV PROJ4_VERSION 4.9.3
ENV GDAL_VERSION 2.2.2
ENV POSTGIS_VERSION 2.4.1
ENV ENCODING UTF-8
# ENV LOCALE en_US
ENV LOCALE en_US
ENV TERM xterm
ENV POSTGRES_PASSWD postgres
ENV PG_HBA "local all all trust#host all all 127.0.0.1/32 trust#host all all 0.0.0.0/0 md5#host all all ::1/128 trust"
ENV PG_CONF "max_connections=100#max_wal_size=2GB#max_wal_senders=5#listen_addresses='*'#shared_buffers=128MB#dynamic_shared_memory_type=posix#log_timezone='UTC'#datestyle='iso, mdy'#timezone='UTC'#log_statement='all'#log_directory='pg_log'#log_filename='postgresql-%Y-%m-%d_%H%M%S.log'#logging_collector=on#client_min_messages=notice#log_min_messages=notice#log_line_prefix='%a %u %d %r %h %m %i %e'#log_destination='stderr,csvlog'#log_rotation_size=500MB#log_error_verbosity=default#max_locks_per_transaction=128"



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
CMD ["run_default"]
