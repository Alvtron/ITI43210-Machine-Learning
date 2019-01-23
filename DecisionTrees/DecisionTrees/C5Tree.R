library(Cubist)
library(caret)
library(C50)

set.seed(1)

# Load dataset
flag.names <- read.csv("C:/Users/thoma/source/repos/ITI43210 Machine Learning/Chapter 2/datasets/flags/flag.names", header = FALSE)$V1
flag.names

flag.data <- read.table("C:/Users/thoma/source/repos/ITI43210 Machine Learning/Chapter 2/datasets/flags/flag.data", sep = ",", header = FALSE, col.names = flag.names)
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