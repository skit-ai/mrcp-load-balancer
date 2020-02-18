FROM ubuntu:16.04

RUN apt-get update

RUN apt-get install -y wget gcc make perl libdbi-perl libdbd-pg-perl \
    libfrontier-rpc-perl libterm-readline-gnu-perl libberkeleydb-perl \
    ncurses-dev apt-utils libssl-dev build-essential openssl bison flex \
    pkg-config vim

WORKDIR /usr/src/

RUN wget https://opensips.org/pub/opensips/2.4.7/opensips-2.4.7.tar.gz

RUN tar -xvzf opensips-2.4.7.tar.gz
WORKDIR /usr/src/opensips-2.4.7

RUN make all
RUN make install

COPY . /usr/src/opensips-2.4.7/

EXPOSE 9060

CMD ["./opensips", "-F", "-f", "configs/opensips.cfg"]

