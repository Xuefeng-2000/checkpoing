#!/bin/bash


#  $1 = gap / spec06 / spec17 / ...

#==================---  benchmark  ---================
benchmark=""

if [ $1 == "spec06" ];then
    benchmark="astar mcf bzip2 sjeng gobmk hmmer   libquantum h264ref omnetpp xalancbmk"
    #benchmark="mcf"
elif [ $1 == "spec17" ];then
    benchmark="505 541 557"
elif [ $1 == "gap" ];then
    benchmark="bc  bfs  cc  cc_sv  converter  pr  pr_spmv    sssp  tc"
fi



for test in $benchmark 
do {

. ./configs.sh

if [ $1 == "spec06" ];then
    . ./config_spec06.sh $test
    PY_config=${PATH_TO_GEM5}/configs/example/spec2017i.py
elif [ $1 == "spec17" ];then
    . ./config_spec17.sh $test
    PY_config=${PATH_TO_GEM5}/configs/example/spec2017i.py
elif [ $1 == "gap" ];then
    . ./config_gapTmp.sh $test
    PY_config=/data/zxf/gem5/gem5-new/configs/example/se.py
fi


outDir_perfix="/data/zxf/checkpoint/log/all_4_6"
outDir=""
if [ $1 == "spec06" ];then
    outDir=$outDir_perfix/spec06/$test
elif [ $1 == "spec17" ];then
    outDir=$outDir_perfix/spec17/$test
elif [ $1 == "gap" ];then
    outDir=$outDir_perfix/gap/$test
fi



if [ ! -d $outDir ];then
    mkdir $outDir
fi

 #===============take checkpoint===================  
times=$(ls ${SE_OUT_DIR_CHECKPOINT} | grep simpoint | wc -l)
echo $SE_OUT_DIR_CHECKPOINT
echo $test
echo $times

for((i=1;i<=times;i++))
    do 
    #bash  7_getProf.sh  $1 $test $i > $outDir/ckpt_$i]

#########
cd $EXE_BASE_PATH
PATH_TO_GEM5=/data/zxf/gem5/gem5-new
METHOD=fast



oriDir=${outDir}/ckpt_${i}

rm -rf $oriDir

if [ ! -d $oriDir ];then
    mkdir $oriDir
fi


if [ $1 == "gap" ];then

#original don't  prefetch , so twoDepth = -1 

${PATH_TO_GEM5}/build/${ARCH}/gem5.${METHOD} -d ${oriDir}  \
$PY_config \
--prefDepth 4 \
--cmpDepth 6 \
--cpu-type O3CPU \
--cpu-clock 1GHz \
--num-cpu 1 \
--l1d-hwp-type=BOPPrefetcher \
${CACHE_PRAM} \
${MEM_PRAM} \
--restore-simpoint-checkpoint -r $i --checkpoint-dir $SE_OUT_DIR_CHECKPOINT \
-c ${SE_ELF_ROUTE} \
-o "${SE_INPUT_ROUTE}${OPTIONS}" > ${oriDir}/MissInfo.txt


fi

#########


    echo ""
    echo "=============="
    echo "benchmark: $1  case: $test profile Finished!!!"
    echo "=============="
    echo "" 
done

} &
done
wait
