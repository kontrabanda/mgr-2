InputParams <- setRefClass(
  Class="InputParams",
  fields=list(
    dataName="character",
    methodName="character",
    monthInterval="numeric",
    fromYear="numeric",
    poiRadius="numeric"
  )
)
