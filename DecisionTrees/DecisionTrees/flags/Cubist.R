library(Cubist)
library(caret)

set.seed(1)

# Load dataset
dataFilePath <- paste(sep = "", getwd(), "/datasets/flags/flag.data")
namesFilePath <- paste(sep = "", getwd(), "/datasets/flags/flag.names")

flag.names <- read.csv(namesFilePath, header = FALSE)$V1
flag.data <- read.table(dataFilePath, sep = ",", header = FALSE, col.names = flag.names)
flag.data <- subset(flag.data, select = -c(name))

dataset <- as.data.frame(flag.data)

# Pre-processing
trans <- preProcess(dataset, method = c("BoxCox", "center", "scale", "pca"))
dataset <- predict(trans, dataset)

# Data splitting
predictors <- dataset[, - c(1:7)]
classes <- dataset[, 7]

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