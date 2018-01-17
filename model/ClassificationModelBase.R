ClassificationModelBase <- setRefClass(
  Class="ClassificationModelBase",
  fields = list(
    name="character"
  ),
  methods = list(
    trainModel = function(trainData) {
      print("ClassificationModelBase: trainModel")
    },
    predictLabels = function(testData) {
      print("ClassificationModelBase: predictLabels")
    }
  )
)