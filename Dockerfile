FROM ruby:alpine

#### dpl ####

ENV DPL_VERSION 1.8.18

RUN gem install dpl -v $DPL_VERSION

#### aws ####

RUN apk add --no-cache \
        git \
        py-pip \
        zip \
    && pip install awscli --ignore-installed six
