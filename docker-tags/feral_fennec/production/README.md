# PostgreSQL 12.0, PostGIS 2.5.5, GDAL 3.0.1 NOT PATCHED

This image is intended for production.



## Versions

**REMEMBER:** THIS SOFTWARE AREN'T PATCHED WITH THE NATIONAL GRID.

This image is created with the binaries compiled by the **compilation** image and includes full binaries and assets for the following software:

-   **PostgreSQL 12.0;**

-   **GEOS 3.7.2;**

-   **Proj 6.2.0;**

-   **GDAL 3.0.1;**

-   **PostGIS 2.5.3;**

-   **Python 3:** to be used as PL/Python language version.



## Image Creation

Compile software from source by running the **compilation** image and extract binaries as described in its **README**. Then build this image:

```Shell
docker-build.sh

docker-push.sh
```

or pull it from Docker Hub:

```Shell
docker pull malkab/postgis:feral_fennec
```



## Locales

It has been impossible for me to set up locale initialisation properly. Locales are therefore initialized at image build time. The basic image initialises several common locales, but in child images additional ones can be added easily with the following commands:

```Shell
sed -i -e 's/# it_IT@euro ISO-8859-15/it_IT@euro ISO-8859-15/' /etc/locale.gen

locale-gen
```

The exact locale definition must be checked at the **/etc/locale.gen** file. Currently, generated locales are:

- en_US.UTF-8 UTF-8
- es_ES.UTF-8 UTF-8
- en_US.ISO-8859-15 ISO-8859-15
- en_GB ISO-8859-1
- en_GB.ISO-8859-15 ISO-8859-15
- en_GB.UTF-8 UTF-8
- es_ES ISO-8859-1
- es_ES.UTF-8 UTF-8
- es_ES@euro ISO-8859-15
- de_DE ISO-8859-1
- de_DE.UTF-8 UTF-8
- de_DE@euro ISO-8859-15
- fr_FR ISO-8859-1
- fr_FR.UTF-8 UTF-8
- fr_FR@euro ISO-8859-15
- it_IT ISO-8859-1
- it_IT.UTF-8 UTF-8
- it_IT@euro ISO-8859-15

Once the image has the desired locale generated, it can be selected at container creation time just by setting the **LANG** env variable, such as:

```Shell
LANG=en_US.UTF-8
```

Default LANG is **en_US.UTF-8**.



## Image Infrastructure

The image exposes port **5432** and volume **/data**. **data** is the datastore, where logs are located at **pg_log** folder. **postgres** user, which runs the server, has UID and GID 1500.



## Container Creation

The container will check if there is a datastore initiated at **/data**. If not, it will init it with the following parameters, based on environment variables:

- **PASSWORD:** the starting password for postgres user;
- **LANG:** the locale (see **Locales** section).



## Script Database Initialization

For production environments where the container must deploy a database script at creation time, the container will look for a **/initdb.sh** script to execute. When creating the datastore for the first time, the container will attemp to run this script to initialize the database. Include this script in derived images for a production ready PostGIS with databases and infrastructure created at startup.

**NOTE:** It's very important to refer to any SQL script or other file in the **initdb.sh** script in **absolute path**.

Take into account when preparing this script that by that time the datastore has already been configured with a postgres password equal to env variable **PASSWORD**. For fully automatization, this password is stored in the **$PASSWORD** env variable.

This script can be used to launch database setup procedures or restore a dump loaded into a production Docker image.

This script is only executed once, when the empty datastore is created.



## Data Persistence

Datastore data can be persisted in a data volume or host mounted folder and be used later by another container. The container checks if folder **/data/** is empty or not. If not, considers the datastore to be not created and creates an empty one.



## Configuring the Data Store

The image uses default versions for the _pg_hba.conf_:

```txt
local all all trust
host all all 127.0.0.1/32 trust
host all all 0.0.0.0/0 md5
host all all ::1/128 trust
```

and _postgresql.conf_:

```txt
max_connections=50
shared_buffers=1GB
effective_cache_size=3GB
maintenance_work_mem=512MB
checkpoint_completion_target=0.7
wal_buffers=16MB
default_statistics_target=100
random_page_cost=4
effective_io_concurrency=2
work_mem=104857kB
min_wal_size=1GB
max_wal_size=2GB
max_worker_processes=2
max_parallel_workers_per_gather=1
max_parallel_workers=2
max_wal_senders=5
max_locks_per_transaction=1024
listen_addresses='*'
dynamic_shared_memory_type=posix
log_timezone='UTC'
datestyle='iso, mdy'
timezone='UTC'
log_statement='all'
log_directory='pg_log'
log_filename='postgresql-%Y-%m-%d_%H%M%S.log'
logging_collector=on
client_min_messages=notice
log_min_messages=notice
log_line_prefix='%a %u %d %r %h %m %i %e'
log_destination='stderr,csvlog'
log_rotation_size=500MB
log_error_verbosity=default
```

This configurations are suitable for development. Production deployments may use other configurations. For loading custom configurations, the default ones are stored at **/default_confs/**, by the names **postgresql.conf** and **pg_hba.conf**. Replace this files or mount new configurations as volumes, like in:

```txt
-v $(pwd)/postgresql-c:/default_confs/postgresql.conf
```

Logs are stored at **$POSTGRES_DATA_FOLDER/pg_log**.



## Killing the Container

This container will handle signals send to it with *docker kill* properly, so the database is shut down tidily. Thus:

- **SIGTERM** signals for a smart shutdown, waiting for all connections and transactions to be finished. The server won't allow for new connections, thou:

```Shell
pg_ctl -D . stop -m smart

docker kill -s SIGTERM containername
```

- **SIGINT** signals for fast shutdown. The server will abort current transactions and disconnect users, but will exit nicely otherwise;

```Shell
pg_ctl -D . stop -m fast

docker kill -s SIGINT containername
```

- **SIGQUIT** signals for immediate shutdown. This will leave the database in a improper state and lead to recovery on next startup:

```Shell
pg_ctl -D . stop -m immediate

docker kill -s SIGQUIT containername
```



## Tests

Several tests can be run by launching **test-custom_image_with_script/docker-build-run.sh**.



## Usage Examples

Several usage examples.

Simple run:

```Shell
docker run -ti --rm \
  -v `pwd`/:/ext-out/ \
  -p 5432:5432 \
  malkab/postgis:feral_fennec
```

Custom run:

```Shell
docker run -ti --rm \
  -v `pwd`/:/ext-out/ \
  -p 5432:5432 \
  -e "LANG=es_ES.UTF-8" \
  -e "PASSWORD=thepass" \
  -v $(pwd)/postgresql-c:/default_confs/postgresql.conf \
  -v $(pwd)/pg_hba-c:/default_confs/pg_hba.conf \
  malkab/postgis:feral_fennec
```

Custom command run:

```Shell
docker run -ti --rm \
  --network="host" \
  --entrypoint /bin/bash \
  malkab/postgis:feral_fennec \
  -c "psql -h localhost -p 8888 -U postgres postgres"
```
