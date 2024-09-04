# Karmic Kakarot PostGIS Image

Versions:

    GDAL          3.9.2
    GEOS          3.12.2
    PostGIS       3.4.2
    PostgreSQL    16.4
    PROJ          9.1.1

The build image is a precursor for the GRASS image, which shares the same tags as this one.

PROJ was not the latest version at the time (it was the 9.4.1) but it was the latest version that was compatible with GRASS.

Build the image at **00_build**. Retain the build image for some time to fine-tune the production image, from which it is built.
