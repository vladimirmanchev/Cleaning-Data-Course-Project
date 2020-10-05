#checks whether the folder "data" exist. If not creates it
if (!file.exists("./data")) {dir.create("./data")}

#downloads the files
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/smartphone.zip")

#loads the necessary packages
library(dplyr)

#provides a list of the files contained in the zip folder
unzip("./data/smartphone.zip", list = TRUE)

#reads the data into R
test_measurements <- read.table(unz("./data/smartphone.zip", "UCI HAR Dataset/test/X_test.txt"))
test_activity <- read.table(unz("./data/smartphone.zip", "UCI HAR Dataset/test/y_test.txt"))
test_subjects <- read.table(unz("./data/smartphone.zip", "UCI HAR Dataset/test/subject_test.txt"))
train_measurements <- read.table(unz("./data/smartphone.zip", "UCI HAR Dataset/train/X_train.txt"))
train_activity <- read.table(unz("./data/smartphone.zip", "UCI HAR Dataset/train/y_train.txt"))
train_subjects <- read.table(unz("./data/smartphone.zip", "UCI HAR Dataset/train/subject_train.txt"))
measurements <- read.table(unz("./data/smartphone.zip", "UCI HAR Dataset/features.txt"))
activities<-read.table(unz("./data/smartphone.zip", "UCI HAR Dataset/activity_labels.txt"))

#assigns the names to the measurements in _measurements tables from the features file
namescols<-as.character(measurements[,2])
colnames(test_measurements)<-namescols
colnames(train_measurements)<-namescols

#assigns names to _activity and _subject
names(test_subjects)<-"subjects"
names(train_subjects)<-"subjects"
names(test_activity)<-"activity"
names(train_activity)<-"activity"

#adds _subject and _activity to _measurement tables
test_full <- cbind(test_subjects, test_activity, test_measurements)
train_full <- cbind(train_subjects, train_activity, train_measurements)

#adds train table to test table
train_and_test<-rbind(test_full, train_full)

#creates a logical vector indicating which column contain the mean and std variables
mean_sd<-grepl("*mean|*std", colnames(train_and_test))

#extracts only the columns that contains mean and std from the full data
only_mean_std<-select(train_and_test, subjects, activity, which(mean_sd))

#replaces the activity code with the actual name of the activity performed
#merge the data table with the table assign the names of activities to the code. As result activity
#column in data table is replaced with the name of the activity
only_mean_std<-merge(activities, only_mean_std, by.x = "V1", by.y = "activity")

#we end-up with a extra column that still contains the coded activity. We do not need it anymore
#so we remove it
only_mean_std<-select(only_mean_std, -(V1))

#we rename the column containing the activity name back to "activity"
colnames(only_mean_std)[1] <- "activity"

#group the data with the meands and std by activity and subjects
grouped_activity_subject<-group_by(only_mean_std, activity, subjects)

#create a new table containing the average of all values for each activity and subject
tidydata<-summarise_all(grouped_activity_subject, list(mean))

#write the tidydata into a file
write.table(tidydata, file = "tidydata.txt")

