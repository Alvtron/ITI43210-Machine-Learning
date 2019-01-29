library(Cubist)
library(caret)

set.seed(1)

# Load dataset
# Load dataset
dataFilePath <- paste(sep = "", getwd(), "/datasets/poker/poker.data")
namesFilePath <- paste(sep = "", getwd(), "/datasets/poker/poker.names")

poker.names <- read.csv(namesFilePath, header = FALSE)$V1
poker.data <- read.table(dataFilePath, sep = ",", header = FALSE, col.names = poker.names)

dataset <- as.data.frame(poker.data)

# Pre-processing
#trans <- preProcess(dataset, method = c("BoxCox", "center", "scale", "pca"))
#dataset <- predict(trans, dataset)

# Data splitting
predictors <- dataset[, c(1:10)]
classes <- dataset[, 11]

trainingRows <- createDataPartition(classes, p = .90, list = FALSE)

trainPredictors <- predictors[trainingRows,]
trainClasses <- classes[trainingRows]
testPredictors <- predictors[-trainingRows,]
testClasses <- classes[-trainingRows]

# Model creating
cubistMod <- cubist(trainPredictors, trainClasses)
cubistTuned <- train(trainPredictors, trainClasses, method = "cubist")

print(cubistTuned)

ggplot(cubistTuned)

#prediction <- predict(cubistMod, testPredictors)