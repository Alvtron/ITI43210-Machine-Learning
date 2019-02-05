library(caret)

set.seed(1)

# Load dataset
poker.names <- read.csv(paste(sep = "", getwd(), "/datasets/poker/poker.names"), header = FALSE)$V1
dataset.training <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.training"), sep = ",", header = FALSE, col.names = poker.names))
dataset.testing <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.testing"), sep = ",", header = FALSE, col.names = poker.names))
dataset.training$CLASS <- as.factor(dataset.training$CLASS)
dataset.testing$CLASS <- as.factor(dataset.testing$CLASS)

# Estimate mtry and ntree
# library(randomForest)
# predictors <- dataset.training[, - c(11)]
# classes <- dataset.training[, 11]
# bestmtry <- tuneRF(predictors, classes, stepFactor = 1.5, improve = 1e-5, ntree = 2000)
# print(bestmtry)

# Create model
control <- trainControl(method = "none")
print("Training...")
rfmodel = train(CLASS ~ ., data = dataset.training, method = "rf", ntree = 1000, metric = "Accuracy", tuneGrid = data.frame(mtry = 9), trControl = control)
print("Training completed.")
print(rfmodel)

# Measuring Accuracy
print("Predicting...")
prediction <- predict(rfmodel, dataset.testing)
print("Creating confusion matrix...")
print(confusionMatrix(prediction, dataset.testing$CLASS))