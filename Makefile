# Installation path for executables
LOCAL_DIR := $(PWD)/local
# Local programs should have higher path priority than system-installed programs
export PATH := $(LOCAL_DIR)/bin:$(PATH)

# Allow specifying the number of jobs for toolchain build for systems that need it.
# Due to different build systems used in the toolchain build, just `make -j` won't work here.
# Note: Plugin build uses `$(MAKE)` to inherit `-j` argument from command line.
ifdef JOBS
export JOBS := $(JOBS)
else
# If `JOBS` is not specified, default to max number of jobs.
export JOBS :=
endif

WGET := wget -c
UNTAR := tar -x -f
UNZIP := unzip

CPPCHECK_VERSION := 2.16.0
cppcheck := $(LOCAL_DIR)/cppcheck/bin/cppcheck
cppcheck: $(cppcheck)
$(cppcheck):
	$(WGET) "https://github.com/danmar/cppcheck/archive/refs/tags/$(CPPCHECK_VERSION).tar.gz"
	$(UNTAR) $(CPPCHECK_VERSION).tar.gz
	cd cppcheck-$(CPPCHECK_VERSION) && mkdir build
	cd cppcheck-$(CPPCHECK_VERSION)/build \
		&& cmake .. \
		-DUSE_MATCHCOMPILER=On \
		-DUSE_THREADS=On \
		-DCMAKE_INSTALL_PREFIX=$(LOCAL_DIR)/cppcheck \
		&& cmake --build . -j \
		&& cmake --install .
	rm $(CPPCHECK_VERSION).tar.gz
	rm -rf cppcheck-$(CPPCHECK_VERSION)

# Docker helpers

dep-ubuntu:
	sudo apt-get install --no-install-recommends \
		ca-certificates \
		git \
		build-essential \
		autoconf \
		automake \
		bison \
		flex \
		gawk \
		libtool-bin \
		libncurses5-dev \
		unzip \
		zip \
		jq \
		libgl-dev \
		libglu-dev \
		git \
		wget \
		curl \
		cmake \
		nasm \
		xz-utils \
		file \
		python3 \
		libxml2-dev \
		libssl-dev \
		texinfo \
		help2man \
		libz-dev \
		rsync \
		xxd \
		perl \
		coreutils \
		zstd \
		markdown \
		libarchive-tools \
		gettext \
		libgmp-dev \
		libmpfr-dev

.NOTPARALLEL: