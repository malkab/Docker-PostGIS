# Compilation of PostgreSQL 12.0, PostGIS 2.5.5, GDAL 3.0.1 NOT PATCHED

This image is not intended for production, nor to upload it to any repo.
It's an image to compile from source a PostGIS, take the binaries and
build with them a production-ready Docker image (check **production**
image).

This also serves as the base image for the **docker-grass** series of
images that installs GRASS and a big deal of other software to create a
super geodata scientist processing image.



## Usage

Just run the build script. This will create an image that compiles and
installs the full software stack into a
**postgis_compilation:[postgis_tag]**:

```Shell
docker-build.sh
```

Once build, extract binaries running:

```Shell
docker-get_binaries.sh
```

This will create a **binaries** folder in this directory containing all
that the production image needs for the Production image folder to
build.



## Versions

This Dockerfile compiles from source the following software:

**REMEMBER:** THIS SOFTWARE AREN'T PATCHED WITH THE NATIONAL GRID.

-   **PostgreSQL 12.0;**

-   **GEOS 3.7.2;**

-   **Proj 6.2.0;**

-   **GDAL 3.0.1;**

-   **PostGIS 2.5.3;**

-   **Python 3:** to be used as PL/Python language version.



## Testing new Compilations Workflows

To test new compilations workflows, first modify the
**packages/postgis_compile.sh** script, that compiles the full stack.
Most probably the file will be commented, except for the first part that
installs package dependencies and creates an start up environment with
all the source code copied and relevant packages installed.

Run the interactive environment with **docker-bash_dev-interactive.sh**
and test new compilations workflows, scripting them back to
**postgis_compile.sh** when they are ready and tested.
