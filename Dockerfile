FROM ubuntu:latest
MAINTAINER Kengo Suzuki

# Make Packages Latest
RUN set -ex && \
    apt-get update  && \
    apt-get -y upgrade

# Install Required Packages
RUN set -ex && \
    apt-get install -y man  && \
    apt-get install -y vim  && \
    apt-get install -y aria2  && \
    apt-get install -y curl  && \
    apt-get install -y wget  && \
    apt-get install -y bzip2  && \
    apt-get install -y git

