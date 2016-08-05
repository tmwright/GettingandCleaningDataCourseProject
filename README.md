# Getting and Cleaning Data Course Project
Tod Wright 5 August 2016

## Introduction

This repository contains material for the Coursera Getting and Cleaning Data Course Project.  The file `run_analysis.R` is an `R` script that processes the "raw" Samsung HAR data set from the UC Irvine Machine Learning Repository.  It produces an appropriately labeled data frame of mean and standard deviation measurements for each combination of subject and activity in the data set.  The rationale behind the choice of measurement variables considered is discussed below, and the naming scheme used is detailed in the file `CodeBook.md`.  The final result of the script is a tidy data set that summarizes each measurement considered for each subject-activity observation pair.  The script writes this tidy data set to a (space-separated) text file `TidyData.txt`, which was submitted to the course website.


## Data Processing

### Step 1: Merge the training and test sets to create one data set.
This step is fairly straightforward and reasonably self-explanatory. It is assumed that the `UCI HAR Dataset/` directory has been unpacked as a subdirectory of the current working directory.  If this directory is not present the script downloads the data and unpacks it.  The script loads the train and test measurements from files `X_train.txt` and `X_test.txt`, and joins them with the subject ID numbers, which are stored in files `subject_train.txt` and `subject_test.txt`, respectively.

Note that, whereas the assignment specification requires only that the measurement variables be given descriptive names in step 4, our script labels all variables in the train and test sets with the names given in `features.txt` before joining them together.  As such, we work with fully labeled data frames right from the start, though the variables retained in step 2 are subsequently given more descriptive names in step 3.

We note also that the subject labels for the train and test sets are loaded from files `subject_train.txt` and `subject_test.txt`, respectively, and bound to the train and test data frames before the two are joined into a single data frame `df`.

### Step 2: Extract only the measurements of the mean and standard deviation for each measurement.
Here we select only the variable columns that contain the mean or standard deviation of measurements.  We are therefore faced with the question of whether to consider only those variables that contain `mean()` or `std()`, or whether to include variables in which `mean` otherwise appears.  We have chosen the former option, for the following reason.  The data set contains both time- and frequency-domain measurements, which are, in the original naming convention, prefixed by a "`t`" or "`f`", respectively.  In each case, there is both a `...mean()...` and a `...std()...` variable.  Although the time and frequency representations are of course not independent, they can be regarded as essentially distinct measurements, and the means (and standard deviations) of the signal in each of the two representations provide complementary information in each case.  Additional summaries of the frequency-domain measurements are given by variables with names `...meanFreq()...`, however, *these are not simple means but rather weighted averages of the frequency components present in the measurements*.  As such, there are no "standard deviation" variables corresponding to these "means".  We therefore neglect the `...meanFreq()...` variables in our analysis.

Similarly, there are variables with names `angle(...Mean,...)`, etc, but these refer to angles between means of measurements and other measurements, rather than simple means.  Again, these quantities are not accompanied by corresponding `...std()...` variables, and we neglect them, restricting our attention to pairs of `...mean()...` and `...std()...` measurements.

The measurement variables of interest can therefore be selected using a simple regexp pattern.  As we have already labeled the columns with the provided feature names in step 1, this selection is performed using `grep` directly on the vector `names(df)` of column names.  The data frame is then subsetted to include only these variable columns, together with the "observation" columns `Subject` and `Activity`.

### Step 3: Use descriptive activity names to name the activities in the data set.
Following the processing undertaken in steps 1 and 2, the `Activity` column of the data frame `df` contains the numeric IDs of the six activities considered in the data set.  The file `activity_labels.txt` contains text labels corresponding to these numeric IDs.  These provided text labels are all uppercase and two of them contain underscores, so after loading the table of ID numbers and the corresponding labels into a new data frame, we perform some simple substitutions to convert the labels to lower case, and replace underscores with spaces.

We then use the `merge()` function to join this table to the existing data frame.  The join is performed on the column of numeric activity IDs.  After the join is complete, this column of numeric IDs remains in the data frame, and so we use the `subset()` function to remove this redundant information.

