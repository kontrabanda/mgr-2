LoggerBase <- setRefClass(
  Class="LoggerBase",
  fields=list(
    
  ),
  methods = list(
    start = function() {
      print("LoggerBase: start")
    },
    stop = function() {
      print("LoggerBase: stop")
    },
    save = function() {
      print("LoggerBase: save")
    }
  )
)
