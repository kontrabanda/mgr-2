dataMapping <- list(
  bialystok_poi = BialystokHotspotPOIData,
  bournemouth_poi = BournemouthHotspotPOIData,
  bialystok_SWD_poi = BialystokSWDHotspotPOIData,
  olsztyn_SWD_poi = OlsztynSWDHotspotPOIData,
  random_poi = RandomHotspotPOIData,
  
  bialystok_SWD_poi_one = BialystokSWDHotspotOnePOIData,
  
  bialystok_grid_poi = BialystokGridHotspotPOIData,
  bournemouth_grid_poi = BournemouthGridHotspotPOIData,
  bialystok_SWD_grid_poi = BialystokSWDGridHotspotPOIData,
  olsztyn_SWD_grid_poi = OlsztynSWDGridHotspotPOIData,
  random_grid_poi = RandomGridHotspotPOIData,
  
  bialystok_SWD_grid_poi_one = BialystokSWDGridOnePOIData,
  olsztyn_SWD_grid_poi_one = OlsztynSWDGridOnePOIData,
  bournemouth_grid_poi_one = BournemouthGridOnePOIData
)

methodMapping <- list(
  logistic_regression = LogisticRegressionModel,
  bayes = NaiveBayesModel,
  knn = KNNModel,
  random_forest = RandomForestModel,
  svm = SVMModel,
  decision_tree = DecisionTreeModel
)
