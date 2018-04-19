source(file = './const/ConstHotspot.R')
source(file = './data/points-in-hotspot/BialystokHotspotPOIData.R')
source(file = './strategy/CrossValidationHotspot.R')

source(file="./model/LogisticRegressionModel.R")
source(file="./model/KNNModel.R")
source(file="./model/NaiveBayesModel.R")
source(file="./model/RandomForestModel.R")
source(file="./model/SVMModel.R")
source(file="./model/DecisionTreeModel.R")

experimentName <- 'test-333'
dataClass <- BialystokHotspotPOIData()
dataClass$extractData()
ClassificationModel <- KNNModel

crossValidationHotspot <- CrossValidationHotspot(experimentName, dataClass, ClassificationModel)
crossValidationHotspot$crossValidation()












