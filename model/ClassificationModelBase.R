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
    },
    getAdditionalInformation = function() {
      NULL
    },
    hasPlot = function() {
      FALSE
    },
    getPlot = function() {
      NULL
    }
  )
)