[![foertel/rpi-alpine-homeassistant](https://img.shields.io/docker/pulls/foertel/rpi-alpine-homeassistant.svg)](https://hub.docker.com/r/foertel/rpi-alpine-homeassistant/)
[![foertel/rpi-alpine-homeassistant](https://images.microbadger.com/badges/version/foertel/rpi-alpine-homeassistant.svg)](https://hub.docker.com/r/foertel/rpi-alpine-homeassistant/) [![foertel/rpi-alpine-homeassistant](https://images.microbadger.com/badges/image/foertel/rpi-alpine-homeassistant.svg)](https://hub.docker.com/r/foertel/rpi-alpine-homeassistant/)

# Alpine Home Assistant Docker image for Raspberry Pi

## Description
Generate a Dockerfile, build an ARM compatible Docker image with [Home Assistant](https://home-assistant.io/) and push it to https://hub.docker.com.
The docker image is named and generated differently depending on the CPU architecture on the device used for building.
For example Raspberry Pi's with 32 bits ARM v7 CPU will generate an image named homeassistant-alpian-armhf, while
64 bit CPUs will generate 64 bits images, which are named homeassistant-alpian-arm64v8.

Image is based on Alpine Linux for smaller footprint and increased security.

## Build

*Note. You may want to comment out the last line of build.sh or update the tags with your own repository.*

### Latest version
To build a Docker image with the version of Home Assistant found at https://pypi.python.org/pypi/homeassistant/json just run `./build.sh`

*Note. This build case requires you have 'jq' installed.*

### Specific version
To build a Docker image with a specific version of Home Assistant run `./build.sh x.y.z` (`./build.sh 0.23.1` for example).

## Simple usage 
### armhf (Typically Raspberry Pi)
`docker run -d --name hass -v /etc/localtime:/etc/localtime:ro andersf/alpine-homeassistant-armhf:latest`

### ARM 64v8 (NOTE: All examples below are specifically for armhf)
`docker run -d --name hass -v /etc/localtime:/etc/localtime:ro andersf/alpine-homeassistant-arm64v8:latest`

## Additional parameters
### Persistent configuration
Create a folder where you want to store your Home Assistant configuration ($HOME/home-assistant/configuration for example) and add this data volume to the container using the `-v` flag.

`docker run -d --name hass -v /etc/localtime:/etc/localtime:ro -v $HOME/home-assistant/configuration:/config andersf/alpine-homeassistant-armhf:latest`

### Enable uPnP discovery
In order to enable the discovery feature (for devices such as Google Chromecasts, Belkin WeMo switches, Sonos speakers, ...) Home Assistant must run on the same network as the devices. The `--net=host` Docker option is needed.

`docker run -d --name hass --net=host -v /etc/localtime:/etc/localtime:ro andersf/alpine-homeassistant-armhf:latest`

## Usage
### One-liner
`docker run -d --name hass --net=host -v /etc/localtime:/etc/localtime:ro -v $HOME/home-assistant/configuration:/config anders/alpine-homeassistant-armhf:latest`

## Links
* Thanks to [foertel](https://github.com/foertel/rpi-alpine-homeassistant) for the initial version of this, specifically for RPI.
* Thanks to [lroguet](https://github.com/lroguet/rpi-home-assistant) for the initial version of this based on ubuntu.
* [Home Assistant, Docker & a Raspberry Pi](https://fourteenislands.io/home-assistant-docker-and-a-raspberry-pi/)
* [Docker public repository](https://hub.docker.com/r/foertel/rpi-alpine-homeassistant/)
* [Home Assistant](https://home-assistant.io/)
