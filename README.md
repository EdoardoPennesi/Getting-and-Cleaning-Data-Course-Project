# Getting-and-Cleaning-Data-Course-Project
this repository contains the following files:
* run_analysis.R: that contains the script to reproduce the nalysis
* README.md: providing additional info about the R code
* code book: describing the variables

The run_analysis.R script performs the following actions:
* load the library(dplyr)
* download the data from  "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" and unzip the files
* Creates a set of variables by assigning the data contained the original datasets to specific variables usinf the name() function
* Merges the training and the test sets to create one data set using the row bind and column bind functions
* For each measure contained in the merged dataset the code selects the mean and standard deviation using the "select" function in dplyr package
* It relaces the value in the column "code" with descriptive activity names
* It labels the name of the variable with names that are easier to read and to type for further analysis
* From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity 
and each subject, with write.table() using row.name=FALSE
