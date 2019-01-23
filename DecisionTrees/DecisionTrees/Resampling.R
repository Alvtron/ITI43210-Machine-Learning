library("caret")

set.seed(1)
# For illustration, generate the information needed for three resampled versions of the training set.
repeatedSplits <- createDataPartition(trainClasses, p = .80, times = 3)
str(repeatedSplits)

# k-old cross-validation
cvSplits <- createFolds(trainClasses, k = 10, returnTrain = TRUE)
str(cvSplits)
# Get the first set of row numbers from the list.
fold1 <- cvSplits[[1]]
# To get the first 90% of the data (the first fold):
cvPredictors1 <- trainPredictors[fold1,]
cvClasses1 <- trainClasses[fold1]
print("Nubmer of train predictors:")
print(nrow(trainPredictors))
print("Nubmer of folded predictors:")
print(nrow(cvPredictors1))

q()