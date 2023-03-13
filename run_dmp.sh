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
    bash 5_getDump.sh $1 $test

    echo ""
    echo "=============="
    echo "benchmark: $1  case: $test Dump Finished!!!"
    echo "=============="
    echo "" 
} &
done
wait
