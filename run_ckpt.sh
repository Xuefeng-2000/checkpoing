#!/bin/bash


#  $1 = gap / spec06 / spec17 / ...

#==================---  benchmark  ---================
benchmark=""
if [ $1 == "spec06" ];then
    benchmark="perlbench bzip2 gcc mcf gobmk hmmer sjeng astar libquantum h264ref omnetpp xalancbmk"
elif [ $1 == "spec17" ];then
    benchmark=""
elif [ $1 == "gap" ];then
    benchmark="bc  bfs  cc  cc_sv  converter  pr  pr_spmv    sssp  tc"
fi


for test in $benchmark 
do {
 #===============take checkpoint===================   
    bash 3_getCkpt.sh $1 $test

    echo ""
    echo "=============="
    echo "benchmark: $1  case: $test checkpoint Finished!!!"
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