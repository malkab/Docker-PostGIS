#!/bin/bash

echo
echo ---------------------
echo PROJ tests with cs2cs
echo ---------------------

echo
echo ------------------------------------------
echo From 4258 \(ETRS89 Geo\) to 4326 \(WGS84 Geo\)
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:4326 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF


echo
echo
echo
echo ------------------------------------------
echo From 4258 \(ETRS89 Geo\) to 4230 \(ED50 Geo\)  _TODO_ para Barcelona
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:4230 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF


echo
echo
echo
echo ------------------------------------------
echo From 4258 \(ETRS89 Geo\) to 25829 \(ETRS89 UTM29N\)
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:25829 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF


echo
echo
echo
echo ------------------------------------------
echo From 4258 \(ETRS89 Geo\) to 25830 \(ETRS89 UTM30N\)
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:25830 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF


echo
echo
echo
echo ------------------------------------------
echo From 4258 \(ETRS89 Geo\) to 25831 \(ETRS89 UTM31N\)
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:25831 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF


echo
echo
echo
echo ------------------------------------------
echo From 4258 \(ETRS89 Geo\) to 23029 \(ED50 UTM29N\)
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:23029 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF


echo
echo
echo
echo ------------------------------------------
echo From 4258 \(ETRS89 Geo\) to 23030 \(ED50 UTM30N\)
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:23030 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF


echo
echo
echo
echo ------------------------------------------
echo From 4258 \(ETRS89 Geo\) to 23031 \(ED50 UTM31N\) _TODO_ para Barcelona
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:23031 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF


echo
echo
echo
echo ------------------------------------------
echo From 4326 \(WGS84 Geo\) to 4320 \(ED50 Geo\) _TODO_ para Barcelona
echo ------------------------------------------
echo
echo Results should be:
echo
echo Sevilla: 5d59\'31.6\"W 37d23\'10\"N
echo Huelva: 7d7\'37.2\"W 37d13\'6\"N 
echo Barcelona: 2d7\'22.1\"E 41d22\'51.2\"N

echo
cs2cs +init=epsg:4258 +to +init=epsg:23031 -w5 <<EOF
5d59'31.6"W 37d23'10"N
7d7'37.2"W 37d13'06"N 
2d8'16.2"E 41d17'35.5"N
EOF

# echo
# echo From 23029 to 25829 _TODO_
# echo Results should be:
# echo -73.24 -173.37
# echo 265353.396 3987805.481
# echo ">>>"
# cs2cs +init=epsg:23030 +to +init=epsg:25830 -w5 <<EOF
# 0 0
# 265467 3988010
# EOF

# echo
# echo From 23030 to 25830
# echo Results should be:
# echo 235094 4141906
# echo 265353.396 3987805.481
# echo ">>>"
# cs2cs +init=epsg:23030 +to +init=epsg:25830 -w5 <<EOF
# 235205.243 4142110.093
# 265467 3988010
# EOF

# echo
# echo From 23031 to 25831 _TODO_
# echo Results should be:
# echo 235094 4141906
# echo 265353.396 3987805.481
# echo ">>>"
# cs2cs +init=epsg:23030 +to +init=epsg:25830 -w5 <<EOF
# 235205.243 4142110.093
# 265467 3988010
# EOF

# echo
# echo From 25829 to 23029 _TODO_
# echo Results should be:
# echo 235205.243 4142110.093
# echo 265467 3988010
# echo ">>>"
# cs2cs +init=epsg:25830 +to +init=epsg:23030 -w5 <<EOF
# 235094 4141906
# 265353.396 3987805.481
# EOF

# echo
# echo From 25830 to 23030
# echo Results should be:
# echo 235205.243 4142110.093
# echo 265467 3988010
# echo ">>>"
# cs2cs +init=epsg:25830 +to +init=epsg:23030 -w5 <<EOF
# 235094 4141906
# 265353.396 3987805.481
# EOF

# echo
# echo From 25831 to 23031 _TODO_
# echo Results should be:
# echo 235205.243 4142110.093
# echo 265467 3988010
# echo ">>>"
# cs2cs +init=epsg:25830 +to +init=epsg:23030 -w5 <<EOF
# 235094 4141906
# 265353.396 3987805.481
# EOF





# echo
# echo From 4230 to 4326 _TODO_
# echo Results should be:
# echo 5d59\'31.59731\"W 37d23\'9.92266\"N
# echo 5d36\'12.32786\"W 36d0\'23.43887\"N
# echo ">>>"
# cs2cs +init=epsg:4230 +to +init=epsg:4258 -w5 <<EOF
# 5d59'26.77534"W 37d23'14.45571"N
# 5d36'7.53"W 36d0'28.1"N
# EOF

# echo
# echo From 4326 to 4230
# echo Results should be:
# echo 5d59\'26.77534\"W 37d23\'14.45571\"N
# echo 5d36\'7.53\"W 36d0\'28.1N\"
# echo ">>>"
# cs2cs +init=epsg:4326 +to +init=epsg:4230 -w5 <<EOF
# 5d59'31.59731"W 37d23'9.92266"N
# 5d36'12.32786"W 36d0'23.43887"N
# EOF

# echo
# echo From 4326 to 4258 _TODO_
# echo Results should be:
# echo 5d59\'26.77534\"W 37d23\'14.45571\"N
# echo 5d36\'7.53\"W 36d0\'28.1N\"
# echo ">>>"
# cs2cs +init=epsg:4326 +to +init=epsg:4230 -w5 <<EOF
# 5d59'31.59731"W 37d23'9.92266"N
# 5d36'12.32786"W 36d0'23.43887"N
# EOF

# echo
# echo From 4258 to 4230 _TODO_
# echo Results should be:
# echo 5d59\'26.77534\"W 37d23\'14.45571\"N
# echo 5d36\'7.53\"W 36d0\'28.1N\"
# echo ">>>"
# cs2cs +init=epsg:4326 +to +init=epsg:4230 -w5 <<EOF
# 5d59'31.59731"W 37d23'9.92266"N
# 5d36'12.32786"W 36d0'23.43887"N
# EOF

# echo
# echo From 4258 to 4326 _TODO_
# echo Results should be:
# echo 5d59\'26.77534\"W 37d23\'14.45571\"N
# echo 5d36\'7.53\"W 36d0\'28.1N\"
# echo ">>>"
# cs2cs +init=epsg:4326 +to +init=epsg:4230 -w5 <<EOF
# 5d59'31.59731"W 37d23'9.92266"N
# 5d36'12.32786"W 36d0'23.43887"N
# EOF