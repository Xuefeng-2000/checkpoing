for file in "./*"
do

for case in $file
do


if test -f $case ;then
    if [ ! $case = "test" ] ;then 
         git add $case
    fi
fi

done

done
