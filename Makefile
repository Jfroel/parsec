TOP ?= $(shell git rev-parse --show-toplevel)

export PARSECDIR := $(TOP)
export PATH := $(TOP)/bin:$(PATH)
export MANPATH := $(TOP)/man:$(MANPATH)
INSTALL_DIR ?= $(TOP)/../../install
export EXT ?= riscv
ifeq ($(EXT),x86)
WORKING_SUITES = blackscholes bodytrack facesim ferret fluidanimate freqmine streamcluster swaptions vips canneal dedup raytrace
export TOOLCHAIN_PREFIX=
# check these paths, for most users this just needs to be "usr/"
export CC_DIR=
export UTIL_DIR=
export GNUTOOL_DIR=
# --------------
export EMULATOR=
export build_host=
else
WORKING_SUITES = blackscholes bodytrack facesim ferret fluidanimate freqmine streamcluster swaptions
export TOOLCHAIN_PREFIX=riscv64-unknown-linux-gnu-
# don't change
export CC_DIR=$(INSTALL_DIR)
export UTIL_DIR=$(INSTALL_DIR)
export GNUTOOL_DIR=
# --------------
export EMULATOR=$(INSTALL_DIR)/bin/qemu-riscv64 -L $(INSTALL_DIR)/sysroot
export build_host="--host=riscv64-unknown-linux-gnu"
endif

RISCV_WORKING_SUITES = blackscholes bodytrack facesim ferret fluidanimate freqmine streamcluster swaptions

build:
	parsecmgmt -a build

build_suites: $(addprefix build_,$(WORKING_SUITES)) 
	echo "done"

build_%: 
	parsecmgmt -a build -p $*

run_suites: $(addprefix run_,$(WORKING_SUITES))
	echo "done"

run_%:
	parsecmgmt -a run -p $*
	
%:
	parsecmgmt -a $@
