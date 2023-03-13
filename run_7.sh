#!/bin/bash

# $3 = ckpt_ID      $4 = prefDepth    $5 = cmpDepth   
# 1 2 3 4 5 6 7 8 9 10
# 1 2 3 4 5 6 7 8 9 10


for((i=4;i<16;i++)) {
    for ((j=16;j>=12;j--))
    do
        bash 7_getProf.sh  gap cc 19 $i $j > ./log/cc_19/cc_19_${i}_${j}.log &
        sleep 5
    done

    wait

    for ((j=11;j>=8;j--))
    do
        bash 7_getProf.sh  gap cc 19 $i $j > ./log/cc_19/cc_19_${i}_${j}.log &
        sleep 5
    done

    wait

    for ((j=7;j>=4;j--))
    do
        bash 7_getProf.sh  gap cc 19 $i $j > ./log/cc_19/cc_19_${i}_${j}.log &
        sleep 5
    done

    wait

    for ((j=3;j>=2;j--))
    do
        bash 7_getProf.sh  gap cc 19 $i $j > ./log/cc_19/cc_19_${i}_${j}.log &
        sleep 5
    done

    wait
} 