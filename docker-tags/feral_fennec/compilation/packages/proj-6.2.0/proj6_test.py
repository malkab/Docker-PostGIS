#!/usr/bin/env python3
# coding=UTF8

import sys

import subprocess



# Works with the PROJ6 Degree, minutes, second format

class Proj6Dms:

    # The type of coordinates: "D" from DMS, "U" from UTM

    cType = None

    x = None

    y = None

    z = None


    def __init__(self, coord = None):

        if coord:

            self.parse(coord)


    
    
    def longitudeStr(self):

        if self.x[0] < 0:

            letter = "W"

            d = self.x[0] * -1

        else:

            letter = "E"

            d = self.x[0]

        return "%sd%s'%s\"%s" % (d, self.x[1], self.x[2], letter)



    def latitudeStr(self):

        if self.y[0] < 0:

            letter = "S"

            d = self.y[0] * -1

        else:

            letter = "N"

            d = self.y[0]

        return "%sd%s'%s\"%s" % (d, self.y[1], self.y[2], letter)



    def __str__(self):

        if self.cType == "D":

            # For DMS

            if self.z:

                z = self.z

            else:

                z = ""

            return "%s %s %s" % (self.longitudeStr(), self.latitudeStr(), z)
            
        else: 

            # For UTM

            if self.z:

                z = self.z

            else:

                z = ""

            return "%s %s %s" % (self.x, self.y, z)


    # First tolerance is difference in seconds in DMS, second in meters
    # for UTM, third for the z

    def compare(self, coord, tolerance = [ 0, 0, 0 ], heightError = None):

        # For comparisson DMS <> DMS

        if self.cType == "D" and coord.cType == "D":

            if abs(self.x[0] - coord.x[0]) > 0:

                raise Exception("Proj6Dms comparisson error: longitude degrees mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.x[0], coord.x[0]))
            

            if abs(self.y[0] - coord.y[0]) > 0:

                raise Exception("Proj6Dms comparisson error: latitude degrees mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.y[0], coord.y[0]))


            if abs(self.x[1] - coord.x[1]) > 0:

                raise Exception("Proj6Dms comparisson error: longitude minutes mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.x[1], coord.x[1]))
            

            if abs(self.y[1] - coord.y[1]) > 0:

                raise Exception("Proj6Dms comparisson error: latitude minutes mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.y[1], coord.y[1]))
            

            if abs(self.x[2] - coord.x[2]) > tolerance[0]:

                raise Exception("Proj6Dms comparisson error: longitude seconds mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.x[2], coord.x[2]))
            

            if abs(self.y[2] - coord.y[2]) > tolerance[0]:

                raise Exception("Proj6Dms comparisson error: latitude seconds mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.x[2], coord.x[2]))
            

            if self.z and coord.z and heightError: 
                
                if abs(self.z - coord.z) > tolerance[2]:

                    raise Exception("Proj6Dms comparisson error: height mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.z, coord.z))
                
                
        elif self.cType == "U" and coord.cType == "U":

            if abs(self.x - coord.x) > tolerance[1]:

                raise Exception("Proj6Dms comparisson error: x mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.x, coord.x))
            

            if abs(self.y - coord.y) > tolerance[1]:

                raise Exception("Proj6Dms comparisson error: y mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.y, coord.y))
            

            if self.z and coord.z and heightError: 
                
                if abs(self.z - coord.z) > tolerance[2]:
                    
                    raise Exception("Proj6Dms comparisson error: height mismatch for %s <> %s: %s, %s" % (str(self), str(coord), self.z, coord.z))
                

        else:

            raise Exception("Proj6Dms comparisson error: cannot compare coords in DMS and UTM")


    # Parses a 5d59'26.77805"W 37d23'14.53304"N or
    # a 5d59'26.77805"W 37d23'14.53304"N 000

    def parse(self, coords):

        # Check if DMS or UTM

        if coords.find("d") != -1:

            # DMS

            self.cType = "D"

            # A little clean up (tabs to spaces)

            xyz = coords.replace("\t", " ").replace("\n", "").split(" ")

            # Parse longitude and latitude

            self.x = self.parseDms(xyz[0])

            self.y = self.parseDms(xyz[1])

            # Check if height is present

            if len(xyz) == 3:

                self.z = xyz[2]

        else:

            # UTM

            self.cType = "U"

            # A little clean up (tabs to spaces)

            xyz = coords.replace("\t", " ").replace("\n", "").split(" ")

            # Parse longitude and latitude

            self.x = float(xyz[0])

            self.y = float(xyz[1])

            # Check if height is present

            if len(xyz) == 3:

                self.z = float(xyz[2])



    # Parses a 5d59'26.77805"W into [ d, m s ], d has the sign

    def parseDms(self, coord):

        c = coord.split("d")

        d = int(c[0])
        
        c = c[1].split("'")

        m = int(c[0])

        c = c[1].split('"')

        s = float(c[0])

        if c[1] == "W" or c[1] == "S":

            d = d * -1

        return([ d, m, s ])






def cs2csTransform(fromEpsg, toEpsg, coordinate):

        cs2cs = subprocess.Popen([ 
            "cs2cs", 
            "+init=epsg:%s" % fromEpsg, 
            "+to", 
            "+init=epsg:%s" % toEpsg, 
            "-w5"
        ], stdin=subprocess.PIPE, stdout=subprocess.PIPE)

        cs2cs.stdin.write(bytes(coordinate, "utf-8"))

        cs2cs.stdin.close()
        cs2cs.wait()

        result = cs2cs.stdout.read()

        cs2cs.kill()

        return bytes.decode(result, "utf-8")






print('''

-------------------------

PROJ6 Tests

-------------------------
''')

srs = [

    {

        "name": "ETRS89 Geo",
        "epsg": "4258",
        "points": [

            {
                "name":         "sevilla",
                "point":        "5d59'31.6\"W 37d23'10.0\"N"
            },            
            {
                "name":         "huelva",
                "point":        "7d07'37.2\"W 37d13'06.0\"N"
            },
            {
                "name":         "barcelona",
                "point":        "2d08'16.2\"E 41d17'35.5\"N"
            }

        ]

    },

    {
        
        "name": "WGS84 Geo",
        "epsg": "4326",
        "points": [

            {
                "name":         "sevilla",
                "point":        "5d59'31.6\"W 37d23'10.0\"N"
            },            
            {
                "name":         "huelva",
                "point":        "7d07'37.2\"W 37d13'06.0\"N"
            },
            {
                "name":         "barcelona",
                "point":        "2d08'16.2\"E 41d17'35.5\"N"
            }

        ]

    },

    {
        
        "name": "ED50 Geo",
        "epsg": "4230",

        "points": [

            {
                "name":         "sevilla",
                "point":        "5d59'26.77805\"W 37d23'14.53304\"N"
            },            
            {
                "name":         "huelva",
                "point":        "7d07'32.29208\"W 37d13'10.54207\"N"
            },
            {
                "name":         "barcelona",
                "point":        "2d08'20.33264\"E 41d17'39.55654\"N"
            }

        ]

    },

    {
        
        "name": "ETRS89 UTM29N",
        "epsg": "25829",

        "points": [

            {
                "name":         "sevilla",
                "point":        "766303.21 4141952.85"
            },            
            {
                "name":         "huelva",
                "point":        "666182.48 4120736.52"
            },
            {
                "name":         "barcelona",
                "point":        "1433286.03 4631574.02"
            }

        ]

    },

    {
        
        "name": "ED50 UTM29N",
        "epsg": "23029",

        "points": [

            {
                "name":         "sevilla",
                "point":        "766429.25 4142164.49"
            },            
            {
                "name":         "huelva",
                "point":        "666308.09 4120946.4"
            },
            {
                "name":         "barcelona",
                "point":        "1433408.62 4631794.73"
            }

        ]

    }

]


tests = 0
errors = 0


for f in srs:

    for t in srs:

        for p in range(len(f["points"])):

            tests += 1

            toP = Proj6Dms(t["points"][p]["point"])
            
            trans = Proj6Dms(cs2csTransform(f["epsg"], t["epsg"], f["points"][p]["point"]))

            try:

                trans.compare(toP, tolerance = [1, 2, 0])

            except Exception as error:

                errors += 1

                print('''
---------------------------
Error converting from %s (%s) to %s (%s) at point %s
---------------------------
''' % (f["name"], f["epsg"], t["name"], t["epsg"], f["points"][p]["name"]))

                print(error)



print('''
---------------------------

Final: 
    Total tests: %s
    Errors: %s

---------------------------
''' % (tests, errors))
