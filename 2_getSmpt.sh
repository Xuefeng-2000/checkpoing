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
echo "Simpoint Dir  : ${SE_OUT_DIR_INIT}"
echo "============================================================="


cd $PATH_TO_GEM5

PATH_TO_SIMPOINT=/data/zxf/tools/SimPoint.3.2/bin/simpoint



if [ ! -d $SE_Simpoint_PATH ];then
    mkdir $SE_Simpoint_PATH
fi

$PATH_TO_SIMPOINT -loadFVFile ${SE_OUT_DIR_INIT}/simpoint.bb.gz \
-maxK 30 -saveSimpoints ${SE_simpoint_file_path} \
-saveSimpointWeights ${SE_weight_file_path} \
-inputVectorsGzipped

