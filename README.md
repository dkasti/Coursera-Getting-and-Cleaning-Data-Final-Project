# Coursera-Getting-and-Cleaning-Data-Final-Project

## Introduction
This work is based on "Human Activity Recognition Using Smartphones Dataset
Version 1.0" by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto, Smartlab - Non Linear Complex Systems Laboratory,
DITEN - Universit‡ degli Studi di Genova. www.smartlab.ws.

This repo has an R script file 'run_analysis.R' that performs all the tasks as directed in the description of the project. That is, it performs following steps:

* Step 1: downloading the original data on "Human Activity Recognition Using Smartphones Dataset
Version 1.0" by Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio and Luca Oneto, Smartlab - Non Linear Complex Systems Laboratory and unzipping it in the folder './data'. 
* Step 2: reading training and test data sets from the files 'X_train.txt' and 'X_test.txt' in the variables X_train and X_test.
* Step 3: merging the training and test data sets to create a one data set and labeling with appropriate readable variable names. Those variable names come directly from a file 'features.txt' included in the original data set. Moreover, the corresponding subjects and the activities are also appended as first and second row in this new merged data table with the column names 'subject' and 'activity' which were read from the merged version of the files 'subject_train.txt' and 'subject_test.txt', and the merged version of the files 'y_train.txt' and 'y_test.txt' repectively. This new data table si named as 'data'.
* Step 4: Extracting only the measurements on the mean and standard deviation for each measurement. Note that this extracted data set maintains the same readable variable (column) names as in Step 3. This new extracted data table is named as 'selectedData'.
* Step 5: The data table selectedData is modified giving descriptive activity names to name the activities in the data set. Instead of giving the codes for the six different types of activities, those codes now replaced by their actual names: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING.
* Step 6: Creating an independent tidy grouped data table named 'summaryAvgData' by taking the average of each variable for each activity and each subject, which coerced into the class of data frame (for better output into a file).
* Step 7: Saving the final tidy summary data 'summaryAvgData' into a file named "summaryAvgData.txt"

