---
title: "Code Book"
output: html_document
---

## Data

This tidy data represents the average per subject and per activity of the means and standard deviation a number of different readings from an accelerometer in a Samsung Galaxy S smartphone. 

## Variables

Most variables are taken from the original data. The description of what they represent how they were calculated can be found in the "features_info.txt" which is part of the original zip folder. In short these variables represent readings from the accelerometer of a Samsung Galaxy S smartphone. These reading were recorded during 6 activities performed by 30 volunteers.

activity - activity associated with the given reading  
subjects - the id of the subject performing the given activity for a given reading  

## Data manipulation

The original data was split between a training set and a test set. Each set had the reading of the accelerometer and the derived variables (561 in total) (X_test and X_train), the activity performed(y_test and y_train), and the subject performing the activity (subject_test and subject_train). These data were contained in 3 different files per set(indicated in parantese). 

The first step was to read all these files in R using the read.table function. The variable names for the accelerometer readings are contained in a separate file - "features.txt". The names of the variables were appended to the readings using the colnames function. Next the activities and subjects were appended to the readings using the cbind function creating a full data for each 
set. The full test and train data sets were merged using the rbidn function, at the end of this step we have the full data with colnames and both the activity and the subjects for each reading.

Next we take only the columns from this full data that contain the means and the standard deviations. To do this we first create a logical vector that tell us which columns contaion the words "mean" and "std" using the grepl function. Next we use this logical vector as an argument to the select function from the dplyr package to extract only the desired columns.

However in this new data frame, each activity is number coded and we would like to replace the code with the 'human readable' values. To achieve this we read in R the table containing the activity labels from the "activity_labels.txt". Then we use the merge function on the full data and the activity labels. By merging on the activity column in each data, the resulting data frame has replaced all activity codes with the corresponding activity labels. All that we need to do is remove the extra column introduced by this merge.

Now we can group the data by activity and subject using the group_by function in the dplyr package. Then we use the summarize_all function along side the mean function to get a table containing the average of each value per activity and subject. What is left is to write this data into a file using the write.table function.
