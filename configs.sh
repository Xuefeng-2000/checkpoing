#!/bin/bash


############==========CPU Info===========############
CPU_PARM=\
"--cpu-type NonCachingSimpleCPU \
--cpu-clock 1GHz \
--num-cpu 1"

CACHE_PRAM=\
"--caches --l2cache --l1i_size 32kB \
--l1d_size 32kB --l2_size 1MB \
--l1i_assoc 8 --l1d_assoc 8 \
--l2_assoc 16 --cacheline_size 64"

MEM_PRAM=\
"--mem-type DDR3_2133_8x8 --mem-size 16GB"

############==========Sim Info===========############
# update!
ARCH=ARM
METHOD=fast
max_inst=900000000000

