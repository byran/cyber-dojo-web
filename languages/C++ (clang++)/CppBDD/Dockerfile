FROM       cyberdojo/clang-3.6.0
MAINTAINER Byran Wills-Heath <byran@adgico.co.uk>

RUN apt-get -y install software-properties-common
RUN add-apt-repository ppa:ubuntu-toolchain-r/test
RUN apt-get update
RUN apt-get install -y g++-4.9
RUN apt-get install -y git

WORKDIR /usr/src/
RUN git clone https://byran@bitbucket.org/byran/cppbdd.git
WORKDIR /usr/src/cppbdd
RUN git checkout -b cyber-dojo origin/cyber-dojo
RUN cyber-dojo/install

