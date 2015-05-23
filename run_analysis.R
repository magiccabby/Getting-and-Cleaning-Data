## You should create one R script called run_analysis.R that does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for 
##    each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 
## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.


## 1. Merges the training and the test sets to create one data set.
tmp1 <- read.table("UCI HAR Dataset/train/subject_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/subject_test.txt")
all_subject <- rbind(tmp1, tmp2)
tmp1 <- read.table("UCI HAR Dataset/train/X_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/x_test.txt")
all_X <- rbind(tmp1, tmp2)
tmp1 <- read.table("UCI HAR Dataset/train/y_train.txt")
tmp2 <- read.table("UCI HAR Dataset/test/y_test.txt")
all_y <- rbind(tmp1, tmp2)
rm(tmp1, tmp2)

## 2. Extracts only the measurements on the mean and standard deviation for each 
#   measurement.
features <- read.table("UCI HAR Dataset/features.txt")
ind <- grep("-(mean|std)\\(\\)", features[, 2], ignore.case = TRUE)
features <- features[ind, 2]
features <- gsub("\\(|\\)", "", features)
all_X <- all_X[,ind]


## 3. Uses descriptive activity names to name the activities in the data set
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
all_y <- activities[all_y[, 1], 2]


## 4. Appropriately labels the data set with descriptive variable names. 
my_data <- cbind(all_subject, all_y, all_X)
names(my_data) <- c("subject", "activity", as.character(features))
rm(all_subject, all_y, all_X)
write.table(my_data, "merged_data_set.txt", row.names = FALSE)



## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.
subjects <- unique(my_data$subject)
activities <- activities[,2]
my_data2 <- my_data[1:(length(subjects)*length(activities)), ]

for (i in 1:length(subjects)) {
    for (j in 1:length(activities)) {
        row_num <- (i-1) * length(activities) + j
        my_data2[row_num, 1] <- subjects[i]
        my_data2[row_num, 2] <- activities[j]
        ind <- my_data$subject == subjects[i] & my_data$activity == activities[j]
        my_data2[row_num, 3:ncol(my_data2)] <- colMeans(my_data[ind, 3:ncol(my_data)])
    }
}
write.table(my_data2, "averaged_data_set.txt", row.names = FALSE)





