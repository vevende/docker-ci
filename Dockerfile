FROM docker:17.03

RUN apk add --no-cache \
  make \
  py-pip \
  git \
  openssh

RUN set -ex \
  && pip install --no-cache-directory docker-compose \
  && which docker-compose \
  && docker-compose version
