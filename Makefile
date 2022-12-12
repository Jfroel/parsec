TOP ?= $(shell git rev-parse --show-toplevel)

export PARSECDIR := $(TOP)
export PATH := $(TOP)/bin:$(PATH)
export MANPATH := $(TOP)/man:$(MANPATH)
INSTALL_DIR ?= $(TOP)/../../install
LOG_DIR ?=  $(TOP)/../../outputs
export EXT ?= riscv
ifeq ($(EXT),x86)
WORKING_BENCHMARKS = blackscholes bodytrack facesim ferret fluidanimate freqmine streamcluster swaptions vips canneal dedup raytrace
export TOOLCHAIN_PREFIX=
# check these paths, for most users this just needs to be "usr/"
export CC_DIR=
export UTIL_DIR=
export GNUTOOL_DIR=
# --------------
export EMULATOR=
export build_host=
else
WORKING_BENCHMARKS = blackscholes bodytrack facesim ferret fluidanimate freqmine streamcluster swaptions
export TOOLCHAIN_PREFIX=riscv64-unknown-linux-gnu-
# don't change
export CC_DIR=$(INSTALL_DIR)
export UTIL_DIR=$(INSTALL_DIR)
export GNUTOOL_DIR=
# --------------
export EMULATOR=$(INSTALL_DIR)/bin/qemu-riscv64 -L $(INSTALL_DIR)/sysroot
export build_host="--host=riscv64-unknown-linux-gnu"
endif

build:
	parsecmgmt -a build

build_benchmarks: $(addprefix build_,$(WORKING_BENCHMARKS)) 
	echo "done"

build_%: 
	parsecmgmt -a build -p $*

run_benchmarks: $(addprefix run_,$(WORKING_BENCHMARKS))
	echo "done"

run_%:
	parsecmgmt -a run -p $* 2>&1 | tee -i $(LOG_DIR)/parsec-$(EXT)-$*.log
	
%:
	parsecmgmt -a $@
