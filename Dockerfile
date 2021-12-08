FROM ubuntu

MAINTAINER Torsten Bronger <bronger@physik.rwth-aachen.de>

ARG TERM=linux
ARG DEBIAN_FRONTEND=noninteractive

COPY entrypoint.sh /

ENV LOAD_MAX=2
ENV TIMEOUT_SEC_MIN=500
ENV TIMEOUT_SEC_MAX=700
ENV START_JITTER_SEC=20
ENV UPTIME_SEC_MAX=

ENTRYPOINT ["/entrypoint.sh"]
