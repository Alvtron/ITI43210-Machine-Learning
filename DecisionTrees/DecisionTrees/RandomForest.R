library(randomForest)
library(mlbench)
library(caret)

set.seed(1)

# Load dataset
dataFilePath <- paste(sep = "", getwd(), "/datasets/flags/flag.data")
namesFilePath <- paste(sep = "", getwd(), "/datasets/flags/flag.names")

flag.names <- read.csv(namesFilePath, header = FALSE)$V1
flag.data <- read.table(dataFilePath, sep = ",", header = FALSE, col.names = flag.names)
flag.data <- subset(flag.data, select = -c(name))

dataset <- as.data.frame(flag.data)

dataset$religion <- as.factor(dataset$religion)

# Pre-processing
trans <- preProcess(dataset, method = c("BoxCox", "center", "scale", "pca"))
dataset <- predict(trans, dataset)

# Create model with default paramters and auto mtry tuning
control <- trainControl(method = "repeatedcv", number = 10, repeats = 3, search = "random")
print("Training...")

rf_default <- train(religion ~ ., data = dataset, method = "rf", metric = "Accuracy", tuneLength = 10, trControl = control)

print("Training completed.")
print(rf_default)
plot(rf_default)

# without pre-processing:
# mtry = 97
# Accuracy 0.6782990
# Kappa 0.5878833

# with pre-processing:
# mtry = 47
# Accuracy 0.5311461
# Kappa 0.3811316