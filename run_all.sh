#!/bin/bash


#  $1 = gap / spec06 / spec17 / ...

#==================---  benchmark  ---================
benchmark=""
if [ $1 == "spec06" ];then
    benchmark="perlbench bzip2 gcc mcf gobmk hmmer sjeng astar libquantum h264ref omnetpp xalancbmk"
elif [ $1 == "spec17" ];then
    #benchmark="perlbench_s gcc_s mcf_s omnetpp_s xalancbmk_s x264_s deepsjeng_s leela_s exchange2_s xz_s"
    benchmark="505 531 541 557"
elif [ $1 == "gap" ];then
    benchmark="bc  bfs  cc  cc_sv  converter  pr  pr_spmv    sssp  tc"
fi


for test in $benchmark 
do {
#=================   profile   ==================
    bash 1_getInit.sh $1 $test

    echo ""
    echo "=============="
    echo "benchmark: $1  case: $test Init Finished!!!"
    echo "=============="
    echo ""
#===============   get simpoint   ================
    bash 2_getSmpt.sh $1 $test

    echo ""
    echo "=============="
    echo "benchmark: $1  case: $test simpoint Finished!!!"
    echo "=============="
    echo ""
 #===============take checkpoint===================   
    bash 3_getCkpt.sh $1 $test

    echo ""
    echo "=============="
    echo "benchmark: $1  case: $test checkpoint Finished!!!"
    echo "=============="
    echo "" 
  #===============take checkpoint===================   
    bash 4_getRestore.sh $1 $test

    echo ""
    echo "=============="
    echo "benchmark: $1  case: $test Restore Finished!!!"
    echo "=============="
    echo "" 
} &
done
wait




:<<!
for test in $benchmark
do
    bash 1_getInit.sh $1 $test 
done

wait


echo ""
echo "=============="
echo "Init Finished!"
echo "=============="
echo ""


# -----------------Init Finished!------------------
for test in $benchmark
do

    bash 2_getSmpt.sh $1 $test &
    #bash getCkpt.sh $test &
done

wait
echo ""
echo "=============="
echo "Simpoint Finished!"
echo "=============="
echo ""
# -----------------Simpoint Finished!------------------

:<<!
for test in $benchmark
do
    #bash simInit.sh $test &
    #bash getSimpoint.sh $test &
    bash getCkpt.sh $test &
done

wait
echo ""
echo "=============="
echo "Checkpoint Finished!"
echo "=============="
echo ""
# -----------------Checkpoint Finished!------------------

for test in $benchmark
do
    #bash simInit.sh $test &
    #bash getSimpoint.sh $test &
    bash simRestore.sh $test &
done

wait
echo ""
echo "=============="
echo "Restore Finished!"
echo "=============="
echo ""
# -----------------Restore Finished!------------------



for test in $benchmark
do
    bash runGem5.sh $test &
done

wait
echo ""
echo "=============="
echo "runGem5 Finished!"
echo "=============="
echo ""
# -----------------Init Finished!------------------


for test in $benchmark
do
    arm-linux-gnueabihf-objdump -d ../$test > ../dmpNew/${test}.dmp
done

wait
echo ""
echo "=============="
echo "dump Finished!"
echo "=============="
echo ""

!