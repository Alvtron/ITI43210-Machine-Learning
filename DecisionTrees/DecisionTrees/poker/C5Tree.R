library(Cubist)
library(caret)
library(C50)

set.seed(1)

# Load dataset
dataFilePath <- paste(sep = "", getwd(), "/datasets/poker/poker.data")
namesFilePath <- paste(sep = "", getwd(), "/datasets/poker/poker.names")

poker.names <- read.csv(namesFilePath, header = FALSE)$V1
poker.data <- read.table(dataFilePath, sep = ",", header = FALSE, col.names = poker.names)

dataset <- as.data.frame(poker.data)

dataset$CLASS <- as.factor(dataset$CLASS)

# Pre-processing
#trans <- preProcess(dataset, method = c("BoxCox", "center", "scale", "pca"))
#dataset <- predict(trans, dataset)

# Model creating
treeModel <- C5.0(CLASS ~ ., data = dataset)
print(treeModel)
print(summary(treeModel))