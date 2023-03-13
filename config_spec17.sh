#!/bin/bash
echo $1
target=""
#**************************** benchmark name ************************************
if [ $1 = "500" -o $1 = "perlbench_r" -o $1 = "500.perlbench_r" ]; then
        target=500.perlbench_r 
elif [ $1 = "502" -o $1 = "gcc_r" -o $1 = "502.gcc_r" ]; then
        target=502.gcc_r 
elif  [ $1 = "505" -o $1 = "mcf_r" -o $1 = "505.mcf_r" ]; then
        target=505.mcf_r 
elif  [ $1 = "520" -o $1 = "omnetpp_r" -o $1 = "520.omnetpp_r" ]; then
        target=520.omnetpp_r 
elif  [ $1 = "523" -o $1 = "xalancbmk_r" -o $1 = "523.xalancbmk_r" ]; then
        target=523.xalancbmk_r 
elif  [ $1 = "525" -o $1 = "x264_r" -o $1 = "525.x264_r" ]; then
        target=525.x264_r 
elif  [ $1 = "531" -o $1 = "deepsjeng_r" -o $1 = "531.deepsjeng_r" ]; then
        target=531.deepsjeng_r 
elif  [ $1 = "541" -o $1 = "leela_r" -o $1 = "541.leela_r" ]; then
        target=541.leela_r 
elif  [ $1 = "548" -o $1 = "exchange2_r" -o $1 = "548.exchange2_r" ]; then
        target=548.exchange2_r 
elif  [ $1 = "557" -o $1 = "xz_r" -o $1 = "557.xz_r" ]; then
        target=557.xz_r 
elif  [ $1 = "600" -o $1 = "perlbench_s" -o $1 = "600.perlbench_s" ]; then
        target=600.perlbench_s 
elif  [ $1 = "602" -o $1 = "gcc_s" -o $1 = "602.gcc_s" ]; then
        target=602.gcc_s 
elif  [ $1 = "605" -o $1 = "mcf_s" -o $1 = "605.mcf_s" ]; then
        target=605.mcf_s 
elif  [ $1 = "620" -o $1 = "omnetpp_s" -o $1 = "620.omnetpp_s" ]; then
        target=620.omnetpp_s 
elif  [ $1 = "623" -o $1 = "xalancbmk_s" -o $1 = "623.xalancbmk_s" ]; then
        target=623.xalancbmk_s 
elif  [ $1 = "625" -o $1 = "x264_s" -o $1 = "625.x264_s" ]; then
        target=625.x264_s 
elif  [ $1 = "631" -o $1 = "deepsjeng_s" -o $1 = "631.deepsjeng_s" ]; then
        target=631.deepsjeng_s 
elif  [ $1 = "641" -o $1 = "leela_s" -o $1 = "641.leela_s" ]; then
        target=641.leela_s 
elif  [ $1 = "648" -o $1 = "exchange2_s" -o $1 = "648.exchange2_s" ]; then
        target=648.exchange2_s 
elif  [ $1 = "657" -o $1 = "xz_s" -o $1 = "657.xz_s" ]; then
        target=657.xz_s
else
	echo "input wrong!111"
	exit
fi


#  .sh    benchmark    ref/test 0-1-2 
#. ./config_spec17_input.sh $target 1

case_name=${target:4}
#echo $case_name
if  [ $1 = "483" -o $1 = "xalancbmk" -o $1 = "483.xalancbmk" ]; then
    case_name=Xalan
fi
EXE=${case_name}_base.mytest-64

#========================================================
EXE_BASE_PATH=/data/zxf/checkpoint/spec2017/execDir/${target}
OUT_BASE_PATH=/data/zxf/checkpoint/spec2017
if [ ! -d $OUT_BASE_PATH ];then
    mkdir $OUT_BASE_PATH
fi

PATH_TO_GEM5=/data/zxf/gem5/gem5-stable

#Four crucial dir
SE_OUT_DIR_BASE=${OUT_BASE_PATH}/$target
if [ ! -d $SE_OUT_DIR_BASE ];then
    mkdir $SE_OUT_DIR_BASE
fi


SE_OUT_DIR_INIT=${OUT_BASE_PATH}/${target}/bbv
SE_OUT_DIR_CHECKPOINT=${OUT_BASE_PATH}/${target}/ckpt
SE_OUT_DIR_RELOAD=${OUT_BASE_PATH}/${target}/restore
SE_OUT_DIR_RELOAD_PROF=${OUT_BASE_PATH}/${target}/prof
SE_OUT_DIR_SIMPOINT=${OUT_BASE_PATH}/${target}/simpoint
SE_Simpoint_PATH=${OUT_BASE_PATH}/${target}/simpoint


#simpoint and weight
SE_simpoint_file_path=${SE_Simpoint_PATH}/simpoints
SE_weight_file_path=${SE_Simpoint_PATH}/weights


#output and error file 
OUTPUT_PATH=${OUT_BASE_PATH}/${target}/$output
ERROR_PATH=${OUT_BASE_PATH}/${target}/$errout



############------  executable file  -----##########
# update!
interval_length=300000000  #300M
warmup_length=10000000  #10M

SE_ELF_ROUTE=$EXE
SE_INPUT_ROUTE=$input
OPTIONS=$args

############==========--------===========############

