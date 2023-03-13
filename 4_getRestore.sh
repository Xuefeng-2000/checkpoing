#!/bin/bash

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
    PY_config=${PATH_TO_GEM5}/configs/example/se.py
fi

echo "============================================================="
echo "Benchmark       : $1 "
echo "Case            : $2 "
echo "Restore Dir     : ${SE_OUT_DIR_RELOAD}"
echo "============================================================="

cd $EXE_BASE_PATH


if [ ! -d $SE_OUT_DIR_RELOAD ];then
        mkdir $SE_OUT_DIR_RELOAD
fi



rm -rf cd /datazx   checkpoint${SE_OUT_DIR_RELOAD}/*


times=$(ls ${SE_OUT_DIR_CHECKPOINT} | grep simpoint | wc -l)
echo $times


PATH_TO_GEM5=/data/zxf/gem5/gem5-new


OUT_DIR=$SE_OUT_DIR_RELOAD_PROF
#OUT_DIR=/data/zxf/checkpoint/log/L1_BOPP/${2}   #log 
#======================  Restore ==============================
for((i=1;i<=times;i++))
do

echo ${OUT_DIR}/${2}_ckp_${i} 
outdir=${OUT_DIR}/${2}_ckp_${i} 


#=========  clear outdir =========
if [ -d $outdir ];then
    rm -r $outdir
fi

if [ ! -d $SE_OUT_DIR_RELOAD_PROF ];then
    mkdir $SE_OUT_DIR_RELOAD_PROF
fi
if [ ! -d $outdir ];then
    mkdir $outdir
fi


if [ $1 == "gap" ];then

#--debug-flags=FETCH_TAG
#--debug-flags=ARF_EX,APrefetcher
#-I 20000000 \
#gdb --args \
${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${outdir} \
$PY_config \
--cpu-type O3CPU \
--cpu-clock 1GHz \
--num-cpu 1 \
--l1d-hwp-type=BOPPrefetcher \
${CACHE_PRAM} \
${MEM_PRAM} \
--restore-simpoint-checkpoint -r $i --checkpoint-dir $SE_OUT_DIR_CHECKPOINT \
-c ${SE_ELF_ROUTE} \
-o "${SE_INPUT_ROUTE}${OPTIONS}"  > ${outdir}/BPMiss_log.txt  #update log pathh

else
${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} --outdir=${outdir} \
$PY_config \
--cpu-type O3CPU \
--cpu-clock 1GHz \
--num-cpu 1 \
--l1d-hwp-type=BOPPrefetcher \
${CACHE_PRAM} \
${MEM_PRAM} \
--restore-simpoint-checkpoint -r $i --checkpoint-dir $SE_OUT_DIR_CHECKPOINT \
--benchmark=$target > ${outdir}/BPMiss_log.txt  #update log pathh
fi

done

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

 
done 



#> $ansLog
# e {AtomicSimpleCPU,BEU,DerivO3CPU,MinorCPU,NonCachingSimpleCPU,O3CPU,TimingSimpleCPU,TraceCPU,HPI,O3_ARM_v7a_3,ex5_LITTLE,ex5_big}]


!