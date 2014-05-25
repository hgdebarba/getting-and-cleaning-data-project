## read data and set meaningful column names for files with two or less columns
x_train = read.table("UCI-HAR-Dataset//train//x_train.txt")
train_subjectID = read.table("UCI-HAR-Dataset//train//subject_train.txt", col.names = "subjectID")
train_activityID = read.table("UCI-HAR-Dataset//train//y_train.txt", col.names = "activityID")

x_test = read.table("UCI-HAR-Dataset//test//x_test.txt")
test_subjectID = read.table("UCI-HAR-Dataset//test//subject_test.txt", col.names = "subjectID")
test_activityID = read.table("UCI-HAR-Dataset//test//y_test.txt", col.names = "activityID")

activityLabels = read.table("UCI-HAR-Dataset//activity_labels.txt", col.names = c("activityID", "activityName"))

featuresList = read.table("UCI-HAR-Dataset//features.txt", stringsAsFactors = F, col.names = c("featureID", "featureName"))



## 1. Merges the training and the test sets to create one data set.
## merge training and test data
mergedData <- rbind(x_train, x_test)


## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## select >name< and >index< of >mean< and >SD< features using partial match of the strings "mean()" and "std()" 
featureMeanSD = rbind(featuresList[grep("mean\\(\\)", featuresList$featureName) ,],featuresList[grep("std\\(\\)", featuresList$featureName) ,])

## set meaningful column names for featureMeanSD
colnames(featureMeanSD) <- c("ID", "featureName")

## subset mean and SD data
meanSDData <- mergedData[,featureMeanSD$ID]



## 4. Appropriately labels the data set with descriptive activity names. 
## mean() and std() to Mean and SD
featureMeanSD$featureName = gsub("mean\\(\\)", "Mean",featureMeanSD$featureName)
featureMeanSD$featureName = gsub("std\\(\\)", "SD",featureMeanSD$featureName)
## f and t to FFT (fast fourrier transform) and Time
featureMeanSD$featureName = gsub("fB", "FFT\\-B",featureMeanSD$featureName)
featureMeanSD$featureName = gsub("tB", "Time\\-B",featureMeanSD$featureName)
featureMeanSD$featureName = gsub("tG", "Time\\-G",featureMeanSD$featureName)
featureMeanSD$featureName = gsub("\\-", "_",featureMeanSD$featureName)


## use feature names to set meaningful data names
colnames(meanSDData) <- featureMeanSD$featureName



## 3. Uses descriptive activity names to name the activities in the data set
## add two more columns to meanSDData, the activityID and subjectID
meanSDData$activityID <- c(train_activityID$activityID, test_activityID$activityID)
meanSDData$subjectID <- c(train_subjectID$subjectID, test_subjectID$subjectID)

## merge meanSDData and activityLabels, they share the factor named activityID
## as a result the column activityLabels$activityName is added to meanSDData
meanSDData = merge(meanSDData, activityLabels)
meanSDData$activityID <- NULL
write.csv(file="mean_SD_data.csv", x=meanSDData, row.names = F)

## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
## compute mean of means and SD

meanOfMeans = NULL;

## initialize the tidyData data frame with subjectID and activityName. 
## Third column (the actual goal of aggregate) was dropped as the code in the for loop
## can compute it for all columns while preserving the column name
tidyData = aggregate(meanSDData[[featureMeanSD$featureName[1]]] ~ subjectID + activityName, 
                      data = meanSDData, FUN = mean)[,1:2]

## for all relevant features (mean and SD)
for (i in 1:length(featureMeanSD$featureName)){
    newName = featureMeanSD$featureName[i]
    ## mean for this column for every combination of subjectID and activityName
    meanOfMeans = aggregate(meanSDData[[newName]] ~ subjectID + activityName, data = meanSDData, FUN = mean)
    ## add new column to tidyData with the correct name
    newName = paste("Mean_of_", newName)
    tidyData[,newName] = meanOfMeans[,"meanSDData[[newName]]"]
}
## write the data into a CSV file
write.csv(file="Mean_of_means_and_SDs.csv", x=tidyData, row.names = F)

