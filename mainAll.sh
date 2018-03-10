#!/bin/sh

mkdir -p ../log

logFileName="../log/all_"$1"_"$2".txt"

echo "Log file in $logFileName"

nohup Rscript ./scripts/mainAll.R $@ > $logFileName 2>&1 &
echo $! > .main_pid.txt
