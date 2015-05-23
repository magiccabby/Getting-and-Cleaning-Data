# Getting and Cleaning Data Course Project
-------
This is a repository for the course project of "Getting and Cleaning Data" through Johns Hopkins University.

### Files

* "CodeBook.md" describes the variables, the data, and any transformations or work that have been performed to clean up the data.

* "run_analysis.R" contains the R script for performing anaylysis in 5 steps.

* "merged_data_set.txt" contains the data set that has been merged from training and testing data in step 4.  

* "averaged_data_set.txt" contains the tidy data set generated in step 5, with the average of each variable for each activity and each subject.


### How dose it work

* Download and unzip the original data set (https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) into a folder on your local drive, say "mydir/UCI HAR Dataset/".


* Copy "run_analysis.R" in to folder "mydir/UCI HAR Dataset/".


* Open RStudio and input the following two commands:

	setwd("mydir/UCI HAR Dataset/")
	
    	source("run_analysis.R")
    
* Read the generated tidy data set by inputting this command in RStudio: 
	 
    	my_data <- read.table("averaged_data_set.txt", head = TRUE)
