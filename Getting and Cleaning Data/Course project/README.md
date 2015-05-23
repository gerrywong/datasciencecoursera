#Getting and Cleaning Data - Course Project
[Getting and Cleaning Data](https://www.coursera.org/course/getdata) is a Massive Open Online Course (a.k.a. *MOOC*) in the [Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=courseDescripTop) on [Coursera.org](https://www.coursera.org).

The 3<sup>rd</sup> week of the Getting and Cleaning Data course contains a Course Project, which is peer assessed. The purpose of this project is to demonstrate to ability to collect, work with, and clean a data set. The goal is to prepare a tidy data that can be used for later analysis.

##Data used
One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data, used for this course project, represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

##Files in this repository
This repository contains three files:

1. CodeBook.md
2. README.md
3. run_analysis.R

###CodeBook.md
The codebook describes the variables, the data, and any transformations or work performed to clean up the data and get it into a tidy data set.

###README.md
The readme file is the file you are currently reading. It explains which files are contained within the repository, how they work and how the are connected.

###run_analysis.R
`run_analysis.R` is the actual R-script written for the Course Project. Upon execution it perfroms the following steps:

- Check whether there is a `./data`-directory present in the current working directory. If the `./data`-directory is not available one will be created.

- Downloading of the [Course Project Data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) as a `.zip`-file into the `./data`-directory.
- Extraction of the downloaded `.zip`-file into a subdirectory called `UCI HAR Dataset` of the `./data`-directory.
- Checking for the required `dplyr` and `reshape2` packages and install them if necessary. Subsequently both required packages are loaded into R.
- Loading of all necessary data into R from the `./data/UCI HAR Dataset`-directory:
	- `features.txt` is read into an object `features`, which contains the features/column names for the objects `X_test` and `X_train`. The `features` object is a character vector consisting of 561 strings, with each string representing a feature/column name of the the objects `X_train` and `X_test`. 
	- `activity_labels.txt` is read into an object `activity_labels`. The `activity_labels` object is a data frame with 6 observations and 2 columns (labeled during reading as `activity_id` and `activity`). It serves as a translation table for the `activity_id` in the objects `y_test` and `y_train`. The possible activities are ``  
	- `train/subject_train.txt` is read into an object `subject_train`, which contains the subject identifiers of the rows of the objects `X_train`. The `subject_train` object is a data frame with 7352 observations and 1 column (labeled during reading as `subject_id`).
	- `train/y_train.txt` is read into an object `y_train`, which contains the activity identifiers of the rows of the objects `X_train`. The `y_train` object is a data frame with 7352 observations and 1 column (labeled during reading as `activity_id`).
	- `train/X_train.txt` is read into an object `X_train` and for convenience the `features` object is assigned as column names. The `X_train` object is a data frame with 7352 observations and 561 columns (labeled by the `features` object).
	- `test/subject_test.txt` is read into an object `subject_test`, which contains the subject identifiers of the rows of the objects `X_test`. The `subject_test` object is a data frame with 2947 observations and 1 column (labeled during reading as `subject_id`).
	- `test/y_test.txt` is read into an object `y_test`, which contains the activity identifiers of the rows of the objects `X_test`. The `y_test` object is a data frame with 2947 observations and 1 column (labeled during reading as `activity_id`).
	- `test/X_test.txt` is read into an object `X_test` and for convenience the `features` object is assigned as column names. The `X_test` object is a data frame with 2947 observations and 561 columns (labeled by the `features` object).
- Merging of the training and test sets to create one data set:

	- Row binding of the objects `subject_train` and `subject_test` into an object called `subject`. The `subject` object is a data frame with 10992 observations and 1 column (labeled `subject_id` with subject identifiers of the rows of the object `X`.
	- Row binding of the objects `y_train` and `y_test` into an object called `y`. The `y` object is a data frame with 10299 observations and 1 column (labeled `activity_id`) with activity identifiers of the rows of the object `X`.
	- Row binding of the objects `X_train` and `X_test` into an object called `X`. The `X` object is a data frame with 10299 observations and 561 columns (labeled by the `features` object).
	- Instead of using activities identifiers but rather the activity names themselves in the merged data set, the `y` object has been joined with the `activity_labels` object into an object `activity` using the `left_join()` function from the `dplyr` package. This preserves the order of the activity names as originally specified by the activity identifiers in the `y` object. The `activity` object is a data frame with 10299 observations and 1 column (labeled `activity`). The possible activity names in the `activity` object are specified as: `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`.
	- Column binding of the objects `subject`, `activity` and `X` results in the tidy data set, which is written to a file called `tidy_data.txt` in the `./data/UCI HAR Dataset`-directory without inclusion of the row names.
- Extraction of only the measurements on the mean and standard deviation for each measurement is performed by creation of the object `selected_features` using the `grep()` function on the `features` object. The search string `"mean\\(\\)|std\\(\\)"` ensures that only column numbers are returned that contain either `"mean()"` or `"std()"` in the feature/column name. The `selected_features` object is vector of 66 intergers, with each integer representing a column of object `X` that should be retained.
- Column binding of the objects `subject`,`activity` and `X[,selected_features]` creates a subsetted tidy data set in which only the features/column names containing `mean()` or `std()` are retained. This subsetted tidy data set is stored in an object called `subset_tidy_data` and written to a file `subset_tidy_data.txt` in the `./data/UCI HAR Dataset`-directory without inclusion of row names. The `subset_tidy_data` object is a data frame with 10299 observations and 68 columns (labeled `subject_id`, `activity` and the strings represented by `features[selected_features]`).
- Creation of a second, independent tidy data set with the average of each variable for each activity and each subject is achieved by melting the `subset_tidy_data` object with the `melt()` function using `subject_id` and `activity` as identifiers and `features[selected_features]` as measured variables. The resulting tall and skinny data frame is stored as an object called `melted_data`, which contains 679734 observations and 4 columns (labeled `subject_id`, `activity`, `variable` and `value`). By casting the `melted_data` object using the `dcast()`-function with `subject_id + activity ~ variable` and simultaneously applying the `mean()`-function results in the required second independent tidy data set, that is stored in the `subset_tidy_data_means` object. The `subset_tidy_means` object is a data frame, that contains 180 observations (30 subjects times 6 activities) and 68 columns (labeled `subject_id`, `activity` and the strings represented by `features[selected_features]`). The `subset_tidy_data_means` object is subsequently written into the `./data/UCI HAR Dataset`-directory as `subset_tidy_data_means.txt` with inclusion of row names.
- Clearing of all entries from the command-history of the current R-session.
- Clearing of all objects from the workspace.
- Unloading of the required packages `dplyr` and `reshape2`

##Execution of run_analysis.R
* Download the `run_anlaysis.R`-script into your preferred R working directory.
* Set the the directory containing `run_analysis.R` as the current working directory using the `setwd()` function.
* Execute `run_analysis.R` by sourcing it or type `source("run_analysis.R")` at the R-command prompt. After execution three new files will have been generated in the `./data/UCI HAR Dataset`-directory:
	1. `tidy_data.txt`
	2. `subset_tidy_data.txt`, and
	3.  `subset_tidy_data_means.txt`.

###Dependencies
`run_analysis.R` depends on the `dplyr` and `reshape2` package. The R script checks for their presence, if they are not present the script will automatically install and load them. At the end of the script both packages are unloaded.