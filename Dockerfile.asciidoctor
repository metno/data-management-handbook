#
# Docker file used in GitHub Actions to build HTML and PDF
# versions of mmd-specification.
#

FROM ruby:alpine
LABEL maintainer="aheimsbakk@met.no"

RUN gem install asciidoctor; \
    gem install asciidoctor-pdf --pre; \
    mkdir /workdir

VOLUME /workdir
WORKDIR /workdir
