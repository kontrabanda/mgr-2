InputParams <- setRefClass(
  Class="InputParams",
  fields=list(
    taskType="character",
    dataName="character",
    methodName="character",
    monthInterval="numeric",
    fromYear="numeric",
    poiRadius="numeric"
  )
)
