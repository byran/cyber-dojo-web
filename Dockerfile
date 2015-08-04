FROM phusion/passenger-ruby22
MAINTAINER Mike Long <mike@praqma.com>

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# WORK IN PROGRESS
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Need to determine how a dockerized cyber-dojo server will itself have
# access to docker to be able to process the incoming [test] events.
#
# Commands to build and run cyber-dojo server (tested from OSX using boot2docker)
#     $ docker build -t mike/cyberdojo:latest .
#     $ docker run -d -P -p 80:80 -p 443:443 mike/cyberdojo:latest
#
# From plain terminal determine the IP address to put into the browser
#     $ boot2docker ip
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -

# Add support scripts
ADD ./container_scripts/setup-docker-server.sh /setup-docker-server.sh
ADD ./container_scripts/start-cyber-dojo /usr/local/bin/start-cyber-dojo

# Install cyber-dojo
RUN /setup-docker-server.sh

# Define additional metadata for our image.
VOLUME /var/lib/docker
CMD ["start-cyber-dojo"]

