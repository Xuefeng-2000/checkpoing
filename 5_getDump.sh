#!/bin/bash

#  bash 2_getSmpt.sh  <spec06/spec17/gap>  <case/all>

. ./configs.sh

if [ $1 == "spec06" ];then
    . ./config_spec06.sh $2
elif [ $1 == "spec17" ];then
    . ./config_spec17.sh $2
elif [ $1 == "gap" ];then
    . ./config_gap.sh $2
fi

echo "============================================================="
echo "Benchmark     : $1 "
echo "Case          : $2 "
echo "Exec Dir      : ${SE_ELF_ROUTE}"
echo "============================================================="


cd $PATH_TO_GEM5

arm-linux-gnueabihf-objdump -d $EXE_BASE_PATH/$EXE > ${SE_OUT_DIR_BASE}/$2.dmp
