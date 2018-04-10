#!/bin/sh

mkdir -p ../log


if [ "$1" = "boundries" ]; then
	scriptPath="./scripts/crimesInBoundries.R"
elif [ "$1" = "poiDist" ]; then
	scriptPath="./scripts/poiDist.R"
elif [ "$1" = "poiDens" ]; then
	scriptPath="./scripts/poiDensity.R"
elif [ "$1" = "auc" ]; then
	scriptPath="./scripts/aucForExperimentWrapper.R"
elif [ "$1" = "varImp" ]; then
	scriptPath="./scripts/variableImportanceWrapper.R"
else
	echo "No such tool script!"
	exit 1
fi

echo $scriptPath

logFileName="../log/"$1"_"$2".txt"

echo "Log file in $logFileName"

nohup Rscript $scriptPath $2 $3 > $logFileName 2>&1 &

echo $! > .tool_pid.txt

