dataMapping <- list(
  bialystok_poi = BialystokHotspotPOIData,
  bournemouth_poi = BournemouthHotspotPOIData,
  
  bialystok_grid_poi = BialystokGridHotspotPOIData
)

methodMapping <- list(
  logistic_regression = LogisticRegressionModel,
  bayes = NaiveBayesModel,
  random_forest = RandomForestModel,
  svm = SVMModel,
  decision_tree = DecisionTreeModel
)
