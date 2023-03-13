#!/bin/bash


############------ Result PATH  -----##########
scalar=19  # 2^scalar
loop=300
interval_length=100000000  #50M
warmup_length=5000000



EXE_BASE_PATH=/data/zxf/benchmark/gap/gapbs/bin
OUT_BASE_PATH=/data/zxf/checkpoint/gap
PATH_TO_GEM5=/data/zxf/gem5/gem5-stable

#Four crucial dir
SE_OUT_DIR_BASE=${OUT_BASE_PATH}/$1
SE_OUT_DIR_INIT=${OUT_BASE_PATH}/$1/bbv_${scalar}
SE_OUT_DIR_CHECKPOINT=${OUT_BASE_PATH}/$1/ckpt_${scalar}
SE_OUT_DIR_RELOAD=${OUT_BASE_PATH}/$1/restore_${scalar}
SE_OUT_DIR_RELOAD_PROF=${OUT_BASE_PATH}/${1}/prof_${scalar}
SE_OUT_DIR_SIMPOINT=${OUT_BASE_PATH}/$1/simpoint_${scalar}
SE_Simpoint_PATH=${OUT_BASE_PATH}/${1}/simpoint_${scalar}


#simpoint and weight
SE_simpoint_file_path=${SE_Simpoint_PATH}/simpoints
SE_weight_file_path=${SE_Simpoint_PATH}/weights


#output and error file 
OUTPUT_PATH=${OUT_BASE_PATH}/$1/${1}_${scalar}.out
ERROR_PATH=${OUT_BASE_PATH}/$1/${1}_${scalar}.err

############------  executable file  -----##########
# update!

SE_ELF_ROUTE=${EXE_BASE_PATH}/$1
SE_INPUT_ROUTE=""
OPTIONS=" -g ${scalar} -n 300"


#special case : converter

out1=${OUT_BASE_PATH}/$1/${1}_${scalar}.out1
out2=${OUT_BASE_PATH}/$1/${1}_${scalar}.out2
out3=${OUT_BASE_PATH}/$1/${1}_${scalar}.out3

if [ $1 == "converter" ];then
    OPTIONS=" -g ${scalar}  -e $out2  "
fi

############==========--------===========############

