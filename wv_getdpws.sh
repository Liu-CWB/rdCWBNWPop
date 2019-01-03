#!/bin/bash

#To store grib2 data, creating a directory that named by day(ex:20190101) and check it if there exist.
today=$(date +"%Y%m%d%H")
dirname=${today:0:8}
echo ${dirname}
if [ -d "home/chimin64/CWB_WRF/${dirname}" ]; then
  echo "${dirname} directory exists"
else
  mkdir "/home/chimin64/CWB_WRF/${dirname}"
fi

initial=("${dirname}00" "${dirname}06" "${dirname}12" "${dirname}18")
varname="wv"
server="61.56.14.11"

#Get grib2 data from CWB
for ((i=0;i<=3;i=i+1));   #initial time
do
  echo ${initial[$i]}
  for ((j=0;j<=6;j=j+1));  #tau:forecst time
  do
    if [ ${j} -lt 10 ]; then
      tau="00${j}"
    else
      tau="0${j}"
    fi
    if [ -f "/home/chimin64/CWB_WRF/${dirname}/${varname}${initial[$i]}.${tau}m" ]; then
      echo "${varname}${initial[$i]}.${tau}m exists"  
    else
    ftp -n -i ${server} << EOF
      user NCKURDF Cwb2+8851+Ncku
      binary
      cd /625
      lcd /home/chimin64/CWB_WRF/${dirname}
      passive
      prompt
      get ${varname}${initial[$i]}.${tau}m
      close
      bye
EOF
    fi
  done
done

#To store netcdf file, creating a directory that named by day(ex:20190101) and check it if there exist.
if [ -d "/home/chimin64/CWB_NC/${dirname}" ]; then
  echo "${dirname} directory exists"
else
  mkdir "/home/chimin64/CWB_NC/${dirname}"
fi

#Trasfer the grib2 format to netcdf format
wgrib2="/home/louis/grib2/wgrib2/wgrib2"   #the path where put the excution file
pathnc="/home/chimin64/CWB_NC/${dirname}"
pathgrib="/home/chimin64/CWB_WRF/${dirname}"
for ((i=0;i<=6;i=i+1));
do 
  if [ ${i} -lt 10 ]; then
    tau="00${i}"
  else
    tau="0${i}"
  fi
  ${wgrib2} ${pathgrib}/${varname}${initial}.${tau}m -netcdf ${pathnc}/${varname}${initial}_${tau}.nc
  #wgrib2 /home/chimin64/CWB_WRF/${dirname}/wu${dirname}00.${tau}m -netcdf ${pathnc}/wu${dirname}00_${tau}.nc
done



