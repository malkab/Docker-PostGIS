# Compilation of PostgreSQL 11.2, PostGIS 2.5.2, GDAL 2.2.4 Patched

This image is not intended for production, nor to upload it to any repo. It's an image to compile from source a PostGIS, take the binaries and build with them a production-ready Docker image (check **production** image).


## Versions

This Dockerfile compiles from source the following software:

- **PostgreSQL 11.2;**

- **GEOS 3.7.2;**

- **Proj 4.9.3:** patched with the spanish national grid for conversion between ED50 to ETRS89;

- **GDAL 2.2.4:** also patched;

- **PostGIS 2.5.2:** patched as well;

- **Python 3:** to be used as PL/Python language version.


## Usage

Just run the build script:

```Shell
docker-build.sh
```

Once build, extract binaries running:

```Shell
docker-get_binaries.sh
```

This will create a **binaries** folder in this directory containing all that the production image needs for the Production image folder to build.
