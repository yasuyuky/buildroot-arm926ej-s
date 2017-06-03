FROM ubuntu:latest

RUN apt-get -y update
RUN apt-get -y install bzip2 bc cpio g++ make patch perl python unzip rsync wget

RUN mkdir -p /opt
WORKDIR /opt

# Download buildroot
ENV BR_VER 2017.02.1
ENV BR_DIR buildroot-${BR_VER}
ENV BR_TAR ${BR_DIR}.tar.bz2
ENV BR_URL https://buildroot.org/downloads/${BR_TAR}
RUN echo ${BR_DIR} && wget ${BR_URL} && ls -l && tar xf ${BR_TAR} && rm -f ${BR_TAR}
RUN ln -s ${BR_DIR} buildroot

WORKDIR /opt/buildroot
COPY .config .config
RUN make
