#PostgreSQL 10.0, PostGIS 2.4.1, GDAL 2.2.2, Patched

##Versions
This image is created with the binaries compiled by the **Compilation** image and includes full binaries and assets for the following software:

- **PostgreSQL 10.0;**

- **GEOS 3.6.2;**

- **Proj 4.9.3:** patched with the spanish national grid for conversion between ED50 to ETRS89;

- **GDAL 2.2.2:** also patched;

- **PostGIS 2.4.1:** patched as well.


##Image Creation
Compile software from source by running the **Compilation** image and extract binaries as described in its **README**. Then build this image:

```Shell
docker-build.sh
```

or pull it from Docker Hub:

```Shell
docker pull malkab/postgis:blighted_behemoth
```


##Image Infrastructure
The image exposes port **5432** and volume **/data**. **data** is the datastore, where logs are located at **pg_log** folder. **postgres** user, which runs the server, has UID and GID 1500.


##Container Creation
There are several options available to create containers. The most simple one:

```Shell
docker run -d -P --name pgcontainer \
malkab/postgis:blighted_behemoth
```

The default encoding will be **UTF-8**, and the locale **en_US**. No additional modification or action is taken.

Containers can be configured by means of setting environmental variables:

- **POSTGRES_PASSWD:** set the password for user postgres. See **Passwords** for more details. Defaults to _postgres_;

- **ENCODING:** encoding to create the data store and the default database, if applicable. Defaults to _UTF-8_;

- **LOCALE:** locale for the data store and the default database, if any. Defaults to _en_US_;

- **PG_HBA:** configuration of _pg_hba.con_ access file. See **Configuring the Data Store** for details;

- **PG_CONF:** configuration of _postgresql.conf_ See **Configuring the Data Store** for details.

Some examples of container initializations:

```Shell
export PGPASSWD="md5"$(printf '%s' "new_password_here" "postgres" | md5sum | cut -d ' ' -f 1) && \
docker run -d -P --name ageworkshoptestpg -e "POSTGRES_PASSWD=${PGPASSWD}" \
malkab/postgis:blighted_behemoth
```

