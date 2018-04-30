#!/bin/sh

mkdir -p ../log


if [ "$1" = "boundries" ]; then
	scriptPath="./scripts/tools/crimesInBoundries.R"
elif [ "$1" = "poiDist" ]; then
	scriptPath="./scripts/tools/poiDist.R"
elif [ "$1" = "poiDens" ]; then
	scriptPath="./scripts/tools/poiDensity.R"
elif [ "$1" = "auc" ]; then
	scriptPath="./scripts/tools/aucForExperimentWrapper.R"
elif [ "$1" = "hsEl" ]; then
	scriptPath="./scripts/hotspot-element/tools/computeClassificationDataWrapper.R"
elif [ "$1" = "hsGrid" ]; then
	scriptPath="./scripts/hotspot-grid/tools/computeClassificationDataWrapper.R"
elif [ "$1" = "varImp" ]; then
	scriptPath="./scripts/tools/variableImportanceWrapper.R"
else
	echo "No such tool script!"
	exit 1
fi

echo $scriptPath

logFileName="../log/"$1"_"$2".txt"

echo "Log file in $logFileName"

nohup Rscript $scriptPath $2 $3 > $logFileName 2>&1 &

echo $! > .tool_pid.txt

