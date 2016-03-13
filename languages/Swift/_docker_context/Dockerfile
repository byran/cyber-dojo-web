FROM       cyberdojofoundation/build-essential
MAINTAINER Byran Wills-Heath <byran@adgico.co.uk>

COPY swift-DEVELOPMENT-SNAPSHOT-2016-03-01-a-ubuntu14.04.tar.gz .
ADD install.sh .

RUN ./install.sh && \
    rm -f install.sh
