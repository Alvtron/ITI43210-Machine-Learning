library("AppliedPredictiveModeling")

# Two-class data

data(twoClassData)

# The predictors for the example data are stored in a data frame called predictors.
# There are two columns for the predictors and 208 samples in rows.
# The outcome classes are contained in a factor vector called classes.

print('Predictors:')
str(predictors)
print('Classes:')
str(classes)

# Set the random number seed so we can reproduce the results
set.seed(1)
# By default, the numbers are returned as a list. Using
# list = FALSE, a matrix of row numbers is generated.
# These samples are allocated to the training set.
trainingRows <- createDataPartition(classes, p = .80, list = FALSE)
head(trainingRows)

# Subset the data into objects for training using integer sub-setting.
trainPredictors <- predictors[trainingRows, ]
trainClasses <- classes[trainingRows]

# Do the same for the test set using negative integers.
testPredictors <- predictors[-trainingRows, ]
testClasses <- classes[-trainingRows]
print('Train Predictors:')
str(trainPredictors)
print('Test Predictors:')
str(testPredictors)

# To generate a test set using maximum dissimilarity sampling,
# the caret function 'maxdissim' can be used to sequentially sample the data.

