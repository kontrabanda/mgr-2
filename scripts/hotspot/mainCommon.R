dataMapping <- list(
  bialystok_poi = BialystokHotspotPOIData,
  bournemouth_poi = BournemouthHotspotPOIData,
  random_poi = RandomHotspotPOIData,
  
  bialystok_grid_poi = BialystokGridHotspotPOIData,
  bournemouth_grid_poi = BournemouthGridHotspotPOIData
)

methodMapping <- list(
  logistic_regression = LogisticRegressionModel,
  bayes = NaiveBayesModel,
  random_forest = RandomForestModel,
  svm = SVMModel,
  decision_tree = DecisionTreeModel
)
