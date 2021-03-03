Compilation of PostgreSQL 10.0, PostGIS 2.4.1, GDAL 2.2.2, Patched
===
This image is not intended for production, nor to upload it to any repo. It's an image to compile from source a PostGIS, take the binaries and build with them a production-ready Docker image (check __Production__ image).


Versions
---
This Dockerfile compiles from source the following software:

- __PostgreSQL 10.0;__

- __GEOS 3.6.2;__

- __Proj 4.9.3:__ patched with the spanish national grid for conversion between ED50 to ETRS89;

- __GDAL 2.2.2:__ also patched;

- __PostGIS 2.4.1:__ patched as well.


Usage
---
Just run the build script:

```Shell
docker-build.sh
```

Once build, extract binaries running:

```Shell
docker-get_binaries.sh
```

This will create a __binaries__ folder containing all that the production image needs at __packages__ folder in Production image folder to build it.
