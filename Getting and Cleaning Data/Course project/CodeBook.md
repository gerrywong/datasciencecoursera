##Codebook for the Course Project of Getting and Cleaning Data
Course Code: getdata-014<br />
Date: Saturday 23 May 2015<br />
Author: Dr. Maikel P.H. Verouden
 
##Project Description
[Getting and Cleaning Data](https://www.coursera.org/course/getdata) is a Massive Open Online Course (a.k.a. *MOOC*) in the [Data Science Specialization](https://www.coursera.org/specialization/jhudatascience/1?utm_medium=courseDescripTop) on [Coursera.org](https://www.coursera.org).

The 3<sup>rd</sup> week of the Getting and Cleaning Data course contains a Course Project, which is peer assessed. The purpose of this project is to demonstrate to ability to collect, work with, and clean a data set. The goal is to prepare a tidy data that can be used for later analysis.
 
##Study design and data processing
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz have been captured. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See `features_info.txt` inside the downloaded data in the `./data/UCI HAR Dataset`-directory for more details.

Check the `README.txt`-file inside the `./data/UCI HAR Dataset`-directory for further details about this dataset.

A video of the experiment including an example of the 6 recorded activities with one of the participants can be seen in the following link: [http://www.youtube.com/watch?v=XOEN9W05_4A](http://www.youtube.com/watch?v=XOEN9W05_4A)

###Collection of the raw data
The raw data was downloaded via a link provided in the Course Project assignment: [https://d396qusza40orc.cloudfront.net/getdata/projectfiles/UCI HAR Dataset.zip](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip).<br />
The original source of the data is: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

###Notes on the original (raw) data
####Attribute Information
For each record in the dataset it is provided:

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.

- Triaxial Angular velocity from the gyroscope. 

- A 561-feature vector with time and frequency domain variables. 

- Its activity label. 

- An identifier of the subject who carried out the experiment.

####Files incluced in the data set
- `README.txt`

- `features_info.txt`: Shows information about the variables used on the feature vector.

- `features.txt`: List of all features.

- `activity_labels.txt`: Links the class labels with their activity name.

- `train/X_train.txt`: Training set.

- `train/y_train.txt`: Training labels.

- `test/X_test.txt`: Test set.

- `test/y_test.txt`: Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- `train/subject_train.txt`: Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- `train/Inertial Signals/total_acc_x_train.txt`: The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the `total_acc_x_train.txt` and `total_acc_z_train.txt` files for the Y and Z axis. 

- `train/Inertial Signals/body_acc_x_train.txt`: The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- `train/Inertial Signals/body_gyro_x_train.txt`: The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 
 
##Creating the tidy data file
 
###Guide to the tidy data file creation
* Download the `run_anlaysis.R`-script into your preferred R working directory.

* Set the the directory containing `run_analysis.R` as the current working directory using the `setwd()` function.
* Execute `run_analysis.R` by sourcing it or type `source("run_analysis.R")` at the R-command prompt. After execution three new files will have been generated in the `./data/UCI HAR Dataset`-directory:
	1. `tidy_data.txt`

	2. `subset_tidy_data.txt`, and
	3.  `subset_tidy_data_means.txt`.
 
###Cleaning of the data
Upon sourcing the `run_analysis.R`-script or by execution of `source("run_analysis.R")` at the R-command prompt the following steps are performed:

- Check whether there is a `./data`-directory present in the current working directory. If the `./data`-directory is not available one will be created.

- Download the [Course Project data](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) as a `.zip`-file into the `./data`-directory.

- Extract the downloaded `.zip`-file into a subdirectory called `UCI HAR Dataset` of the `./data`-directory.

- Check for packages required in the `run_analysis.R` script and install them if necessary. Subsequently the required packages are loaded into R for use.

- Load all necessary data into R.

- Merge the training and test sets to create one data set. The full data set is saved in the `./data/UCI HAR Dataset`-directory as `tidy_data.txt`.

- Extract only the measurements on the mean and standard deviation for each measurement.

- Create descriptive activity names to name the activities in the data set.

- Appropriately label the data set with descriptive variable names.

- Save the subsetted tidy data set as `subset_tidy_data.txt` in the `./data/UCI HAR Dataset`-directory.

- Create a second, independent tidy data set with the average of each variable for each activity and each subject and save it as `subset_tidy_data_means.txt` in the `./data/UCI HAR Dataset`-directory.

- Clear all entries from the command-history of the current R-session.

- Clear all objects from the workspace.

For a more detailed description of the steps performed by the `run_analysis.R` script, see [README.md](README.md)
 
##Description of the variables in the subset\_tidy\_data\_means.txt file
The generated `subset_tidy_data_means.txt` file contains the average for each activity and each subject of the features/column names that contain `mean()` or `std()` in its name. There are in total 30 subject (`subject_id` is ranging from 1 to 30), that each perform 6 activities (`WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, and `LAYING`, therefore resulting in 180 observations. In the original tidy data there are 66 features/column names that contain `mean()` or `std()` in their name:

1. tBodyAcc-mean()-X
2. tBodyAcc-mean()-Y
3. tBodyAcc-mean()-Z
4. tBodyAcc-std()-X
5. tBodyAcc-std()-Y
6. tBodyAcc-std()-Z
7. tGravityAcc-mean()-X
8. tGravityAcc-mean()-Y
9. tGravityAcc-mean()-Z
10. tGravityAcc-std()-X
11. tGravityAcc-std()-Y
12. tGravityAcc-std()-Z
13. tBodyAccJerk-mean()-X
14. tBodyAccJerk-mean()-Y
15. tBodyAccJerk-mean()-Z
16. tBodyAccJerk-std()-X
17. tBodyAccJerk-std()-Y
18. tBodyAccJerk-std()-Z
19. tBodyGyro-mean()-X
20. tBodyGyro-mean()-Y
21. tBodyGyro-mean()-Z
22. tBodyGyro-std()-X
23. tBodyGyro-std()-Y
24. tBodyGyro-std()-Z
25. tBodyGyroJerk-mean()-X
26. tBodyGyroJerk-mean()-Y
27. tBodyGyroJerk-mean()-Z
28. tBodyGyroJerk-std()-X
29. tBodyGyroJerk-std()-Y
30. tBodyGyroJerk-std()-Z
31. tBodyAccMag-mean()
32. tBodyAccMag-std()
33. tGravityAccMag-mean()
34. tGravityAccMag-std()
35. tBodyAccJerkMag-mean()
36. tBodyAccJerkMag-std()
37. tBodyGyroMag-mean()
38. tBodyGyroMag-std()
39. tBodyGyroJerkMag-mean()
40. tBodyGyroJerkMag-std()
41. fBodyAcc-mean()-X
42. fBodyAcc-mean()-Y
43. fBodyAcc-mean()-Z
44. fBodyAcc-std()-X
45. fBodyAcc-std()-Y
46. fBodyAcc-std()-Z
47. fBodyAccJerk-mean()-X
48. fBodyAccJerk-mean()-Y
49. fBodyAccJerk-mean()-Z
50. fBodyAccJerk-std()-X
51. fBodyAccJerk-std()-Y
52. fBodyAccJerk-std()-Z
53. fBodyGyro-mean()-X
54. fBodyGyro-mean()-Y
55. fBodyGyro-mean()-Z
56. fBodyGyro-std()-X
57. fBodyGyro-std()-Y
58. fBodyGyro-std()-Z
59. fBodyAccMag-mean()
60. fBodyAccMag-std()
61. fBodyBodyAccJerkMag-mean()
62. fBodyBodyAccJerkMag-std()
63. fBodyBodyGyroMag-mean()
64. fBodyBodyGyroMag-std()
65. fBodyBodyGyroJerkMag-mean()
66. fBodyBodyGyroJerkMag-std()

### Variable name explanation
The features selected come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3<sup>rd</sup> order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

The set of variables that were estimated from these signals are: 

* mean(): Mean value
* std(): Standard deviation

##Sources
* Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. A Public Domain Dataset for Human Activity Recognition Using Smartphones. 21th European Symposium on Artificial Neural Networks, Computational Intelligence and Machine Learning, ESANN 2013. Bruges, Belgium 24-26 April 2013.
* UCI Machine Learning Repository, Centre for Machine Learning and Intelligent Systems: [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)