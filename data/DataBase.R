DataBase <- setRefClass(
  Class="DataBase",
  fields=list(
    rawData="data.frame",
    name='character'
  ),
  methods = list(
    init = function() {
      print("DataBase: init") 
    },
    getData = function(category) {
      print("DataBase: getData, data with Label as Category")
    },
    getTestData = function() {
      print("getTestData: getData, data without label")
    },
    getClassificationCategories = function() {
      print("DataBase: getClassificationCategories, categories to classify")
    },
    getRowSize = function() {
      nrow(rawData)
    }
  )
)