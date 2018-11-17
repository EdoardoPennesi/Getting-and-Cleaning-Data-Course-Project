
# LOADING THE NECESSARY LIBRARY

library(dplyr)
getwd()

# GETTING THE DATA

filename <- "Getting and Cleaning Data Course Project"
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

download.file(fileURL, filename, method="curl")

unzip(filename)

#TIDYING THE DATA

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")



X <- rbind(x_train, x_test)
Y <- rbind(y_train, y_test)
subjects <- rbind(subject_train, subject_test)
Merged_df <- cbind(subjects, Y, X)

measures_selected <- Merged_df %>% select(subject, code, contains("mean"), contains("std"))

measures_selected$code <- activities[measures_selected$code, 2]


names(measures_selected)[2] = "activity"
names(measures_selected)<-gsub("Acc", "accelerometer", names(measures_selected))
names(measures_selected)<-gsub("Gyro", "gyroscope", names(measures_selected))
names(measures_selected)<-gsub("BodyBody", "body", names(measures_selected))
names(measures_selected)<-gsub("Mag", "magnitude", names(measures_selected))
names(measures_selected)<-gsub("^t", "time", names(measures_selected))
names(measures_selected)<-gsub("^f", "frequency", names(measures_selected))
names(measures_selected)<-gsub("tBody", "TimeBody", names(measures_selected))
names(measures_selected)<-gsub("-mean()", "mean", names(measures_selected), ignore.case = TRUE)
names(measures_selected)<-gsub("-std()", "std", names(measures_selected), ignore.case = TRUE)
names(measures_selected)<-gsub("-freq()", "frequency", names(measures_selected), ignore.case = TRUE)
names(measures_selected)<-gsub("angle", "angle", names(measures_selected))
names(measures_selected)<-gsub("gravity", "gravity", names(measures_selected))

data <- measures_selected %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))

write.table(data, "FinalData.txt", row.name=FALSE)



