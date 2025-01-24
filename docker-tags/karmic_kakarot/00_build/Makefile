# ¡ATENCIÓN! Esto hay que cambiarlo también en el FROM del Dockerfile
BASE_IMAGE_NAME=debian:bookworm
IMAGE_NAME=postgis_build:karmic_kakarot
IMAGE_SAVE_NAME=postgis_karmic_kakarot

# Versiones
GDAL_VERSION=3.9.2
GEOS_VERSION=3.12.2
POSTGIS_VERSION=3.4.2
PG_VERSION=16.4
PROJ_VERSION=9.1.1

# Build
build:
	@docker build --force-rm \
		-t $(IMAGE_NAME) \
		--build-arg DOCKER_IMAGE_TAG=$(DOCKER_IMAGE_TAG) \
    	--build-arg GDAL_VERSION=$(GDAL_VERSION) \
    	--build-arg GEOS_VERSION=$(GEOS_VERSION) \
    	--build-arg POSTGIS_VERSION=$(POSTGIS_VERSION) \
    	--build-arg PG_VERSION=$(PG_VERSION) \
    	--build-arg PROJ_VERSION=$(PROJ_VERSION) \
		.

# Ejecuta la imagen construída. Genera un contenedor no temporal para poder
# experimentar con las compilaciones, que pueden ser largas.
run:
	@docker run -ti \
		--name $(IMAGE_SAVE_NAME)_build \
		-v $(shell pwd):$(shell pwd) \
		--workdir $(shell pwd) \
		--entrypoint /bin/bash \
		$(IMAGE_NAME)

## TODO: HACER UN CLEAN

# Respaldo a tar.gz de la imagen
save:
	@docker image save $(IMAGE_NAME) $(IMAGE_NAME) | gzip > \
		$(IMAGE_SAVE_NAME).tar.gz
