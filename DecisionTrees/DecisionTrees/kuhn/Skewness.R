library(caret)
library(AppliedPredictiveModeling)
library(e1071)

dataFilePath <- paste(sep = "", getwd(), "/datasets/poker/poker.data")
namesFilePath <- paste(sep = "", getwd(), "/datasets/poker/poker.names")

poker.names <- read.csv(namesFilePath, header = FALSE)$V1
poker.data <- read.table(dataFilePath, sep = ",", header = FALSE, col.names = poker.names)

dataset <- as.data.frame(poker.data)

skewness(dataset$suit1)