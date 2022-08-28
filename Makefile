TOP ?= $(shell git rev-parse --show-toplevel)

export PARSECDIR := $(TOP)
export PATH := $(TOP)/bin:$(PATH)
export MANPATH := $(TOP)/man:$(MANPATH)

SPLASH = splash2 splash2x
SUITES = blackscholes bodytrack canneal dedup facesim ferret fluidanimate freqmine raytrace streamcluster swaptions vips x264 netdedup netferret netstreamcluster splash2 splash2x 

env:
	export PARSECDIR="$(TOP)"
	export PATH="$(TOP)/bin:$(PATH)"
	export MANPATH="$(TOP)/man:$(MANPATH)"

build:
	parsecmgmt -a build

build_all: $(addprefix build_,$(SUITES)) 
	echo "done"
	
#parsecmgmt -a build

build_%: 
	parsecmgmt -a build -p $*
	
run:
	parsecmgmt -a run

clean:
	parsecmgmt -a clean

fullclean:
	parsecmgmt -a fullclean
