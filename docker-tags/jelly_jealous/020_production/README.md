# Docker Image for PostgreSQL 15.3, PostGIS 3.3.4, GDAL 3.7.1

This image is intended for production.


## Versions

This image is created with the binaries compiled by the **compilation** image (see **010_compilation**) and includes full binaries and assets for the following software:

- PostgreSQL 15.3;

- GEOS 3.12.0;

- Proj 9.2.1;

- GDAL 3.7.1;

- PostGIS 3.3.4;

- Python 3 to be used as PL/Python language version.

Also check the version of the **Docker Ubuntu base image** in the **Dockerfile** at **Docker Hub** and update it to the latest LTS.


## Datum Shifting

Regarding Spanish transformations, specially those concerning Andalusia, this image contains PROJ, GDAL, and PostGIS, all of them systems capable of shifting coordinates accurately using the IGN's grid from ED50 to ETRS89 for UTM zones 30 and 31. Other transformations are not covered by the grid. See **notes about datum shifting** below.

Most common transformations are accurate, but others not. Check if a given transformation is precise with the help of the [**Calculadora Geodésica** from IGN](https://www.ign.es/web/calculadora-geodesica).


## Image Pull

Pull it from Docker Hub:

```Shell
docker pull malkab/postgis:jelly_jealous
```


## Image Creation

Compile software from source by running the **compilation** image as described in **010_compilation**. With the **default context** active, **rsync** if needed, and build this image:

- [] if not done at the compilation process, modify the **mlkctxt.yaml** with versions and ssh credentials if going to build on remote;

- [] activate the **default** context (check for generated script because mlkctxt drops .0 values);

- [] rsync to remote and ssh, if applicable;

- [] build with **010**;

- [] start a test instance with **020** and test a psql session with **030**;

- [] test with the assets at **test_custom_image_with_scripts**. This will test PostGIS and datum shiftings;

- [] push with **050**;

- [] don't forget to check the **README.md's** in **010**, **020**, and the repo top one (add a new entry for the new tag). It is advisable to look for the last image tag to check typos in the current tag documentation;

- [] clean residual Docker images if needed (mind the GRASS image);

- [] when ready, add to the repo a tag in the shape **tag-vX.X.X**, like **jelly_jealous-v1.0.0**.


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

The image exposes port **5432** and volume **/data**. **data** is the datastore, where logs are located at **pg_log** folder. **postgres** user, which runs the server, has UID and GID 1000, and this cannot be changed.


## Container Creation

The container will check if there is a datastore initiated at **/data**. If not, it will init it with the following parameters, based on environment variables:

- **PASSWORD:** the starting password for postgres user;
- **LANG:** the locale (see **Locales** section).

Remember that the datastore must adhere to some critical rules:

- datastore folders must have permissions **0700**;

- files in datastore must have permissions **0600**.


## User Mapping

For the internal **postgres** user, which runs the server (root can't do that), UID and GID are fixed to 1000:1000 and this is not configurable. To run **psql** sessions (there is a **run_psql.sh** script available to launch them automatically), the image defines UID/GID from 1000 to 1004 for Linux and 500:504 for Mac. The user can be selected with the standard **--user UID:GID** Docker's switch.


## Script Database Initialization

For production environments where the container must deploy a database script at creation time, the container will look for a **/initdb.sh** script to execute. When creating the datastore for the first time, the container will attemp to run this script to initialize the database. Include this script in derived images for a production ready PostGIS with databases and infrastructure created at startup.

**NOTE:** It's very important to refer to any SQL script or other file in the **initdb.sh** script in **absolute path**.

Take into account when preparing this script that by that time the datastore has already been configured with a postgres password equal to env variable **PASSWORD**. For fully automatization, this password is stored in the **$PASSWORD** env variable.

This script can be used to launch database setup procedures or restore a dump loaded into a production Docker image.

This script is only executed once, when the empty datastore is created.


## Data Persistence

Datastore data can be persisted in a data volume or host mounted folder and be used later by another container. The container checks if folder **/data/** is empty or not. If not, considers the datastore to be not created and creates an empty one.


## psql Script

The image contains a script called **run_psql.sh** that runs a PSQL session based on several ENV VARS:

- **HOST:** DB host, defaults to **localhost**;
- **PORT:** DB port, defaults to **5432**;
- **USER:** DB user, defaults to **postgres**;
- **PASS:** DB user's password, defaults to **postgres**;
- **DB:** DB to connect to;
- **SCRIPT:** a script file (mounted externally in a volume or something) to execute;
- **COMMAND:** a command to execute;
- **OUTPUT_FILES:** the output file to dump execution to.


## Configuring the Data Store

The image uses default versions for the **pg_hba.conf**:

```txt
local all all trust
host all all 127.0.0.1/32 trust
host all all 0.0.0.0/0 md5
host all all ::1/128 trust
```

and **postgresql.conf**:

```txt
max_connections=20
shared_buffers=1GB
effective_cache_size=3GB
maintenance_work_mem=512MB
checkpoint_completion_target=0.9
wal_buffers=16MB
default_statistics_target=500
random_page_cost=4
effective_io_concurrency=2
work_mem=26214kB
min_wal_size=4GB
max_wal_size=16GB
max_worker_processes=2
max_parallel_workers_per_gather=1
max_parallel_workers=2
max_parallel_maintenance_workers = 1
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

This configurations are suitable for development, with very conservative settings: a machine of 4GB RAM with 2 CPU. Use the site [PG TUNE](https://pgtune.leopard.in.ua/#/) to dimension the configuration to the real system. Production deployments may use other configurations. For loading custom configurations, the default ones are stored at **/default_confs/**, by the names **postgresql.conf** and **pg_hba.conf**. Replace this files or mount new configurations as volumes, like in:

```txt
-v $(pwd)/postgresql-c:/default_confs/postgresql.conf
-v $(pwd)/pg_hba-c:/default_confs/pg_hba.conf
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
  malkab/postgis:jelly_jealous
```

Custom configurations mounted from local files (for development, for example):

```Shell
docker run -ti --rm \
  -v `pwd`/:/ext-out/ \
  -p 5432:5432 \
  -e "LANG=es_ES.UTF-8" \
  -e "PASSWORD=thepass" \
  -v $(pwd)/postgresql-c:/default_confs/postgresql.conf \
  -v $(pwd)/pg_hba-c:/default_confs/pg_hba.conf \
  malkab/postgis:jelly_jealous
```

Custom psql command run, mapping the user to 1000:1000:

```Shell
docker run -ti --rm \
  --name testpostgis-deleteme_psql \
  --network=container:testpostgis-deleteme \
  --user 1000:1000 \
  -v $(pwd):$(pwd) \
  --workdir $(pwd) \
  -e "HOST=localhost" \
  -e "PORT=5432" \
  -e "DB=postgres" \
  -e "USER=postgres" \
  -e "PASS=aaa" \
  --entrypoint /bin/bash \
  malkab/postgis:jelly_jealous \
  -c run_psql.sh
```


## A note on Datum Shifting

The PROJ version installed comes with the Spanish National Grids for datum shifting between ED50 and ETRS89. However, it has been tested to work only in these transformations:

- **ED50 UTM30N (EPSG:23030) to ETRS89 UTM30N (EPSG:25830)**;

- **ED50 UTM31N (EPSG:23031) to ETRS89 UTM31N (EPSG:25831)**.

Other transformations won't work with the current grid.

To test datum shifting, use the following coordinate transformations, performed by the IGN's geodesic calculator:

- **EPSG:23028 to EPSG:25828:** 235200 4142110  >  235076.64 4141872.38

- **EPSG:23029 to EPSG:25829:** 235200 4142110  >  235086.89 4141884.24

- **EPSG:23030 to EPSG:25830:** 235200 4142110  >  235088.76 4141905.91

- **EPSG:23031 to EPSG:25831:** 235200 4142110  >  235103.57 4141908.03

- **EPSG:4230 to EPSG:4258:**   5 37            >  5.00131943 36.99873538

Use the **tests/cs2cs.sh** script to test different transformations.
