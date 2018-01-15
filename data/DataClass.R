DataClass <- setRefClass(
  Class="DataClass",
  fields=list(
    rawData="data.frame",
    name='character'
  ),
  methods = list(
    init = function() {
      print("DataClass: init") 
    },
    getData = function(category) {
      print("DataClass: getData, data with Label as Category")
    },
    getClassificationCategories = function() {
      print("DataClass: getClassificationCategories, categories to classify")
    }
  )
)