This folder contains an example of custom image for production that runs a custom startup script.

**docker-build-run.sh** will create the image **testpostgis-deleteme** and run it. The **initdb.sh** script should run and configure the postgres user password to "aaa" and create a new database called "ul". Run a psql session with **020-docker-psql.sh** and check the initdb.sh has done its job.
