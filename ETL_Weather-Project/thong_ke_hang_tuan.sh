#!/bin/bash

echo $(tail -7 ghi_nhan_do_chinh_xac.tsv | cut -f6) > dulieutuan.txt
week_fc=($(echo $(cat dulieutuan.txt)))

#xac thuc ket qua
for i in {0..6}; do
    echo ${week_fc[$i]}
done

for i in {0..6}; do
    if [[ ${week_fc[$i]} < 0 ]]
    then 
    week_fc[$i]=$(((-1)*week_fc[$i]))
    fi

    echo ${week_fc[$i]}
done

minimum=${week_fc[1]}
maximum=${week_fc[1]}

for item in ${week_fc[@]}; do
    if [[ $minimum > $item ]]
    then
     minimum=$item
    fi
    if [[ $maximum < $item ]]
    then
     maximum=$item
     fi
done

echo "minimum absolute error = $minimum"
echo "maximum absolute error = $maximum"
