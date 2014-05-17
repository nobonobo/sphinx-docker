# docker build -t nobonobo/ubuntu14.04 .

FROM ubuntu:14.04

MAINTAINER Noboru Irieda "irieda@gmail.com"

ENV DEBIAN_FRONTEND noninteractive
RUN	sed -i 's/\/archive.ubuntu.com/\/jp.archive.ubuntu.com/g' /etc/apt/sources.list \
	&& apt-get update \
	&& apt-get upgrade -y -q
RUN	apt-get install -y -q openssh-server

RUN mkdir -p /var/run/sshd
RUN sed -ri 's/UsePAM yes/#UsePAM yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#UsePAM no/UsePAM no/g' /etc/ssh/sshd_config
RUN sed -ri 's/PermitRootLogin without-password/PermitRootLogin yes/g' /etc/ssh/sshd_config
RUN sed -ri 's/#AuthorizedKeysFile/AuthorizedKeysFile/g' /etc/ssh/sshd_config

EXPOSE 22
ENTRYPOINT ["/usr/sbin/sshd"]
CMD ["-D"]
