library(e1071)
library(caret)
library(corrplot)

# For one predictor:
skewness(segData$AngleCh1)
# Since all the predictors are numeric columns, the apply function can
# be used to compute the skewness across columns.
skewValues <- apply(segData, 2, skewness)
head(skewValues)

Ch1AreaTrans <- BoxCoxTrans(segData$AreaCh1)
Ch1AreaTrans

# The original data
head(segData$AreaCh1)
# After transformation
predict(Ch1AreaTrans, head(segData$AreaCh1))

pcaObject <- prcomp(segData, center = TRUE, scale. = TRUE)
# Calculate the cumulative percentage of variance which each component accounts for.
percentVariance <- pcaObject$sd ^ 2 / sum(pcaObject$sd ^ 2) * 100
percentVariance[1:3]

# The transformed values are stored in pcaObject as a sub-object called x:
head(pcaObject$x[, 1:5])

# Rotation
head(pcaObject$rotation[, 1:3])

# Use preProcess to transform, center, scale, or impute values, as well as apply the spatial sign transformation and feature extraction.
# Example: to Box–Cox transform, center, and scale the data, then execute PCA for signal extraction, the syntax would be:
trans <- preProcess(segData, method = c("BoxCox", "center", "scale", "pca"))
trans

# Apply the transformations:
transformed <- predict(trans, segData)
# These values are different than the previous PCA components since they were transformed prior to PCA
head(transformed[, 1:5])

# Filter for near-zero variance predictors,
nearZeroVar(segData)
integer(0)
# When predictors should be removed, a vector of integers is returned that indicates which columns should be removed.

# Filter on between-predictor correlations
correlations <- cor(segData)
dim(correlations)
correlations[1:4, 1:4]

# Visually examine the correlation structure of the data
corrplot(correlations, order = "hclust")

# Filter based on correlations
highCorr <- findCorrelation(correlations, cutoff = .75)
length(highCorr)
head(highCorr)
filteredSegData <- segData[, - highCorr]
filteredSegData[1:4, 1:4]