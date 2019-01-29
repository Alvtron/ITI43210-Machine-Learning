library("AppliedPredictiveModeling")
library("caret")
library("e1071")
library("ipred")
library("MASS")

# To tune an SVM model using the credit scoring training set samples, the
# train function can be used. Both the training set predictors and outcome are
# contained in an R data frame called GermanCreditTrain.
data(GermanCredit)

# The chapters directory of the AppliedPredictiveModeling package contains
# the code for creating the training and test sets.

# We will use all the predictors to model the outcome. To do this, we use
# the formula interface with the formula Class ~. the classes are stored in the
# data frame column called class. The most basic function call would be
#
# set.seed(1056)
# svmFit <- train(Class ~ ., data = GermanCredit, method = "svmRadial")

# First, we would like to pre-process the predictor data by
# centering and scaling their values. To do this, the preProc argument can be used:
#
# set.seed(1056)
# svmFit <- train(Class ~ ., data = GermanCredit, method = "svmRadial", preProc = c("center", "scale"))

# Also, for this function, the user can specify the exact cost values to investigate.
# In addition, the function has algorithms to determine reasonable values for many models.
# Using the option tuneLength = 10, the cost values are evaluated.
#
# set.seed(1056)
# svmFit <- train(Class ~ ., data = GermanCredit, method = "svmRadial", preProc = c("center", "scale"), tuneLength = 10)


# By default, the basic bootstrap will be used to calculate performance measures.
# Repeated 10 - fold cross - validation can be specified with the trainControl
# function. The final syntax is then
set.seed(1056)
svmFit <- train(Class ~ .,
data = GermanCredit,
method = "svmRadial",
preProc = c("center", "scale"),
tuneLength = 10,
trControl = trainControl(method = "repeatedcv", repeats = 5))

svmFit