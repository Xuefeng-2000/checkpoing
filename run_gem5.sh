#!/bin/bash

#  bash getInit.sh  <spec06/spec17/gap>  <case/all>

. ./configs.sh

if [ $1 == "spec06" ];then
    . ./config_spec06.sh $2
elif [ $1 == "spec17" ];then
    . ./config_spec17.sh $2
elif [ $1 == "gap" ];then
    . ./config_gap.sh $2
fi



echo "============================================================="
echo "Benchmark: $1 "
echo "Case     : $2 "
echo "Init Dir : ${SE_OUT_DIR_INIT}"
echo "============================================================="

cd $EXE_BASE_PATH

rm -r ${SE_OUT_DIR_INIT}

pwd

#gdb --args \
${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} \
${PATH_TO_GEM5}/configs/example/spec2017.py \
--cpu-type=NonCachingSimpleCPU \
--mem-type=SimpleMemory \
--mem-size=16GB \
--benchmark=mcf_s 
