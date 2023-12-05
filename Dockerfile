FROM amd64/debian:bookworm-slim

RUN apt update; apt install -y --no-install-recommends gpg rsync debhelper bc \
    fakeroot build-essential git wget openssl libssl-dev cpio libelf-dev kmod \
    ca-certificates libncurses-dev zstd xz-utils flex python3 bison pahole 

RUN wget -qO - https://download.opensuse.org/repositories/home:/frd/Debian_12/Release.key | \
    gpg --dearmor -o /usr/share/keyrings/frd-archive-keyring.gpg

RUN echo 'deb [signed-by=/usr/share/keyrings/frd-archive-keyring.gpg] https://download.opensuse.org/repositories/home:/frd/Debian_12/ /' | \
    tee /etc/apt/sources.list.d/frd-release.list

RUN apt update; apt install -y gcc-13

RUN git clone --depth 1 --branch 6.6.3-xanmod1 \
    https://github.com/xanmod/linux

WORKDIR linux

RUN rm localversion

ENV KCONFIG_CONFIG=/linux/config/.config
	
CMD make -j32 CC=gcc-13 HOSTCC=gcc-13 KDEB_PKGVERSION=1 LOCALVERSION=-xm bindeb-pkg; cp ../linux-* /assets/
