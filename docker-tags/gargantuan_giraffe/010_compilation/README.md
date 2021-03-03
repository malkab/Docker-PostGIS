# Compilation of PostgreSQL 12.3, PostGIS 3.1.0alpha2, GDAL 3.1.2

This image is not intended for production, nor to upload it to any registry. It's an image to compile from source a PostGIS, take the binaries and build with them a production-ready Docker image (check **020-production** image).

This also serves as the base image for the **docker-grass** series of images that installs GRASS and a big deal of other software to create a super geodata scientist processing image. Image tags of **docker-grass** mimics the one on this repo.



## Usage

Just run the build script. This will create an image that compiles and installs the full software stack into a **postgis_compilation:[postgis_tag]**:

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

- **PostgreSQL 12.3;**

- **GEOS 3.8.1;**

- **Proj 7.1.0;**

- **GDAL 3.1.2;**

- **PostGIS 3.1.0alpha2;**

- **Python 3:** to be used as PL/Python language version.



## Testing new Compilations Workflows

To test new compilations workflows, first modify the **packages/postgis_compile.sh** script that compiles the full stack. Most probably the file will be commented, except for the first part that installs package dependencies and creates an start up environment with all the source code copied and relevant packages installed.

Run the interactive environment with **020_docker_bash_dev.sh** and test new compilations workflows, scripting them back to **postgis_compile.sh** when they are ready and tested.