This **run** command will create a container with a default options, but changing the _postgres_ password to _new_password_here_, and sending it already encrypted to the container. Check [Passwords](#Passwords) for details:




Executing Arbitrary Commands
---
The image can run arbitrary commands. This is useful for example for creating a temporary container for just dump a database, run a psql session with the one inside this image, or executing scripts into another container.

Some examples:

```Shell
# Interactive pg_dump, will ask for password

docker run --rm -ti -v /whatever/:/d --link the_container_running_the_database:pg \
malkab/postgis:blighted_behemoth \
pg_dump -b -E UTF8 -f /d/dump -F c -v -Z 9 -h pg -p 5432 -U postgres project

# Full automatic pg_dump, with password as ENV variable

docker run --rm -v /home/malkab/Desktop/:/d --link test_07:pg \
malkab/postgis:blighted_behemoth \
PGPASSWORD="new_password_here" pg_dump -b -E UTF8 -f /d/dump33 -F c \
-v -Z 9 -h pg -p 5432 -U postgres postgres

# Interactive psql

docker run --rm -ti -v /home/malkab/Desktop/:/d --link test_07:pg \ malkab/postgis:blighted_behemoth \ PGPASSWORD="new_password_here" psql -h pg -p 5432 -U postgres postgres
```

Script Database Initialization
---
For production environments where the container must deploy a database script at creation time, the container will look for a **/initdb.sh** script to execute (make sure it is executable). When creating the datastore for the first time, the container will attemp to run this script to initialize the database. Include this script in derived images for a production ready PostGIS with databases and infrastructure created at startup.

This script can be used to launch database setup procedures or restore a dump loaded into a production Docker image.


Data Persistence
---
Datastore data can be persisted in a data volume or host mounted folder and be used later by another container. The container checks if folder **/data/** is empty or not. If not, considers the datastore to be not created and creates an empty one.


Passwords
---
Passwords sent to the container with environment variable **POSTGRES_PASSWD** can be passed either on plain text or already encrypted á la PostgreSQL. To pass it on plain text means that anybody with access to the **docker inspect** command on the server will be able to read passwords. Encrypting them previously means that **docker inspect** will show the encrypted password, adding an additional layer of secrecy.

PostgreSQL passwords are encrypted using the MD5 checksum algorithm on the following literal:

```text
md5 + md5hash(real password + username)
```

For example, in the case of user _myself_ and password _secret_, the encrypted password will be the MD5 sum of _secretmyself_ prefixed with _md5_, in this case, _md5a296d28d6121e7307ac8e72635ae206b_.

To provide encrypted password to containers, use the following command:

```Shell
export USER="projectuser" && \
export USERPASSWD="md5"$(printf '%s' "userpass" ${USER} | md5sum | cut -d ' ' -f 1) && \
export PGPASSWD="md5"$(printf '%s' "password_here" "postgres" | md5sum | cut -d ' ' -f 1) && \
docker run -d -P --name ageworkshoptestpg -e "POSTGRES_PASSWD=${PGPASSWD}" \
-e "CREATE_USER=${USER}" -e "CREATE_USER_PASSWD=${USERPASSWD}" \
malkab/postgis:blighted_behemoth
```

Ugly, but effective. Keep in mind, however, that if you use provisioning methods like bash scripts or _Docker Compose_ others will still be able to read passwords from these sources, so keep them safe. Consider using SWARM or Kubernetes Secrets on production.


Configuring the Data Store
---
The image allows for configuration of _pg_hba.conf_ and _postgresql.conf_ data store files at creation time and later. This is advanced stuff, refer to the PostgreSQL documentation for details.

_pg_hba.conf_ configuration is handled by a script called **pg_hba_conf**. _pg_hba_conf_ has three modes of operation:

```Shell
[1] pg_hba_conf l

[2] pg_hba_conf a "line 1#line 2#...#line n"

[3] pg_hba_conf d "line 1#line 2#...#line n"
```

which means:

- **[1]** prints current contents of _pg_hba.conf_;

- **[2]** adds lines to _pg_hba.conf_;

- **[3]** deletes lines from _pg_hba.conf_.

This commands can be issued by standard Docker's **exec**:

```Shell
docker exec -ti whatevercontainer pg_hba_conf a \
"host all all 23.123.22.1/32 trust#host all all 93.32.12.3/32 md5"
```

but at startup it is controlled by an environment variable, **PG_HBA**, which defaults to:

```txt
ENV PG_HBA "local all all trust#host all all 127.0.0.1/32 trust#host all all 0.0.0.0/0 md5#host all all ::1/128 trust"
```

This defaults should be submitted for basic operation. For universal access, for example for testing, add:

```txt
local all all trust#host all all 0.0.0.0/0 trust#host all all 127.0.0.1/32 trust#host all all ::1/128 trust
```

Modify this variable to configure at creation time. Keep in mind, however, that any value provided to this variable will supersede the default. Don't forget to include basic access permissions if you modify this variable, or the server will be hardly reachable. For testing purposes, direct commands can be issued via **exec**.

Configuration of **postgresql.conf** follows an identical procedure. Command is **postgresql_conf** and has the same syntax as **pg_hba_conf**. The environmental variable is **PG_CONF**, which defaults to the following configuration:

```txt
max_connections=100#listen_addresses='*'#shared_buffers=128MB#dynamic_shared_memory_type=posix#log_timezone='UTC'#datestyle='iso, mdy'#timezone='UTC'#lc_messages='en_US.UTF-8'#lc_monetary='en_US.UTF-8'#lc_numeric='en_US.UTF-8'#lc_time='en_US.UTF-8'#log_statement='all'#log_directory='pg_log'#log_filename='postgresql-%Y-%m-%d_%H%M%S.log'#logging_collector=on#client_min_messages=notice#log_min_messages=notice#log_line_prefix='%a %u %d %r %h %m %i %e'#log_destination='stderr,csvlog'#log_rotation_size=500MB
```

At creation time, language, encoding, and locale info is added based on env variables **LOCALE** and **ENCODING**.

Logs are stored at **$POSTGRES_DATA_FOLDER/pg_log**.


Killing the Container
---
This container will handle signals send to it with _docker kill_ properly, so the database is shut down tidily. Thus:

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
