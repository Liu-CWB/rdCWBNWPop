#!/bin/bash

today="$(date +"%Y%m%d%H")"
hour=${today:8:2}
yesterday="$(date -d yesterday +"%Y%m%d")"
if [ ${hour} -gt 14 ] && [ ${hour} -lt 16 ]
then
initialtime=${today:0:8}"00"
echo $initialtime
elif [ ${hour} -gt 20 ] && [ ${hour} -lt 22 ]
then
initialtime=${today:0:8}"06"
echo $initialtime
elif [ ${hour} -gt 2 ] && [ ${hour} -lt 4 ]
then
initialtime=${yesterday:0:8}"12"
echo $initialtime
elif [ ${hour} -gt 8 ] && [ ${hour} -lt 10 ]
then
initialtime=${yesterday:0:8}"18"
echo $initialtime
fi

echo $today
