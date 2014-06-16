FROM debian:squeeze
MAINTAINER Junji Hashimoto "junji.hashimoto@gree.net"

RUN apt-get -y update
RUN apt-get -y install curl sudo vim-tiny adduser
RUN echo 'echo "%admin ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers ' | sudo su
RUN echo 'echo "%gree ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers ' | sudo su
RUN adduser --disabled-password admin
RUN adduser admin sudo
RUN adduser --disabled-password gree
RUN adduser gree sudo
RUN mkdir -p /home/gree/builds

RUN echo "echo deb http://apt.in.gree.jp/ squeeze main contrib non-free proprietary >> /etc/apt/sources.list " | sudo su

RUN apt-get -y --force-yes install locales
RUN echo "echo en_US.UTF-8 UTF-8 >> /etc/locale.gen"  | sudo su
RUN echo "echo ja_JP.UTF-8 UTF-8 >> /etc/locale.gen"  | sudo su
RUN dpkg-reconfigure --frontend=noninteractive locales
RUN echo "echo LANG=en_US.UTF-8 >> /etc/default/locale"  | sudo su
RUN echo "source /etc/default/locale" >> /etc/profile  | sudo su

RUN apt-get -y --force-yes install libboost-all-dev
RUN apt-get -y --force-yes install zlib1g
RUN apt-get -y --force-yes install libncursesw5
RUN apt-get -y --force-yes install libhashkit2
RUN apt-get -y --force-yes install libtokyocabinet
RUN apt-get -y --force-yes install libkyotocabinet
RUN apt-get -y --force-yes install uuid-runtime

RUN apt-get -y --force-yes install libsqlite3
RUN apt-get -y --force-yes install libncurses5
RUN apt-get -y --force-yes install libcurl4-openssl

ADD debs /tmp/packages
RUN dpkg -i /tmp/packages/libzookeeper-mt*.deb

RUN apt-get -y --force-yes install make
ADD . /tmp/dist
RUN cd /tmp/dist && make install 
