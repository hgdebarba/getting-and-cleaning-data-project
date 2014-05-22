x_train = read.table("UCI-HAR-Dataset//train//x_train.txt")
train_subjectID = read.table("UCI-HAR-Dataset//train//subject_train.txt", col.names = "subjectID")
train_activityID = read.table("UCI-HAR-Dataset//train//y_train.txt", col.names = "activityID")

x_test = read.table("UCI-HAR-Dataset//test//x_test.txt")
test_subjectID = read.table("UCI-HAR-Dataset//test//subject_test.txt", col.names = "subjectID")
test_activityID = read.table("UCI-HAR-Dataset//test//y_test.txt", col.names = "activityID")

activity_labels = read.table("UCI-HAR-Dataset//activity_labels.txt", col.names = c("activityID", "activityName"))

featuresList = read.table("UCI-HAR-Dataset//features.txt", stringsAsFactors = F, col.names = c("featureID", "featureName"))

## merge data
mergedData <- rbind(x_train, x_test)
#mergedData$activityID <- rbind(train_activityID, test_activityID)
#mergedData$subjectID <- rbind(train_subjectID, test_subjectID)


## get feature mean/std name and index
mean_std_index = rbind(featuresList[grep("-mean\\(\\)", featuresList$featureName) ,],featuresList[grep("std\\(\\)", featuresList$featureName) ,])
colnames(mean_std_index) <- c("ID", "featureName")

## mean std data
meanStdData <- mergedData[,order(mean_std_index$ID)]
colnames(meanStdData) <- mean_std_index$featureName

meanStdData$activityID <- c(train_activityID$activityID, test_activityID$activityID)
meanStdData$subjectID <- c(train_subjectID$subjectID, test_subjectID$subjectID)

meanStdData = merge(meanStdData, activity_labels)#, by.x = "activityID", by.y = "activityID")
head(meanStdData, n=3)
tapply(meanStdData[,5], list(meanStdData$subjectID, meanStdData$activityName), mean)

install.packages("data.table")
library(data.table)
meanStdDT <- as.data.table(meanStdData)
newDT <- meanStdDT[, mean(colnames(meanStdDT)),   by="subjectID,activityName"]
