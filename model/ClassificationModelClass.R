ClassificationModelClass <- setRefClass(
  Class="ClassificationModelClass",
  fields = list(
    name="character"
  ),
  methods = list(
    trainModel = function(trainData) {
      print("ClassificationModelClass: trainModel")
    },
    predictLabels = function(testData) {
      print("ClassificationModelClass: predictLabels")
    }
  )
)