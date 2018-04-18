#!/bin/sh

mkdir -p ../log

logFileName="../log/all_"$1".txt"

echo "Log file in $logFileName"

nohup Rscript ./scripts/dispatcherAll.R $@ > $logFileName 2>&1 &
echo $! > .main_pid.txt
