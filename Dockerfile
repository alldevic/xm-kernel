FROM debian:trixie-20240812-slim

RUN apt-get update; \
    apt-get install -y --no-install-recommends gpg rsync debhelper bc kmod \
    fakeroot build-essential git wget openssl libssl-dev cpio libelf-dev \
    ca-certificates libncurses-dev zstd xz-utils flex python3 bison pahole

WORKDIR /kernel/

RUN git clone --depth 1 --branch 6.10.6-xanmod1 \
https://github.com/xanmod/linux

WORKDIR /kernel/linux

ADD ./patches /kernel/patches
RUN for i in /kernel/patches/*.patch; do patch -p1 < $i; done

ENV KCONFIG_CONFIG=/kernel/linux/config/.config \
    CC=gcc-14 \
	HOSTCC=gcc-14 \
    LOCALVERSION=-xm

ADD ./make-bindeb-pkg.sh .

CMD ["./make-bindeb-pkg.sh"]
