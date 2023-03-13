#!/bin/bash

target=""
#**************************** benchmark name ************************************
if [ $1 = "400" -o $1 = "perlbench" -o $1 = "400.perlbench" ]; then
	target="400.perlbench"
elif  [ $1 = "401" -o $1 = "bzip2" -o $1 = "401.bzip2" ]; then
	target="401.bzip2"
elif  [ $1 = "403" -o $1 = "gcc" -o $1 = "403.gcc" ]; then
	target="403.gcc"
elif  [ $1 = "429" -o $1 = "mcf" -o $1 = "429.mcf" ]; then
	target="429.mcf"
elif  [ $1 = "445" -o $1 = "gobmk" -o $1 = "445.gobmk" ]; then
	target="445.gobmk"
elif  [ $1 = "456" -o $1 = "hmmer" -o $1 = "456.hmmer" ]; then
	target="456.hmmer"
elif  [ $1 = "458" -o $1 = "sjeng" -o $1 = "458.sjeng" ]; then
	target="458.sjeng"
elif  [ $1 = "462" -o $1 = "libquantum" -o $1 = "462.libquantum" ]; then
	target="462.libquantum"
elif  [ $1 = "464" -o $1 = "h264ref" -o $1 = "464.h264ref" ]; then
	target="464.h264ref"
elif  [ $1 = "471" -o $1 = "omnetpp" -o $1 = "471.omnetpp" ]; then
	target="471.omnetpp"
elif  [ $1 = "473" -o $1 = "astar" -o $1 = "473.astar" ]; then
	target="473.astar"
elif  [ $1 = "483" -o $1 = "xalancbmk" -o $1 = "483.xalancbmk" ]; then
	target="483.xalancbmk"
else
	echo "input wrong!06"
	exit
fi
#  .sh    benchmark    ref/test 0-1-2 
#. ./config_spec06_input.sh $target 1

case_name=${target:4}
#echo $case_name
if  [ $1 = "483" -o $1 = "xalancbmk" -o $1 = "483.xalancbmk" ]; then
    case_name=Xalan
fi
EXE=${case_name}_base.gcc41-64bit

#========================================================
EXE_BASE_PATH=/data/zxf/checkpoint/spec2006/execDir/${target}
OUT_BASE_PATH=/data/zxf/checkpoint/spec2006
if [ ! -d $OUT_BASE_PATH ];then
    mkdir $OUT_BASE_PATH
fi

PATH_TO_GEM5=/data/zxf/gem5/gem5-stable

#Four crucial dir
SE_OUT_DIR_BASE=${OUT_BASE_PATH}/$target
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

