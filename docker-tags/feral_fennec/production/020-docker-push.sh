#!/bin/bash

. ../env.env

docker login

docker push malkab/postgis:$DOCKER_IMAGE_TAG
