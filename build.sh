#!/bin/bash
# thanks to lroguet from https://github.com/foertel/rpi-alpine-homeassistant

HA_LATEST=false
DOCKER_USER="andersf"
#MAINTAINER="Felix Oertel <https://github.com/foertel>"
MAINTAINER="Anders Fluur <https://github.com/AndersFluur>"

ARCH=$(uname -m)
if [ "$ARCH" == "armv7l" ]; then
    ALPINE_IMAGE="armhf/alpine"
elif [ "$ARCH" == "aarch64" ]; then
    ALPINE_IMAGE="arm64v8/alpine"
else
    log "Know conversion from current architecture: $ARCH into alpine image. Known architectures: armv7l, and aarch64 !"
    exit 1
fi


log() {
   now=$(date +"%Y%m%d-%H%M%S")
   echo "$now - $*" >> /var/log/docker/hass-build.log
}

log ">>--------------------->>"

## #####################################################################
## Home Assistant version
## #####################################################################
if [ "$1" != "" ]; then
   # Provided as an argument
   HA_VERSION=$1
   log "Docker image with Home Assistant $HA_VERSION"
else
   _HA_VERSION="$(cat /var/log/docker/hass-build.version)"
   HA_VERSION="$(curl 'https://pypi.python.org/pypi/homeassistant/json' | jq '.info.version' | tr -d '"')"
   HA_LATEST=true
   log "Docker image with Home Assistant 'latest' (version $HA_VERSION)" 
fi

## #####################################################################
## For hourly (not parameterized) builds (crontab)
## Do nothing: we're trying to build & push the same version again
## #####################################################################
if [ "$HA_LATEST" = true ] && [ "$HA_VERSION" = "$_HA_VERSION" ]; then
   log "Docker image with Home Assistant $HA_VERSION has already been built & pushed"
   log ">>--------------------->>"
   exit 0
fi

## #####################################################################
## Generate the Dockerfile
## #####################################################################
cat << _EOF_ > Dockerfile
FROM $ALPINE_IMAGE
MAINTAINER $MAINTAINER

RUN apk --no-cache upgrade \\
  && apk --no-cache add python3-dev py-pip \\
  && pip3 install --upgrade pip \\
  && mkdir /config \\
  && pip3 install homeassistant==$HA_VERSION

# Start Home Assistant
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
_EOF_

## #####################################################################
## Build the Docker image, tag and push to https://hub.docker.com/
## #####################################################################
log "Building $DOCKER_USER/rpi-alpine-homeassistant:$HA_VERSION"
docker build -t $DOCKER_USER/rpi-alpine-homeassistant:$HA_VERSION .

log "Pushing $DOCKER_USER/rpi-alpine-homeassistant:$HA_VERSION"
docker push $DOCKER_USER/rpi-alpine-homeassistant:$HA_VERSION

if [ "$HA_LATEST" = true ]; then
   log "Tagging $DOCKER_USER/rpi-alpine-homeassistant:$HA_VERSION with latest"
   docker tag $DOCKER_USER/rpi-alpine-homeassistant:$HA_VERSION $DOCKER_USER/rpi-alpine-homeassistant:latest
   log "Pushing $DOCKER_USER/rpi-alpine-homeassistant:latest"
   docker push $DOCKER_USER/rpi-alpine-homeassistant:latest
   echo $HA_VERSION > /var/log/docker/hass-build.version
fi

log ">>--------------------->>"
