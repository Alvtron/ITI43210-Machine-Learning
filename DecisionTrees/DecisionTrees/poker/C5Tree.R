library(caret)
library(C50)

set.seed(1)

# Load dataset
poker.names <- read.csv(paste(sep = "", getwd(), "/datasets/poker/poker.names"), header = FALSE)$V1
dataset.training <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.training"), sep = ",", header = FALSE, col.names = poker.names))
dataset.testing <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.testing"), sep = ",", header = FALSE, col.names = poker.names))
dataset.training$CLASS <- as.factor(dataset.training$CLASS)
dataset.testing$CLASS <- as.factor(dataset.testing$CLASS)

# Splitting
trainPredictors <- dataset.training[, c(1:10)]
trainClasses <- dataset.training[, c(11)]
testPredictors <- dataset.testing[, c(1:10)]
testClasses <- dataset.testing[, c(11)]

# Model creating
print("Training...")
print("Creating tree model (default)")
C5Default <- C5.0(x = trainPredictors, y = trainClasses, rules = FALSE)
print(summary(C5Default))
print("Creating tree model (with rules)")
C5Rules <- C5.0(x = trainPredictors, y = trainClasses, rules = TRUE)
print(summary(C5Rules))
print("Creating tree model (with boosting)")
C5Boost <- C5.0(x = trainPredictors, y = trainClasses, trials = 20)
print(summary(C5Boost))
print("Training completed.")

# Measure accuracy
print("--- C5 Default ---")
prediction <- predict(C5Default, dataset.testing, type = "prob")
dataset.testing$RFprob <- prediction[, "0"]
dataset.testing$RFclass <- predict(C5Default, dataset.testing)
print(confusionMatrix(data = dataset.testing$RFclass, reference = dataset.testing$CLASS, positive = "0"))

print("--- C5 Rules ---")
prediction <- predict(C5Rules, dataset.testing, type = "prob")
dataset.testing$RFprob <- prediction[, "0"]
dataset.testing$RFclass <- predict(C5Rules, dataset.testing)
print(confusionMatrix(data = dataset.testing$RFclass, reference = dataset.testing$CLASS, positive = "0"))

print("--- C5 Boost ---")
prediction <- predict(C5Boost, dataset.testing, type = "prob")
dataset.testing$RFprob <- prediction[, "0"]
dataset.testing$RFclass <- predict(C5Boost, dataset.testing)
print(confusionMatrix(data = dataset.testing$RFclass, reference = dataset.testing$CLASS, positive = "0"))