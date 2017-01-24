[![foertel/rpi-alpine-homeassistant](https://img.shields.io/docker/pulls/foertel/rpi-alpine-homeassistant.svg)](https://hub.docker.com/r/foertel/rpi-alpine-homeassistant/)
[![foertel/rpi-alpine-homeassistant](https://images.microbadger.com/badges/version/foertel/rpi-alpine-homeassistant.svg)](https://hub.docker.com/r/foertel/rpi-alpine-homeassistant/) [![foertel/rpi-alpine-homeassistant](https://images.microbadger.com/badges/image/foertel/rpi-alpine-homeassistant.svg)](https://hub.docker.com/r/foertel/rpi-alpine-homeassistant/)

# Alpine Home Assistant Docker image for Raspberry Pi

## Description
Generate a Dockerfile, build a Raspberry Pi compatible Docker image with [Home Assistant](https://home-assistant.io/) and push it to https://hub.docker.com.

Image is based on Alpine Linux for smaller footprint and increased security.

## Build

*Note. You may want to comment out the last line of build.sh or update the tags with your own repository.*

### Latest version
To build a Docker image with the version of Home Assistant found at https://pypi.python.org/pypi/homeassistant/json just run `./build.sh`

*Note. This build case requires you have 'jq' installed.*

### Specific version
To build a Docker image with a specific version of Home Assistant run `./build.sh x.y.z` (`./build.sh 0.23.1` for example).

## Simple usage
`docker run -d --name hass -v /etc/localtime:/etc/localtime:ro foertel/rpi-alpine-homeassistant:latest`

## Additional parameters
### Persistent configuration
Create a folder where you want to store your Home Assistant configuration (/home/pi/home-assistant/configuration for example) and add this data volume to the container using the `-v` flag.

`docker run -d --name hass -v /etc/localtime:/etc/localtime:ro -v /home/pi/home-assistant/configuration:/config foertel/rpi-alpine-homeassistant:latest`

### Enable uPnP discovery
In order to enable the discovery feature (for devices such as Google Chromecasts, Belkin WeMo switches, Sonos speakers, ...) Home Assistant must run on the same network as the devices. The `--net=host` Docker option is needed.

`docker run -d --name hass --net=host -v /etc/localtime:/etc/localtime:ro foertel/rpi-alpine-homeassistant:latest`

## Usage
### One-liner
`docker run -d --name hass --net=host -v /etc/localtime:/etc/localtime:ro -v /home/pi/home-assistant/configuration:/config foertel/rpi-alpine-homeassistant:latest`

## Links
* Thanks to [lroguet](https://github.com/lroguet/rpi-home-assistant) for the initial version of this based on ubuntu.
* [Home Assistant, Docker & a Raspberry Pi](https://fourteenislands.io/home-assistant-docker-and-a-raspberry-pi/)
* [Docker public repository](https://hub.docker.com/r/foertel/rpi-alpine-homeassistant/)
* [Home Assistant](https://home-assistant.io/)
