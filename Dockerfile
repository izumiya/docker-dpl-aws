FROM ruby:alpine

#### dpl ####

ENV DPL_VERSION 1.8.18
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
