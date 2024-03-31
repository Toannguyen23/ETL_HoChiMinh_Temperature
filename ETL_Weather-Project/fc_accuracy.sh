#!/bin/bash

#dua vao file nhatky.log, ta se tien hanh ghi nhan cac gia tri nhiet do hom qua de so sanh va doi chieu nhiet do hom nay
yesterday_fc=$(tail -2 nhatky.log | head -1 | cut -d " " -f5)
#trich xuat du lieu nhiet do hien tai tien hanh tinh toan chenh lech
today_fc=$(tail -1 nhatky.log | cut -d " " -f4)
do_chinh_xac=$(($yesterday_fc - $today_fc))

echo "Độ chính xác hiện tại là: $do_chinh_xac"

#thiet lap dieu kien de tinh toan ve do chinh xac ve du lieu thoi tiet 
#+/-1 deg se gan la exellent
#+/-2 deg se gan la good
#+/-3 se gan la fair
# va cuoi cung +/-4 se gan la poor

if [ -1 -le $do_chinh_xac ] && [ $do_chinh_xac -le 1 ]
then
    pham_vi_chinh_xac=exellent
elif [ -2 -le $do_chinh_xac ] && [ $do_chinh_xac -le 2 ]
then
    pham_vi_chinh_xac=good
elif [ -3 -le $do_chinh_xac ] && [ $do_chinh_xac -le 3 ]
then 
    pham_vi_chinh_xac=fair
else
    pham_vi_chinh_xac=poor
fi
#tien hanh gan cac gia tri tu file nhatky.log vao file ghi_nhan_do_chinh_xac.tsv
row=$(tail -1 nhatky.log)
year=$(echo $row | cut -d " " -f1)
month=$(echo $row | cut -d " " -f2)
day=$(echo $row | cut -d " " -f3)
echo -e "$year\t$month\t$day\t$today_fc\t$yesterday_fc\t$do_chinh_xac\t$pham_vi_chinh_xac" >> ghi_nhan_do_chinh_xac.tsv