### Step 4: Appropriately label the data set with descriptive variable names.
At this point the variables selected in step 2 are labeled by the names provided in `features.txt`, which we attached to the data set in step 1.  However, these supplied variable names are given in an abbreviated form.  For example, `tBodyAcc-mean()-X` labels the mean of the time-domain signal of acceleration of the body along the X dimension.  A more appropriate approach to labeling of variables would strive to be human readable.  For example, as noted in reference [1], a variable name such as `AgeAtDiagnosis` is preferable to a more compact but less readable abbreviated label such as `ADx`.  We therefore expand the abbreviated labels from `features.txt` into longer, more readable variable names.

The format of the names for the variables selected in step two is explained in the file  is as follows.  Each variable name:
* Begins with either a "`t`" or an "`f`", indicating a time-domain measurement or a Fourier-transformed (frequency-domain) signal, respectively.
* Contains either "`Body`" or "`Gravity`", indicating a measurement of the motion of the body or a component of motion attributed to gravity, respectively. (Note that in six cases "`Body`" is duplicated in the original variable name, presumably in error.)
* May contain "`AccJerk`" or simply "`Acc`", indicating the linear jerk or acceleration, respectively.
* May contain "`GyroJerk`" or simply "`Gyro`", indicating the angular jerk or angular velocity, respectively.
* Either ends with "`-X`", "`-Y`", or "`-Z`", indicating a measurement along one of the coordinate axes, or contains "`Mag`", indicating the magnitude of a vectorial quantity.
* Contains either "`mean()`" or "`std()`", indicating a mean or standard deviation, respectively.

We replace these with longer, more easily readable variable names, according to the following convention:
* Names begin with either "`MeanOf`" or "`StdDevOf`", in the case of a mean or standard deviation, respectively.
* This is then followed by "`Fourier`" in the case of a frequency domain quantity.  The absence of this string indicates a direct (time-domain) measurement.
* The type of motion referred to is then indicated by either "`Body`" or "`Gravitational`".
* This is then followed by one of "`Acceleration`", "`Jerk`", "`AngularVelocity`", or "`AngularJerk`".
* Finally, the variable names end with either "`AlongX`" or "`AroundX`" (or the analogous strings involving "`Y`" and "`Z`") in the case of vector components of a linear or angular quantity, respectively, or with "`Magnitude`" in the case of a vector magnitude measurement.

These replacements are made in `run_analysis.R` by defining a list of two-element vectors, containing regexp strings that match to the variable names and replacements for them.  The script then simply loops over each of these "pairs" and performs the appropriate replacement using the function `sub()`.  A detailed list of the resulting variables is given in the accompanying file `CodeBook.md`.


### Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject.
Here we create a tidy data set containing the mean of each of the variables selected in step 3, for each combination of subject and activity.  Although there are multiple possible formattings of the dataset that could be considered "tidy", we will consider in particular the so-called "wide" format [2], in which each measured variable appears in its own column, whereas observations are sorted into rows by the values of the "fixed" variables `Subject` and `Activity`.  In particular, each row of the tidy data frame corresponds to a distinct pair of `Subject` and `Activity` values, and contains a summary value for each of the measured variables.

Constructing this tidy data frame is performed in `run_analysis.R` using the `dplyr` package.  After creating a `dplyr` "`tbl`" form of the data frame, the `group_by` function is used to group by `Subject` and `Activity`.  Using the "chaining" functionality of `dplyr`, we then apply the function `summarize_each()`, which respects the grouping imposed on the data frame, to create a table of summary statistics (in this case, the mean) for each of the measured variables.  The final form of this data frame is therefore analogous to, e.g., Table 3 of reference [2], albeit with many more columns of variables.  That is to say, each variable forms a column and each observation forms a row of a single table, which corresponds to a single type of observational unit (measurements of motion) [2] — i.e., the data is tidy.

The data set is then written to disk using `write.table()`, and the resulting text file `TidyData.txt` was submitted to the Coursera website.


## Reading the tidy dataset
As the tidy data set is written using `write.table()` with the option `row.names=FALSE` and otherwise default settings, given the path `file_path` to the file, the tidy data can be read into `R` with, e.g., the command

    data <- read.table(file_path, header=TRUE)

whereafter it can be viewed using, e.g., the `R` command `View(data)`.


## Bibliography
[1] [Leek group data sharing guide](http://github.com/jtleek/datasharing)

[2] H. Wickham, [Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf), Journal of Statistical Software **59**, 1 (2014).
