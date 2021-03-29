# Compilation of PostgreSQL 13.2, PostGIS 3.1, GDAL 3.2

This image is not intended for production, nor to upload it to any registry. It's an image to compile from source a PostGIS, take the binaries and build with them a production-ready Docker image (check **020-production** image).

This also serves as the base image for the **docker-grass** series of images that installs GRASS and a big deal of other software to create a super geodata scientist processing image. Image tags of **docker-grass** mimics the one on this repo.

**WARNING:** this build seems not to be able to reproject from ED50 to ETRS89 using the spanish transformation grids. PROJ seems to be doing it right, but GDAL and PostGIS not. Do not use this image for precision reprojecting.


## Usage

Put the downloaded source code tars in **010_compilation/packages**. It's very important to take note of the tested versions for each package:

- **GDAL:** move / rename to **packages/gdal/gdal.tar.gz**;

- **GEOS:** move / rename to **packages/geos/geos.tar.bz2**;

- **PostGIS:** move / rename to **packages/postgis/postgis.tar.gz**;

- **PostgreSQL:** move / rename to **packages/postgresql/postgresql.tar.bz2**;

- **Proj:** move / rename to **packages/proj/proj/proj.tar.gz**. Take also **proj-data** and rename it to **proj-data.tar.gz**.

Then, update **mlkcontext/common** with the versions and the new image tag.

Then follow the scripts. This will create an image that compiles and installs the full software stack into a **postgis_compilation:[postgis_tag]**:

```Shell
010_docker_build.sh
```

Once build, extract binaries running:

```Shell
030_docker_get_binaries.sh
```

This will create a **binaries** folder in this directory containing all that the production image needs for the Production image folder to build.


## Versions

This Dockerfile compiles from source the following software:

- **PostgreSQL 13.2;**

- **GEOS 3.9.1;**

- **Proj 7.2.1;**

- **GDAL 3.2.2;**

- **PostGIS 3.1.1;**

- **Python 3:** to be used as PL/Python language version.

At the time of release, **PROJ 8** was available, but it seems changes in the API makes it not compatible with **PostGIS 3.1.1** at the time.


## Testing new Compilations Workflows

To test new compilations workflows, first modify the **packages/postgis_compile.sh** script that compiles the full stack. Most probably the file will be commented, except for the first part that installs package dependencies and creates an start up environment with all the source code copied and relevant packages installed.

Run the interactive environment with **020_docker_bash_dev.sh** and test new compilations workflows, scripting them back to **postgis_compile.sh** when they are ready and tested.



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

Use the following sample commands to test PROJ and GDAL:

```shell
cs2cs -d 4 EPSG:23030 EPSG:25830

cs2cs +proj=utm +zone=30 +ellps=intl +units=m +no_defs +nadgrids=/usr/local/share/proj/es_ign_SPED2ETV2.tif +to EPSG:25830

gdaltransform -s_srs EPSG:23030 -t_srs EPSG:25830

gdaltransform -s_srs "+proj=utm +zone=30 +ellps=intl +units=m +no_defs +nadgrids=/usr/local/share/proj/es_ign_SPED2ETV2.tif" -t_srs EPSG:25830
```
