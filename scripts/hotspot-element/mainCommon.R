dataMapping <- list(
  bialystok_poi = BialystokHotspotPOIData
)

methodMapping <- list(
  logistic_regression = LogisticRegressionModel,
  bayes = NaiveBayesModel,
  random_forest = RandomForestModel,
  svm = SVMModel,
  decision_tree = DecisionTreeModel
)
