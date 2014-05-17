# docker build -t nobonobo/sphinx-texlive2013 .

FROM nobonobo/ubuntu14.04

MAINTAINER Noboru Irieda "irieda@gmail.com"

ENV DEBIAN_FRONTEND noninteractive

RUN	apt-get install -y -q make python-sphinx python-sphinxcontrib* language-pack-ja fonts-takao
RUN	apt-get install -y -q texlive-lang-cjk texlive-math-extra xdvik-ja dvipdfmx
