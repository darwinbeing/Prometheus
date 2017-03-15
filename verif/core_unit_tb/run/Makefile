MAKEFILE   := $(lastword $(MAKEFILE_LIST))
BENCH_HOME := $(dir $(lastword $(MAKEFILE_LIST)))..
TOP=core_tb_top


#include $(GIT_HOME)/IP/technology/TSMC28HPC/config.mk
include $(BENCH_HOME)/run/Makefile.unit


include $(BENCH_HOME)/run/Makefrag

build: analyze elaborate

draft_test:
	./simv +UVM_NO_RELNOTES +UVM_TESTNAME=draft_test $(SIM_OPTS) $(RUN_OPTS)



all:

