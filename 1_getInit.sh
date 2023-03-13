#!/bin/bash

#  bash getInit.sh  <spec06/spec17/gap>  <case/all>

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
echo "Benchmark: $1 "
echo "Case     : $2 "
echo "Init Dir : ${SE_OUT_DIR_INIT}"
echo "============================================================="

cd $EXE_BASE_PATH

rm -r ${SE_OUT_DIR_INIT}

pwd

if [ $1 == "gap" ];then

#--debug-flags=FETCH_TAG
#--debug-flags=ARF_EX,APrefetcher
#-I 20000000 \
#gdb --args \
${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_INIT} \
${PY_config} \
--cpu-type=NonCachingSimpleCPU \
--mem-type=SimpleMemory \
--mem-size=16GB \
--output=$OUTPUT_PATH \
--errout=$ERROR_PATH  \
-c ${SE_ELF_ROUTE} \
-o "${SE_INPUT_ROUTE}${OPTIONS}" \
--simpoint-profile \
--simpoint-interval ${interval_length} 



else
#gdb --args \
${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_INIT} \
${PY_config} \
--cpu-type=NonCachingSimpleCPU \
--mem-type=SimpleMemory \
--mem-size=16GB \
--output=$OUTPUT_PATH \
--errout=$ERROR_PATH  \
--benchmark=$target     \
--simpoint-profile \
--simpoint-interval ${interval_length} 

fi


:<<!
if [ -z $SE_INPUT_ROUTE ];then
    ${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_INIT} \
    ${PY_config} \
    --cpu-type=NonCachingSimpleCPU \
    --mem-type=SimpleMemory \
    --mem-size=16GB \
    --output=$OUTPUT_PATH \
    --errout=$ERROR_PATH  \
    --benchmark=$target     \
    --simpoint-profile \
    --simpoint-interval ${interval_length} 
    
    #-c ${SE_ELF_ROUTE} \
    #-o "${OPTIONS}"
else
    ${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${SE_OUT_DIR_INIT} \
    ${PATH_TO_GEM5}/configs/example/se.py \
    --cpu-type=NonCachingSimpleCPU \
    --mem-type=SimpleMemory \
    --mem-size=16GB \
    --simpoint-profile \
    --simpoint-interval ${interval_length} \
    --output=$OUTPUT_PATH \
    --errout=$ERROR_PATH \
#    -c ${SE_ELF_ROUTE} \
#    -i ${SE_INPUT_ROUTE} \
#    -o "${OPTIONS}"
fi

!