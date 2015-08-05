FROM phusion/passenger-ruby22
MAINTAINER Mike Long <mike@praqma.com>

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
# Commands to build and run cyber-dojo server
#     $ docker build -t mike/cyberdojo:latest .
#     $ docker run --name=cyber-dojo-server --privileged -p 80:80 -t -d mike/cyber-dojo
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# As docker images cannot be stored within another docker image they neeed to be
# manually pulled into a running container once it's been created
#     $ docker exec -ti cyber-dojo-server /bin/bash
# from the containers bash prompt
#     $ docker pull cyberdojo/clang-3.6.0_googletest
#     $ exit
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# From plain terminal determine the IP address to put into the browser
#     $ boot2docker ip
#
# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - -
#
# As docker images cannot be stored within another docker image or a container the
# /var/lib/docker directory of the container is stored as a volume on the main
# servers filesystem in the /var/lib/docker/volumes directory. The volume directory
# relating to a container is not removed when using the `docker rm` command so either
# needs to be removed manually or use a script.
# (e.g. `https://github.com/chadoe/docker-cleanup-volumes`)
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

