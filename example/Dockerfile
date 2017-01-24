FROM armhf/alpine
MAINTAINER Felix Oertel <https://github.com/foertel>

RUN apk --no-cache upgrade \
  && apk --no-cache add python3-dev py-pip \
  && pip3 install --upgrade pip \
  && mkdir /config \
  && pip3 install homeassistant==0.36.1

# Start Home Assistant
CMD [ "python3", "-m", "homeassistant", "--config", "/config" ]
