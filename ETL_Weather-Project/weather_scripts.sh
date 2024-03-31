#!/bin/bash

#dat gia tri vietnam va gan vao bien city

city=112.197.248.53

#de file bao cao thu thap vao ngay nao ta can tao bien thoi gian va gan cac gia tri timestamp vao file bao cao 
thoi_gian_hien_tai=$(date +%Y_%m_%d)

#lay cac thong tin ve thoi tiet Viet Nam tren web wttr.in
curl -s https://wttr.in/$city?T > bao_cao_["$thoi_gian_hien_tai"]

#Lay thong tin nhiet do hien tai va gan vao gia tri current_tmp
#xay dung pipes

current_tmp=$(curl -s wttr.in/$city?T | grep -m 1 '°.' | grep -Eo -e '-?[[:digit:]].*'| cut -d "(" -f1)

#Tuong tu nhu lay nhiet do hien tai ta se lay nhiet do du bao ngay mai dua vao file bao_cao va gan gia tri vao bien tomorow_tmp
#xay dung pipes

tomorow_tmp=$(curl -s wttr.in/$city?T | head -23 | tail -1 | grep '°.' | cut -d 'C' -f2 | grep -Eo -e '-?[[:digit:]].*' | cut -d "(" -f1 | cut -d " " -f1)

#Luu cac gia tri nhu tieng, ngay, thang va nam va dat bien tam la TZ 

hour=$(TZ='Vietnam/HoChiMinh' date -u +%H)
day=$(TZ='Vietnam/HoChiMinh' date -u +%d)
month=$(TZ='Vietnam/HoChiMinh' date -u +%m)
year=$(TZ='Vietnam/HoChiMinh' date -u +%Y)

#gan gia tri thoi gian vua tao tren va nhiet do vao file .log

record=$(echo -e "$year\t$month\t$day\t$current_tmp\t$tomorow_tmp")
echo $record >> nhatky.log

