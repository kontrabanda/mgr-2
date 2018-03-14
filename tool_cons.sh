#!/bin/sh

if [ "$1" = "boundries" ]; then
	scriptPath="./scripts/crimesInBoundries.R"
elif [ "$1" = "poiDist" ]; then
	scriptPath="./scripts/poiDist.R"
elif [ "$1" = "poiDens" ]; then
	scriptPath="./scripts/poiDensity.R"
elif [ "$1" = "auc" ]; then
	scriptPath="./scripts/aucForExperimentWrapper.R"
else
	echo "No such tool script!"
	exit 1
fi

echo $scriptPath

Rscript $scriptPath $2 $3
