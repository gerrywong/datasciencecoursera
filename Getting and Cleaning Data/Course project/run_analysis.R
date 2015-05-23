# Course Project for Getting and Cleaning Data (getdata-014) on Coursera.org
# Course code	:	getdata-014
# Date			:	Saturday 23 May 2015
# Author		:	Dr. Maikel P.H. Verouden
	
# Course Project requirement
# --------------------------
# Create one R script called run_analysis.R that does the following:
#   1.  Merge the training and the test sets to create one data set.
#   2.  Extract only the measurements on the mean and standard deviation for
#       each measurement
#   3.  Uses descriptive names to name the activities in the data set
#   4.  Appropriately label the data set with descriptive variable names
#   5.  From the data set in step 4, create a second, independent tidy data set
#       with the average of each variable for each activity and each subject
# --------------------------
# First obtain the data
# If directory "data" doesn't exist create it in the current working directory
if (!file.exists("data")) {
    dir.create("data")
}
# Create fileUrl with the download location in order to download the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI%20HAR%20Dataset.zip"
# Download the Course Project data
download.file(fileUrl, destfile = "./data/UCI HAR Dataset.zip", method = "curl", mode = "wb")
# Unzip the "UCI Har Dataset.zip" into the data directory of the currrent
# working directory. A directory "./data/UCI HAR Dataset/" will be created.
unzip("./data/UCI HAR Dataset.zip", exdir = "./data/")

# Check for packages required in this run_analysis.R script and install them
# if necessary
if(!("dplyr" %in% rownames(installed.packages()))) {
    install.packages("dplyr")
}
if(!("reshape2" %in% rownames(installed.packages()))) {
    install.packages("reshape2")
}
# Load required packages
require("dplyr")
require("reshape2")

# After obtaining and unzipping load the data set into R
# Load features.txt containing the features/column or variable names of X_test
# and X_train
features <- as.vector(read.table("./data/UCI HAR Dataset/features.txt", col.names = c("index","variable_name"))[,2])
# Load activity_labels.txt containing the representation of each activity_id
activity_labels <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("activity_id","activity"))

# Load training data set
# Load subject_train.txt containing the subject_id of the rows in X_train
subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject_id")
# Load y_train.txt containing the activity_id of the rows in X_train
y_train <- read.table("./data/UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")
# Load X_train containing the train data set
X_train <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
# Add the features/column or variable names to the columns of X_train
colnames(X_train) <- features

# Load the test data set
# Load subject_test.txt containing the subject_id of the rows in X_test
subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject_id")
# Load y_test.txt containing the activity_id of the rows in X_test
y_test <- read.table("./data/UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")
# Load X_test containing the test data set
X_test <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
# Add the features/column or variable names to the columns of X_test
colnames(X_test) <- features

#   Step 1
# Merge the training and the test sets to create one data set
# Merge subject_train [7352 x 1] and subject_test [2947 x 1] into subject
# [10229 x 1], which contains the subject_id of each row in X
subject <- rbind(subject_train,subject_test)
# Merge y_train [7352 x 1] and y_test [2947 x 1] into y [10299 x 1], which
# contains the activity_id of each row in X
y <- rbind(y_train,y_test)
# Merge X_train [7352 x 561] and X_test [2947 x 561] into X [10299 x 561]
# which contains the measured features [561] for all subjects and activities
X <- rbind(X_train,X_test)

#   Step 2
# Extract only the features containing mean() or std()
selected_features <- grep("mean\\(\\)|std\\(\\)",features)

#   Step 3
# Using y and the activity_labels to create a column of activity descriptions
activity <- y %>% left_join(activity_labels) %>% select(activity)
# Write the tidy data set to tidy_data.txt
write.table(bind_cols(subject,activity,X), file = "./data/UCI HAR Dataset/tidy_data.txt", row.names = FALSE)

#   Step 4
# Appropriate labeling the data set with descriptive variable names has already
# been performed while loading the data by assignment of column names.
# Create a subsetted data set containing only the features with mean() or std()
# This subset named tidy_data [10299 x 68] with colnames:subject_id,activity,
# and features[selected_features]. Sort tidy_data by subject_id and activity.
subset_tidy_data <- arrange(bind_cols(subject,activity,X[,selected_features]),subject_id,activity)
# Write the subsetted tidy data set to subset_tidy_data.txt
write.table(subset_tidy_data, file = "./data/UCI HAR Dataset/subset_tidy_data.txt", row.names = FALSE)

#   Step 5
# Create a second independent tidy data set with the average of each variable
# for each activity and each subject. First melt the data
melted_data <- melt(subset_tidy_data, id = c("subject_id","activity"), measure.vars = features[selected_features])
# Apply mean function to melted_data set using dcast function
subset_tidy_data_means <- dcast(melted_data, subject_id + activity ~ variable, mean)
write.table(subset_tidy_data_means, file = "./data/UCI HAR Dataset/subset_tidy_data_means.txt", row.names = FALSE)

# Unload the required packages
detach("package:dplyr", unload = TRUE)
detach("package:reshape2", unload = TRUE)

# Clear History
clearhistory <- function() {
    write("", file=".blank");
    loadhistory(".blank");
    unlink(".blank")
}
clearhistory()

# Clear Environment
rm(list=ls())