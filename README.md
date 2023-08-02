# PostgreSQL / PostGIS Docker Images

This repository contains Docker image builds for PostgreSQL / PostGIS. This is the general README, please check version READMEs in the correponding folders.


## How to Create New Versions

Copy the latest version tag, give it another name, and configure following instructions at **README.md**.


## Quick Tags Overview

Please refer to each tag README.md for full details. To get a quick overview over tags capabilities:

- **jelly_jealous:** released 2023-08-02. Versions are: PostgreSQL 15.3, GEOS 3.12.0, Proj 9.2.1, GDAL 3.7.1, PostGIS 3.3.4, and Python 3 as PL/Python language. The compilation image of this repo is the base for the compilation of the GRASS image of the same tag.

- **idiosyntratic_ibex:** released 2022-11-02. Versions are: PostgreSQL 15.0, GEOS 3.11.0, Proj 9.1.0, GDAL 3.5.2, PostGIS 3.3.1, and Python 3 as PL/Python language. The compilation image of this repo is the base for the compilation of the GRASS image of the same tag.

- **holistic_hornet:** released 2021-03-03. Versions are: PostgreSQL 13.2, GEOS 3.9.1, Proj 7.2.1, GDAL 3.2.1, PostGIS 3.1.1, and Python 3 as PL/Python language. The compilation image of this repo is the base for the compilation of the GRASS image. **WARNING:** national spanish grids for precision datum shift between ED50 and ETRS89 are not implemented. PROJ seems to provide accurate reprojections, but GDAL and PostGIS not.

- **gargantuan_giraffe:** released 2020-08-02, patched with the national grids thanks to PROJ7. Versions are: PostgreSQL 12.3, GEOS 3.8.1, Proj 7.1.0, GDAL 3.1.2, PostGIS 3.1.0alpha2, Python 3 as PL/Python language. The COAST GeoScience image has been deprecated and replaced by the GRASS Docker image, which is the heavy geoscience image full of libraries. The compilation image of this repo is the base for the compilation of the GRASS image.

- **feral_fennec:** released 2019-10-17, but UNPATCHED. The national grid for datum shiftings are not implemented in the new PROJ V6. Versions are: PostgreSQL 12.0, GEOS 3.7.2, PROJ 6.2.0, GDAL 3.0.1, POSTGIS 2.5.3, with Python 3 as PL/Python language. This version should be used as base for further releases, and is also the base for the COAST GeoScience image;

- **endangered_equidna:** released 2019-05-21. PostgreSQL 11.2, GEOS 3.7.2, PROJ4 4.9.3, GDAL 2.2.4, PostGIS 2.5.2, with Python 3 as PL/Python language. This version is not intended for production, is just to mimic a certain deployment in Windows used in a training course for compatibility reasons. Use candid_candice instead. But it is the first iteration to include a fully parametrized build system that simplifies the creation of new tags with minimum hassle. Check **How to Create New Versions** above;

- **dangerous_deer:** released 2018-08-18. PostgreSQL 10.4, GEOS 3.6.3, PROJ4 4.9.3, GDAL 2.3.1, PostGIS 2.4.4, with Python 2 as PL/Python language, just to serve as base for the GRASS image;

- **candid_candice:** released 2018-08-18. PostgreSQL 10.4, GEOS 3.6.3, PROJ4 4.9.3, GDAL 2.3.1, PostGIS 2.4.4, with Python 3 as PL/Python language;

- **blighted_behemoth:** released 2018-03-19. PostgreSQL 10.0, GEOS 3.6.2, PROJ4 4.9.3, GDAL 2.2.2, PostGIS 2.4.1.

- **awaken_amazon:** released 2017-09-13. PostgreSQL 9.6.5, GEOS 3.5.1, PROJ4 4.9.3, GDAL 2.1.4, PostGIS 2.3.3.
