FROM debian:jessie
LABEL maintainer="HUREAU Olivier <Olivier.Hureau@etu.univ-grenoble-alpes.fr>"
ENV \
    	INITSYSTEM on \
    	DEBIAN_FRONTEND=noninteractive
# Basic build-time metadata as defined at http://label-schema.org
ARG BUILD_DATE
ARG VCS_REF
LABEL org.label-schema.build-date=$BUILD_DATE \
    	org.label-schema.docker.dockerfile="/Dockerfile" \
    	org.label-schema.name="drakkar-cert-env-build"

#--------------Install basepackages--------------# 
RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get  -y install \
gcc \
make \
build-essential \
gdb \
wget \
nano \
valgrind \
&& apt-get clean  \
&& rm -rf /var/lib/apt/lists/ */tmp/* /var/tmp/*

# -- INSTALL AFL -- #
RUN mkdir /SoftwareSecurity \
&& cd /SoftwareSecurity \
&& wget http://lcamtuf.coredump.cx/afl/releases/afl-latest.tgz \
&& tar zxvf afl-latest.tgz \
&& rm afl-latest.tgz \
&& cd afl-2.52b \
&& make

