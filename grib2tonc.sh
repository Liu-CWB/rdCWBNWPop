#!/bin/bash
path="/home/chimin64/CWB_WRF/dpws_cwb/201810_nc"
varname=( "wu" "wv" )
yy=2018
mm=12
for ((dd=18; dd<=25; dd=dd+1));
do
    for hh in "00" "06" "12" "18";
    do
      initialtime=${yy}${mm}${dd}${hh}
        for ((i=0; i<=84; i=i+1));
        do
          if [ ${i} -lt 10 ]
          then 
            tau="00${i}"
          elif [ ${i} -ge 10 ] && [ ${i} -lt 100 ]
          then
            tau="0${i}"
          else
            tau="${i}"
          fi
          wgrib2 ${varname[0]}${initialtime}.${tau}m -netcdf ${path}/${varname[0]}${initialtime}_${tau}.nc
          wgrib2 ${varname[1]}${initialtime}.${tau}m -netcdf ${path}/${varname[1]}${initialtime}_${tau}.nc
        done
    done
done
