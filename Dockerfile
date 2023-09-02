FROM debian:bookworm

LABEL org.opencontainers.image.source=https://github.com/omghaxzs/wine-base

ENV DEBIAN_FRONTEND noninteractive

RUN echo deb http://deb.debian.org/debian bookworm contrib non-free\\n\
deb-src http://deb.debian.org/debian bookworm contrib non-free\\n\
deb http://deb.debian.org/debian-security/ bookworm-security contrib non-free\\n\
deb-src http://deb.debian.org/debian-security/ bookworm-security contrib non-free\\n\
deb http://deb.debian.org/debian bookworm-updates contrib non-free\\n\
deb-src http://deb.debian.org/debian bookworm-updates contrib non-free >> /etc/apt/sources.list

RUN apt-get update \
    && apt-get -y install wget software-properties-common \
    && dpkg --add-architecture i386 \
    && mkdir -pm755 /etc/apt/keyrings \
    && wget -O /etc/apt/keyrings/winehq-archive.key https://dl.winehq.org/wine-builds/winehq.key \
    && wget -NP /etc/apt/sources.list.d/ https://dl.winehq.org/wine-builds/debian/dists/bookworm/winehq-bookworm.sources \
    && apt-get update \
    && apt install -y --install-recommends winehq-stable

RUN echo steam steam/question select "I AGREE" | debconf-set-selections && \
    echo steam steam/license note '' | debconf-set-selections && \
    apt-get install -y steamcmd

#RUN addgroup --gid 1000 steam && \
#    adduser --system --home /home/steam --shell /bin/false --uid 1000 --ingroup steam steam && \
#    usermod -a -G tty steam && \
#    mkdir -m 777 /data && \
#    chown steam:steam /data /home/steam
#
#USER steam
