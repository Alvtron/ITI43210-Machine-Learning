library(caret)
library(C50)

set.seed(1)

# Load dataset
poker.names <- read.csv(paste(sep = "", getwd(), "/datasets/poker/poker.names"), header = FALSE)$V1
dataset.training <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.training"), sep = ",", header = FALSE, col.names = poker.names))
dataset.testing <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.testing"), sep = ",", header = FALSE, col.names = poker.names))
dataset.training$CLASS <- as.factor(dataset.training$CLASS)
dataset.testing$CLASS <- as.factor(dataset.testing$CLASS)

# Model creating
print("Training...")

print("Creating tree model (with boosting, with rules)")
C5BoostRules <- C5.0(CLASS ~ ., data = dataset.training, trials = 35, rules = TRUE)
print(summary(C5BoostRules))

print("Training completed.")

# Measuring accuracy
print("Predicting...")
prediction <- predict(C5BoostRules, dataset.testing)
print("Creating confusion matrix...")
print(confusionMatrix(prediction, dataset.testing$CLASS))