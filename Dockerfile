FROM --platform=$TARGETOS/$TARGETARCH ubuntu:24.04

LABEL author="ag hosting s.r.o" maintainer="manager@avaloncs.net"
LABEL org.opencontainers.image.source="https://github.com/AvalonCS/docker-ubuntu"
LABEL org.opencontainers.image.licenses=MIT

ENV DEBIAN_FRONTEND=noninteractive \
    RUNNER_ALLOW_RUNASROOT=1

# Base update + deps (yolk + runner)
RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y --no-install-recommends \
    ca-certificates curl tar git jq unzip xz-utils \
    gcc g++ gdb libc6 binutils cabextract \
    wget zip \
    iproute2 net-tools netcat-openbsd telnet \
    libatomic1 libstdc++6 libgcc-s1 zlib1g bzip2 liblzma5 \
    libsdl1.2debian libsdl2-2.0-0 libfontconfig1 \
    libicu-dev icu-devtools \
    libunwind8 libuuid1 \
    sqlite3 libsqlite3-dev libsqlite3-0 \
    libzip4 \
    ffmpeg \
    apt-transport-https init-system-helpers \
    libcurl4 \
    libssl-dev libssl3 \
    libkrb5-3 \
    libevent-dev \
    libmariadb-dev libmariadb-dev-compat \
    liblua5.1-0 libluajit-5.1-2 \
    libduktape207 libjsoncpp-dev libleveldb1d \
    libncurses6 libncursesw6 \
    locales \
    tini \
 && rm -rf /var/lib/apt/lists/*

# Locale (como el primero)
RUN update-locale LANG=en_US.UTF-8 \
 && dpkg-reconfigure --frontend noninteractive locales

# Workdir (sin usuario container)
RUN mkdir -p /home/container
WORKDIR /home/container

STOPSIGNAL SIGINT

COPY ./entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/usr/bin/tini", "-g", "--"]
CMD ["/entrypoint.sh"]
