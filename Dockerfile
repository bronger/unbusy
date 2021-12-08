FROM ubuntu

MAINTAINER Torsten Bronger <bronger@physik.rwth-aachen.de>

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

COPY entrypoint.sh /

ENTRYPOINT ["/entrypoint.sh"]
