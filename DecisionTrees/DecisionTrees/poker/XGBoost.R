library(caret)
library(xgboost)

set.seed(1)

# Load dataset
poker.names <- read.csv(paste(sep = "", getwd(), "/datasets/poker/poker.names"), header = FALSE)$V1
dataset.training <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.training"), sep = ",", header = FALSE, col.names = poker.names))
dataset.testing <- as.data.frame(read.table(paste(sep = "", getwd(), "/datasets/poker/poker.testing"), sep = ",", header = FALSE, col.names = poker.names))
dataset.training$CLASS <- as.factor(dataset.training$CLASS)
dataset.testing$CLASS <- as.factor(dataset.testing$CLASS)

# Creating model
trctrl <- trainControl(method = "cv", number = 5)

tune_grid <- expand.grid(nrounds = 200,
                        max_depth = 5,
                        eta = 0.05,
                        gamma = 0.01,
                        colsample_bytree = 0.75,
                        min_child_weight = 0,
                        subsample = 0.5)

print("Training...")

xgbtree <- train(CLASS ~ ., data = dataset.training, method = "xgbTree",
                trControl = trctrl,
                tuneGrid = tune_grid,
                tuneLength = 10)

print("Training completed.")

print(xgbtree)

# Measuring accuracy
prediction <- predict(xgbtree, dataset.testing)
print("Creating confusion matrix...")
print(confusionMatrix(prediction, dataset.testing$CLASS))