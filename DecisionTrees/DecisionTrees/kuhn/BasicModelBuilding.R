library("AppliedPredictiveModeling")
library("caret")
library("e1071")
library("ipred")
library("MASS")

# There are two main conventions for specifying models in R:the formula
# interface and the non - formula(or “matrix”) interface. For the former, the
# predictors are explicitly listed. A basic R formula has two sides:the left - hand
# side denotes the outcome and the right - hand side describes how the predictors
# are used. These are separated with a tilde(~).
#
# For example, the formula
# modelFunction(price ~ numBedrooms + numBaths + acres, data = housingData)

# The non - formula interface specifies the predictors for the model using a
# matrix or data frame(all the predictors in the object are used in the model) .
# The outcome data are usually passed into the model as a vector object.
#
# For example,
# modelFunction(x = housePredictors, y = price)

# For knn3, we can estimate the 5-nearest neighbor model with
trainPredictors <- as.matrix(trainPredictors)
knnFit <- knn3(x = trainPredictors, y = trainClasses, k = 5)
knnFit

# At this point, the knn3 object is ready to predict new samples. To assign
# new samples to classes, the predict method is used with the model object.
# The standard convention is
testPredictions <- predict(knnFit, newdata = testPredictors, type = "class")
head(testPredictions)
str(testPredictions)