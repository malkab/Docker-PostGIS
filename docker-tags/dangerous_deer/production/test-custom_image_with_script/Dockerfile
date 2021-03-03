FROM malkab/postgis:dangerous_deer

ENV PASSWORD=aaa
ENV LOCALE=es_ES
ENV PG_CONF="max_connections=50#shared_buffers=1GB#effective_cache_size=3GB#maintenance_work_mem=512MB#checkpoint_completion_target=0.7#wal_buffers=16MB#default_statistics_target=100#random_page_cost=4#effective_io_concurrency=2#work_mem=104857kB#min_wal_size=1GB#max_wal_size=2GB#max_worker_processes=2#max_parallel_workers_per_gather=1#max_parallel_workers=2#max_wal_senders=5#max_locks_per_transaction=1024#listen_addresses='*'#dynamic_shared_memory_type=posix#log_timezone='UTC'#datestyle='iso, mdy'#timezone='UTC'#log_statement='all'#log_directory='pg_log'#log_filename='postgresql-%Y-%m-%d_%H%M%S.log'#logging_collector=on#client_min_messages=notice#log_min_messages=notice#log_line_prefix='%a %u %d %r %h %m %i %e'#log_destination='stderr,csvlog'#log_rotation_size=500MB#log_error_verbosity=default"
ENV PG_HBA="local all all md5#host all all 0.0.0.0/0 md5#host all all 127.0.0.1/32 md5#host all all ::1/128 md5"

ADD initdb.sh /
ADD tests.sql /
ADD postgis_test.sql /

