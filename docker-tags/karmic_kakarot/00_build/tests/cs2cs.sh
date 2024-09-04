#!/bin/bash

# -------------------------
#
# Tests GDAL transformations.
#
# -------------------------

echo
echo
echo --------------------
echo
echo Vanilla cs2cs
echo
echo From 23028 to 25828
echo 235200 4142110 should be 235076.64 4141872.38
echo
echo --------------------
echo 235200 4142110 | cs2cs -d 9 EPSG:23028 EPSG:25828

echo
echo
echo --------------------
echo
echo Vanilla cs2cs
echo
echo From 23029 to 25829
echo 235200 4142110 should be 235086.89 4141884.24
echo
echo --------------------
echo 235200 4142110 | cs2cs -d 9 EPSG:23029 EPSG:25829

echo
echo
echo --------------------
echo
echo Vanilla cs2cs
echo
echo From 23030 to 25830
echo 235200 4142110 should be 235088.76 4141905.91
echo
echo --------------------
echo 235200 4142110 | cs2cs -d 9 EPSG:23030 EPSG:25830

echo
echo
echo --------------------
echo
echo Vanilla cs2cs
echo
echo From 23031 to 25831
echo 235200 4142110 should be 235103.57 4141908.03
echo
echo --------------------
echo 235200 4142110 | cs2cs -d 9 EPSG:23031 EPSG:25831

echo
echo
echo --------------------
echo
echo Vanilla cs2cs
echo
echo From 4230 to 4258
echo 5 37 should be 5.00131943 36.99873538
echo
echo --------------------
echo 5 37 | cs2cs -d 9 EPSG:4230 EPSG:4258

echo
echo
echo --------------------
echo
echo Origin custom cs2cs
echo
echo From 23030 to 25830
echo 235200 4142110 should be 235088.76 4141905.91
echo
echo --------------------
echo 235200 4142110 | cs2cs +proj=utm +zone=30 +ellps=intl +units=m +no_defs +nadgrids=/usr/local/share/proj/es_ign_SPED2ETV2.tif +to EPSG:25830

echo
echo
echo --------------------
echo
echo Origin custom cs2cs
echo
echo From 23031 to 25831
echo 235200 4142110 should be 235103.57 4141908.03
echo
echo --------------------
echo 235200 4142110 | cs2cs +proj=utm +zone=31 +ellps=intl +units=m +no_defs +nadgrids=/usr/local/share/proj/es_ign_SPED2ETV2.tif +to EPSG:25831

echo
echo
echo --------------------
echo
echo Vanilla gdaltransform
echo
echo From 23028 to 25828
echo 235200 4142110 should be 235076.64 4141872.38
echo
echo --------------------
echo 235200 4142110 | gdaltransform -s_srs EPSG:23028 -t_srs EPSG:25828

echo
echo
echo --------------------
echo
echo Vanilla gdaltransform
echo
echo From 23029 to 25829
echo 235200 4142110 should be 235086.89 4141884.24
echo
echo --------------------
echo 235200 4142110 | gdaltransform -s_srs EPSG:23029 -t_srs EPSG:25829

echo
echo
echo --------------------
echo
echo Vanilla gdaltransform
echo
echo From 23030 to 25830
echo 235200 4142110 should be 235088.76 4141905.91
echo
echo --------------------
echo 235200 4142110 | gdaltransform -s_srs EPSG:23030 -t_srs EPSG:25830

echo
echo
echo --------------------
echo
echo Vanilla gdaltransform
echo
echo From 23031 to 25831
echo 235200 4142110 should be 235103.57 4141908.03
echo
echo --------------------
echo 235200 4142110 | gdaltransform -s_srs EPSG:23031 -t_srs EPSG:25831

echo
echo
echo --------------------
echo
echo Vanilla gdaltransform
echo
echo From 4230 to 4258
echo 5 37 should be 5.00131943 36.99873538
echo
echo --------------------
echo 5 37 | gdaltransform -s_srs EPSG:4230 -t_srs EPSG:4258

echo
echo
echo --------------------
echo
echo Custom gdaltransform
echo
echo From 23030 to 25830
echo 235200 4142110 should be 235088.76 4141905.91
echo
echo --------------------
echo 235200 4142110 | gdaltransform -s_srs "+proj=utm +zone=30 +ellps=intl +units=m +no_defs +nadgrids=/usr/local/share/proj/es_ign_SPED2ETV2.tif" -t_srs EPSG:25830

echo
echo
echo --------------------
echo
echo Custom gdaltransform
echo
echo From 23031 to 25831
echo 235200 4142110 should be 235103.57 4141908.03
echo
echo --------------------
echo 235200 4142110 | gdaltransform -s_srs "+proj=utm +zone=31 +ellps=intl +units=m +no_defs +nadgrids=/usr/local/share/proj/es_ign_SPED2ETV2.tif" -t_srs EPSG:25831

echo
echo
