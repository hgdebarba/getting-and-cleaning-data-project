## Getting and Cleaning Data Course Project

The script run_analysis.R produces a tidy data file from [this][sensordata] movement sensor data set

The original data set is composed of accelerometer and gyroscope preprocessed data, acquired with a Samsung Galaxy II smartphone while performing 6 daily physical activities.

The data was originally split into training and test data sets. Feature names, subject code, activity code and activity code/name correspondence were also available, but in different files. 
Additional information on the original data set may be found [here][addinfo] 


In order to deliver the tidy data, **run_analysis.R** performs the following steps:

1. load sparse data (training, test, features, subjects, activities code, activities name)
2. merge training and test data (x_train and x_test)
3. set feature name (features.txt)
3. subset mean and standard deviation data from the data set
4. edit feature names to become more readable
5. add activity and subject codes to the data (y_train.txt, y_test.txt and subject_test.txt)
6. switch the column activity code to activity name (activity_labels.txt)
7. compute the mean of means/SDs by subject code and activity name  
8. generate the tidy data file as a .csv

The tidy data uploaded to coursera was manually converted to .txt (the only text format accepted by the submission page) and may cause readability issues if not converted back to .csv


[sensordata]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

[addinfo]http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 