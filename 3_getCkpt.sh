#!/bin/bash

#  bash 2_getSmpt.sh  <spec06/spec17/gap>  <case/all>

PY_config=""

. ./configs.sh

if [ $1 == "spec06" ];then
    . ./config_spec06.sh $2
    PY_config=${PATH_TO_GEM5}/configs/example/spec2017i.py
elif [ $1 == "spec17" ];then
    . ./config_spec17.sh $2
    PY_config=${PATH_TO_GEM5}/configs/example/spec2017i.py
elif [ $1 == "gap" ];then
    . ./config_gap.sh $2
    PY_config=${PATH_TO_GEM5}/configs/example/se.py
fi


echo "============================================================="
echo "Benchmark       : $1 "
echo "Case            : $2 "
echo "Checkpoint Dir  : ${SE_OUT_DIR_CHECKPOINT}"
echo "============================================================="

cd $EXE_BASE_PATH

rm -rf ${SE_OUT_DIR_CHECKPOINT}

if [ $1 == "gap" ];then

#--debug-flags=FETCH_TAG
#--debug-flags=ARF_EX,APrefetcher
#-I 20000000 \
#gdb --args \

${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_CHECKPOINT} \
${PY_config} \
--cpu-type=NonCachingSimpleCPU \
--mem-type=SimpleMemory \
--mem-size=16GB \
--output=$OUTPUT_PATH \
--errout=$ERROR_PATH  \
--maxinsts=$max_inst \
--take-simpoint-checkpoint=${SE_simpoint_file_path},${SE_weight_file_path},${interval_length},${warmup_length} \
--checkpoint-dir=${SE_OUT_DIR_CHECKPOINT} \
-c ${SE_ELF_ROUTE} \
-o "${SE_INPUT_ROUTE}${OPTIONS}" 

else

${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_CHECKPOINT} \
${PY_config} \
--cpu-type=NonCachingSimpleCPU \
--mem-type=SimpleMemory \
--mem-size=16GB \
--output=$OUTPUT_PATH \
--errout=$ERROR_PATH  \
--maxinsts=$max_inst \
--take-simpoint-checkpoint=${SE_simpoint_file_path},${SE_weight_file_path},${interval_length},${warmup_length} \
--checkpoint-dir=${SE_OUT_DIR_CHECKPOINT} \
--benchmark=$target

fi


:<<!
if [ -z $SE_INPUT_ROUTE ];then

${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_CHECKPOINT} \
${PATH_TO_GEM5}/configs/example/se.py \
--cpu-type=NonCachingSimpleCPU \
--mem-type=SimpleMemory \
--mem-size=16GB \
--maxinsts=$max_inst \
--take-simpoint-checkpoint=${SE_simpoint_file_path},${SE_weight_file_path},${interval_length},${warmup_length} \
--checkpoint-dir=${SE_OUT_DIR_CHECKPOINT} \
#-c ${SE_ELF_ROUTE} \
#-o "${OPTIONS}"

else

${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_CHECKPOINT} \
${PATH_TO_GEM5}/configs/example/se.py \
--cpu-type=NonCachingSimpleCPU \
--mem-type=SimpleMemory \
--mem-size=16GB \
--maxinsts=$max_inst \
--take-simpoint-checkpoint=${SE_simpoint_file_path},${SE_weight_file_path},${interval_length},${warmup_length} \
--checkpoint-dir=${SE_OUT_DIR_CHECKPOINT} \
#-c ${SE_ELF_ROUTE} \
#-i ${SE_INPUT_ROUTE} \
#-o "${OPTIONS}"

fi


!


