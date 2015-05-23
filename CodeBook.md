# Getting and Cleaning Data Course Project Code Book

-----------------------

### The original data set:

This dataset was collected from the accelerometers from the Samsung Galaxy S smartphone. 

The full description of it can be found in:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The original data was downloaded from:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


### Newly generted data set:

There are two new data sets: "merged_data_set.txt" and "averaged_data_set.txt" which are generated from the original data set after some transformations. The size of these two data sets are respectively [10299\*68] and [180\*68]. A brief explanation of these two data sets are shown in the following table.

|Column No. |Column Name|Explanation|Type|Range|
|:---------:|:---------:|:---------:|:---------:|:---------:|
|1|"subject"|subject ID|integer|1 to 30|
|2|"activity"|activity name|factor|STANDING, SITTING, LAYING, WALKING, WALKING_DOWNSTAIRS, WALKING_UPSTAIRS|
|3 to 68|see below |measurements that are related to "mean" and "standard deviation"| numeric| -1 to +1|


The list of column names from column 3 to 68 in the above table is as following:

[1] "tBodyAcc-mean-X"           "tBodyAcc-mean-Y"           "tBodyAcc-mean-Z"          
[4] "tBodyAcc-std-X"            "tBodyAcc-std-Y"            "tBodyAcc-std-Z"           
[7] "tGravityAcc-mean-X"        "tGravityAcc-mean-Y"        "tGravityAcc-mean-Z"       
[10] "tGravityAcc-std-X"         "tGravityAcc-std-Y"         "tGravityAcc-std-Z"        
[13] "tBodyAccJerk-mean-X"       "tBodyAccJerk-mean-Y"       "tBodyAccJerk-mean-Z"      
[16] "tBodyAccJerk-std-X"        "tBodyAccJerk-std-Y"        "tBodyAccJerk-std-Z"       
[19] "tBodyGyro-mean-X"          "tBodyGyro-mean-Y"          "tBodyGyro-mean-Z"         
[22] "tBodyGyro-std-X"           "tBodyGyro-std-Y"           "tBodyGyro-std-Z"          
[25] "tBodyGyroJerk-mean-X"      "tBodyGyroJerk-mean-Y"      "tBodyGyroJerk-mean-Z"     
[28] "tBodyGyroJerk-std-X"       "tBodyGyroJerk-std-Y"       "tBodyGyroJerk-std-Z"      
[31] "tBodyAccMag-mean"          "tBodyAccMag-std"           "tGravityAccMag-mean"      
[34] "tGravityAccMag-std"        "tBodyAccJerkMag-mean"      "tBodyAccJerkMag-std"      
[37] "tBodyGyroMag-mean"         "tBodyGyroMag-std"          "tBodyGyroJerkMag-mean"    
[40] "tBodyGyroJerkMag-std"      "fBodyAcc-mean-X"           "fBodyAcc-mean-Y"          
[43] "fBodyAcc-mean-Z"           "fBodyAcc-std-X"            "fBodyAcc-std-Y"           
[46] "fBodyAcc-std-Z"            "fBodyAccJerk-mean-X"       "fBodyAccJerk-mean-Y"      
[49] "fBodyAccJerk-mean-Z"       "fBodyAccJerk-std-X"        "fBodyAccJerk-std-Y"       
[52] "fBodyAccJerk-std-Z"        "fBodyGyro-mean-X"          "fBodyGyro-mean-Y"         
[55] "fBodyGyro-mean-Z"          "fBodyGyro-std-X"           "fBodyGyro-std-Y"          
[58] "fBodyGyro-std-Z"           "fBodyAccMag-mean"          "fBodyAccMag-std"          
[61] "fBodyBodyAccJerkMag-mean"  "fBodyBodyAccJerkMag-std"   "fBodyBodyGyroMag-mean"    
[64] "fBodyBodyGyroMag-std"      "fBodyBodyGyroJerkMag-mean" "fBodyBodyGyroJerkMag-std" 


### All transformations:

The script "run_analysis.R" performs the following transformations on the original dataset:

* Step 1: merge the training and testing data

	The script reads training data: "subject_train.txt", "X_train.txt", "y_train.txt", and testing data: "subject_test.txt", "X_test.txt", "y_test.txt", into the memory. After that, it combines the training and testing data into a set of new data frames: "all_subject", "all_X", "all_y". The size of each the above data frame is shown in the following table:
	
    |TrainData [Size]       |TestData [Size]       |MergedData [Size]     |
	|:---------------------:|:--------------------:|:--------------------:|
	|subject_train [7352\*1]|subject_test [2947\*1]|all_subject [10299\*1]|
	|X_train [7352\*561]    |X_test [2947\*561]    |all_X [10299\*561]    |
    |y_train [7352\*1]      |y_test [2947\*1]      |all_y [10299\*1]      |



* Step 2: extracts only the measurements on the mean and standard deviation for each measurement

	Originally, the data frame "all_X" contains 561 columns, each of which refer to an unique type of measurement. The name of all those measurements are recorded in data "features.txt". In this step, we load "feature.txt" into the memory, and extract only the measurements that are related to "mean" and "standard deviation". After extraction, the resulted data frame "all_X" contians 10299 rows and 66 columns, and "features" contains the names of 66 measurements. 
    

* Step 3: uses descriptive activity names to name the activities in the data set
	
    "all_y" refers to the ID of activities, the name of which are stored in file "activity_labels.txt". We read this file, and replace the activity ID with its name. Hence, the element of data frame "all_y" is converted from numeric to factor. 
    
    
* Step 4: appropriately labels the data set with descriptive variable names

	In this step, "all_subject", "all_X" and "all_y" is combined to a new data frame called "my_data" using column-bind. There are 10299 rows and 68 columns in "my_data". The first column is the subject ID, the second column is the activity name, and all the other columns are measurements that are related to "mean" and "standard deviation". The column names of "my_data" is set to be "subject", "activity" and the extracted measurement names stored in data frame "features". This merged data "my_data" is stored in file "merged_data_set.txt".
   
   
* Step 5: from the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject

	The generated dity data set is named as "my_data2" which contains 180 rows and 68 columns. The first column is the subject ID, the second column is the acitivity name, and column 3 to column 68 are the averaged values of the corresponding meansurements. This new data set is stored in file "averaged_data_set.txt".

