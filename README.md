## Getting and Cleaning Data **Course Project**

The script run_analysis.R load the sparse movement sensor data available [here][sensordata] to produce a tidy datafile as output

The dataset is composed by accelerometer and gyroscope of a Samsung Galaxy II while performing 6 common physical activities.

The data was originaly split in training and test datasets. Feature names, subject code, activity code and activity code/name correspondence were also available in different files. 
[Additional information on the dataset][info] 


The main steps of the script are

1. load sparse data (training, test, features, subjects, activities, activities name)
2. merge training and test data
3. set correct feature name
3. subset mean and standard deviation data from the dataset
4. reshape column names to become more readible
5. add activity and subject codes to the data
6. switch activity code to activity name
7. compute mean of data (original mean and SD) by subject code and activity name
8. generate the tidy data file as a .csv

The tidy data uploaded to coursera was manually converted to .txt (the only text format accepted in the submission page) and may cause readibility issues if not converted back to .csv

[The New York Times][NY Times].

[sensordata]: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

[info]http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 