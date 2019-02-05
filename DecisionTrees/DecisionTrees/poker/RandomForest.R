library(caret)
library(randomForest)

set.seed(1)

# Load dataset
poker.names <- read.csv(paste(sep = "", getwd(), "/datasets/poker/poker.names"), header = FALSE)$V1
dataset.training <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.training"), sep = ",", header = FALSE, col.names = poker.names))
dataset.testing <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.testing"), sep = ",", header = FALSE, col.names = poker.names))
dataset.training$CLASS <- as.factor(dataset.training$CLASS)
dataset.testing$CLASS <- as.factor(dataset.testing$CLASS)

# Estimate mtry and ntree
# predictors <- dataset.training[, - c(11)]
# classes <- dataset.training[, 11]
# bestmtry <- tuneRF(predictors, classes, stepFactor = 1.5, improve = 1e-5, ntree = 2000)
# print(bestmtry)

# Create model
control <- trainControl(method = "none")
print("Training...")
rfmodel = train(CLASS ~ ., data = dataset.training, method = "rf", ntree = 1000, metric = "Accuracy", tuneGrid = data.frame(mtry = 9), trControl = control)
print("Training completed.")
print(randomForestModel)

# Predicting
print("Predicting...")
prediction <- predict(rfmodel, dataset.testing, type = "prob")
print("Prediction completed.")

# Measuring Accuracy
dataset.testing$RFprob <- prediction[, "0"]
dataset.testing$RFclass <- predict(rfmodel, dataset.testing)
confusionMatrix(data = dataset.testing$RFclass, reference = dataset.testing$CLASS, positive = "0")