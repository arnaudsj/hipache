FROM ubuntu:14.04

MAINTAINER Sébastien Arnaud, sarnaud@opinionlab.com

# Since we don't plan to interact let's make this clean
ENV DEBIAN_FRONTEND noninteractive

# make sure apt is up to date
RUN apt-get update

# Upgrade anything that needs to be upgraded
RUN apt-get upgrade -y

# Install supervisor, node, npm and redis
RUN apt-get -y install nodejs-legacy npm

# Manually add hipache folder
RUN mkdir /srv/hipache
ADD . /srv/hipache

WORKDIR /srv/hipache

# Then install it
RUN npm install --production

# Setting up log folder
RUN mkdir /var/log/hipache

# This is provisional, as we don't honor it yet in hipache
ENV NODE_ENV development

# Set this to ready /config/config_$env$.json
ENV SETTINGS_FLAVOR development

# Add supervisor conf
# add ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Expose hipache
EXPOSE 80

# Start supervisor
CMD ["bin/hipache"]
