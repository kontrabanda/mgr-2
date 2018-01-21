BinaryResults <- setRefClass(
  Class="BinaryResults",
  fields=list(
    data="data.frame"
  ),
  methods = list(
    initialize = function(data = NULL) {
      data <<- data
    },
    getLabel = function(classificatorName, categoryName) {
      data$label
    },
    getProbabilites = function() {
      data[, 'X1']
    }
  )
)