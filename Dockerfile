FROM ruby:alpine

#### dpl ####

ENV DPL_VERSION 1.8.32.travis.1901.6
ENV NOKOGIRI_VERSION 1.6.8
ENV AWS_SDK_VERSION 1.66.0
ENV RUBY_ZIP_VERSION 1.2.0

RUN set -ex \
    && apk add --no-cache --virtual .dpl-builddeps \
        autoconf \
        gcc \
        libc-dev \
        libxml2-dev \
        make \
    && gem install nokogiri -v $NOKOGIRI_VERSION \
    && gem install dpl -v $DPL_VERSION \
    && gem install aws-sdk-v1 -v $AWS_SDK_VERSION \
    && gem install rubyzip -v $RUBY_ZIP_VERSION \
    && apk del .dpl-builddeps

#### aws ####

RUN apk add --no-cache \
        git \
        py-pip \
        zip \
    && pip install awscli --ignore-installed six

#### rsync ####

RUN set -ex \
    && apk add --no-cache rsync

#### docker:1.11 + rwhub/ci_docker ####

ENV DOCKER_BUCKET get.docker.com
ENV DOCKER_VERSION 1.11.2
ENV DOCKER_SHA256 8c2e0c35e3cda11706f54b2d46c2521a6e9026a7b13c7d4b8ae1f3a706fc55e1

RUN set -x \
    && apk add --no-cache curl \
    && curl -fSL "https://${DOCKER_BUCKET}/builds/Linux/x86_64/docker-$DOCKER_VERSION.tgz" -o docker.tgz \
    && echo "${DOCKER_SHA256} *docker.tgz" | sha256sum -c - \
    && tar -xzvf docker.tgz \
    && mv docker/* /usr/local/bin/ \
    && rmdir docker \
    && rm docker.tgz \
    && docker -v

#### file ####

RUN set -ex \
    && apk add --no-cache file
