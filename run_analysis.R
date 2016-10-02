#-----------------------------------------
## Step 1: download the data and unzip it
#-----------------------------------------

# checking if the folder 'data' exists or not, if not create it
if(!file.exists("./data")){dir.create("./data")}
# download data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./data/Dataset.zip")
# unzip the zipped data
unzip(zipfile="./data/Dataset.zip",exdir="./data")

#--------------------------------------------
## Step 2: reading training and test data sets
#--------------------------------------------

# read the training data - subject (subject_train), training data set (X_train) and activities performed (y_train)
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
# read the test data - (subject_test), test data set (X_test) and activities performed (y_test)
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt")

#---------------------------------------------------------------------------------------------
## Step 3: merging the training and test data sets to create a one data set and labeling with 
## appropriate readable variable names
#---------------------------------------------------------------------------------------------

# Merging training an test data sets
X <- rbind(X_train,X_test)
# Giving the columns for corresponding subjects and their corresponding activities
subject <- rbind(subject_train, subject_test)
y <- rbind(y_train, y_test)
data <- cbind(subject, y, X)
# giving readable variable (column) names for the merged data set
features <- read.table("./data/UCI HAR Dataset/features.txt")
features<-as.vector(features[,2])
features <- gsub("-","",features)
features <- gsub("mean","Mean",features)
features <- gsub("std","Std",features)
features <- gsub("\\(\\)","",features)
names(data) <- c("subject", "activity", features)

#-----------------------------------------------------------------------------------------------------
## Step 4: Extracting only the measurements on the mean and standard deviation for each measurement.
## Note that this extracted data set maintains the same readable variable (column) names as in Step 3.
#-----------------------------------------------------------------------------------------------------
meanStdCols <- grep("[mM]ean|[sS]td.",names(data))
selectedData <- data[c(1,2,meanStdCols)]

#----------------------------------------------------------------------------------
## Step 5: Giving descriptive activity names to name the activities in the data set
#----------------------------------------------------------------------------------

library(dplyr)
#selectedData <- mutate(selectedData, activity = ifelse(activity==1,"WALKING",ifelse(activity == 2, "WALKING_UPSTAIRS",ifelse(activity ==3, "WALKING_DOWNSTAIRS", ifelse(activity == 4, "SITTING", ifelse(activity == 5, "STANDING","LAYING"))))))
selectedData <- mutate(selectedData, activity = factor(activity, 1:6, labels = c("WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING")))

#---------------------------------------------------------------------------------
## Step 6: Creating an independent tidy data set with the average of each variable
## for each activity and each subject.
#---------------------------------------------------------------------------------

# grouping by the subjects and activities
grouped_selectedData <- group_by(selectedData, subject, activity)
## summarize(grouped_selectedData,tBodyAccMeanX = mean(tBodyAccMeanX))
# summarizing with the average of each variable for each activity and each subject
summaryAvgData <- summarize_each(grouped_selectedData, funs(mean))
# converting into data frame.
summaryAvgData_df <- as.data.frame(summaryAvgData)

#-----------------------------------------------------------------------------------
## Step 7: Saving the final tidy summary data into a file named "summaryAvgData.txt"
#-----------------------------------------------------------------------------------

write.table(summaryAvgData_df, "summaryAvgData.txt", row.name=FALSE)



