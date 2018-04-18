#!/bin/sh

mkdir -p ../log

logFileName="../log/"$1".txt"

echo "Log file in $logFileName"

nohup Rscript ./scripts/dispatcher.R $@ > $logFileName 2>&1 &
echo $! > .main_pid.txt
