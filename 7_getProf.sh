#!/bin/bash
# bash 7_.sh spec06 astar ckpt_id


. ./configs.sh

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
    PY_config=/data/zxf/gem5/gem5-new/configs/example/se.py
fi

echo "============================================================="
echo "Benchmark       : $1 "
echo "Case            : $2 "
echo "Restore Dir     : ${SE_OUT_DIR_RELOAD}"
echo "============================================================="




PATH_TO_GEM5=/data/zxf/gem5/gem5-new
cd $PATH_TO_GEM5
METHOD=fast

O3PipeViewDir=/data/zxf/checkpoint/trace.out

outDir=/data/zxf/checkpoint/log/cc_19  #outDir 
oriDir=/data/zxf/checkpoint/log/tc_o
#====================================  Restore ==============================================

if [ $1 == "gap" ];then

############## Print O3pipe
#--debug-flags=O3PipeView
#bash 7_getProf.sh gap tc 3 4 6 >trace.out
#/data/zxf/gem5/gem5-new/util/o3-pipeview.py -c 1000 -o pipeview.out  --color trace.out
#less -r pipeview.out

#--debug-flags=FETCH_TAG
#-I 20000000 \
#-d ${oriDir}
#gdb --args \
${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} \
$PY_config \
--prefDepth $4 \
--cmpDepth $5 \
--cpu-type O3CPU \
--cpu-clock 1GHz \
--num-cpu 1 \
--l1d-hwp-type=BOPPrefetcher \
${CACHE_PRAM} \
${MEM_PRAM} \
--restore-simpoint-checkpoint -r $3 --checkpoint-dir $SE_OUT_DIR_CHECKPOINT \
-c ${SE_ELF_ROUTE} \
-o "${SE_INPUT_ROUTE}${OPTIONS}"

else
# 
#--debug-flags=ARF_EX
#-I 20000000 \
#gdb --args \
${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD}  \
$PY_config \
--cpu-type O3CPU \
--cpu-clock 1GHz \
--num-cpu 1 \
--l1d-hwp-type=BOPPrefetcher \
${CACHE_PRAM} \
${MEM_PRAM} \
--restore-simpoint-checkpoint -r $3 --checkpoint-dir $SE_OUT_DIR_CHECKPOINT \
--benchmark=$target #> ${outdir}/BPMiss_log.txt  #update log pathh


fi



:<<!
#=========  execute ===========
if [ -z $SE_INPUT_ROUTE ];then

${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${outdir} \
${PATH_TO_GEM5}/configs/example/se.py \
--cpu-type O3CPU \
--cpu-clock 1GHz \
--num-cpu 1 \
--l1d-hwp-type=BOPPrefetcher \
${CACHE_PRAM} \
${MEM_PRAM} \
--restore-simpoint-checkpoint -r $i --checkpoint-dir $SE_OUT_DIR_CHECKPOINT \
-c ${SE_ELF_ROUTE} \
-o "${SE_INPUT_ROUTE}${OPTIONS}" > ${outdir}/BPMiss_log.txt  #update log pathh


# ${SE_OUT_DIR_RELOAD}/${2}_ckp_${i} 
else

${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${outdir} \
${PATH_TO_GEM5}/configs/example/se.py \
--cpu-type O3CPU \
--cpu-clock 1GHz \
--num-cpu 1 \
${CACHE_PRAM} \
${MEM_PRAM} \
--l1d-hwp-type=BOPPrefetcher \
--restore-simpoint-checkpoint -r $i --checkpoint-dir $SE_OUT_DIR_CHECKPOINT \
-i ${SE_INPUT_ROUTE} \
-c ${SE_ELF_ROUTE} \
-o "${OPTIONS}" > ${outdir}/BPMiss_log.txt

fi

 



#> $ansLog
# e {AtomicSimpleCPU,BEU,DerivO3CPU,MinorCPU,NonCachingSimpleCPU,O3CPU,TimingSimpleCPU,TraceCPU,HPI,O3_ARM_v7a_3,ex5_LITTLE,ex5_big}]


!