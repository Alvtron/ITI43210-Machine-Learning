library(Cubist)
library(caret)
library(C50)

set.seed(1)

# Load dataset
dataFilePath <- paste(sep = "", getwd(), "/datasets/flags/flag.data")
namesFilePath <- paste(sep = "", getwd(), "/datasets/flags/flag.names")

flag.names <- read.csv(namesFilePath, header = FALSE)$V1
flag.data <- read.table(dataFilePath, sep = ",", header = FALSE, col.names = flag.names)
flag.data <- subset(flag.data, select = -c(name))

dataset <- as.data.frame(flag.data)

print(head(dataset))

dataset$religion <- as.factor(dataset$religion)

# Pre-processing
trans <- preProcess(dataset, method = c("BoxCox", "center", "scale", "pca"))
dataset <- predict(trans, dataset)

# Model creating
treeModel <- C5.0(religion ~ ., data = dataset)
print(treeModel)
print(summary(treeModel))