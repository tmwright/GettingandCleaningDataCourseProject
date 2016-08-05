######################################################################
### run_analysis.R -- A script to process the UCI HAR Dataset.
### This script:
### 1. Forms a combined data set from the train and test data.
### 2. Extracts mean and standard deviation measurements.
### 3. Gives descriptive names to the activity categories considered.
### 4. Gives descriptive names to the extracted measurement variables.
### 5. Creates a tidy data set containing the average of each
###    measurement variable for each subject and each activity.
### Tod Wright 5 August 2016
######################################################################


# Load the dplyr package, which we will use to create the tidy dataset
# in step 5.
library(dplyr)


######################################################################
## 1. Merge the training and the test sets to create one data set.
######################################################################

# Download and unpack the data set, if necessary
if (!file.exists("UCI HAR Dataset/")) {
    fileUrl <- paste("http://d396qusza40orc.cloudfront.net/",
                     "getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset",
                     ".zip", sep="")
    zipfile <- "UCI_HAR_Dataset.zip"
    download.file(fileUrl, destfile=zipfile, method="curl")
    unzip(zipfile)
}

# Load the raw train and test data sets
train <- read.table("UCI HAR Dataset/train/X_train.txt")
test <- read.table("UCI HAR Dataset/test/X_test.txt")

# Add the provided variable names to the train and test sets.
# (Although we are not required to label the variables until step 4,
# this way we can work with labeled data right from the start.
# The variables retained in step 2 will be relabeled with more
# descriptive names in step 4.)
feature_names <- read.table("UCI HAR Dataset/features.txt")
names(train) <- feature_names$V2
names(test) <- feature_names$V2

# Load the subject labels for both the train and test sets, and
# bind them to the existing train and test data frames.
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
train <- cbind(subject_train, train)
test <- cbind(subject_test, test)
names(train)[1] <- "Subject"
names(test)[1] <- "Subject"

# Load the activity ID numbers for both the train and test sets,
# and bind them to the existing train and test data frames.
# In each case we label this additional column "Activity" now,
# though the ID numbers will be replaced with descriptive names
# in step 3.
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
train <- cbind(train, y_train)
test <- cbind(test, y_test)
names(train)[length(names(train))] <- "Activity"
names(test)[length(names(test))] <- "Activity"

# Merge the train and test sets into a single data frame.
df <- rbind(train, test)
######################################################################


######################################################################
## 2. Extract only the measurements of the mean and standard
##    deviation for each measurement.
######################################################################

# Form a vector of the column names containing "mean()" or "std()".
# We do not include variable names containing "meanFreq()" in this
# selection, for the reasons given in the README.md file.
mean_std <- names(df)[grep("(mean|std)\\(\\)", names(df))]

# Select these variable columns, together with the "observation"
# columns "Subject" and "Activity", from the data frame.
df <- df[, c("Subject","Activity",mean_std)]
######################################################################


######################################################################
## 3. Use descriptive activity names to name the activities in the
##    data set.
######################################################################

# Load the activity labels into a new data frame, and convert each
# label to lower-case, special-character-free form.
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")
names(activity_labels) <- c("activity_id", "Activity")
activity_labels$Activity <- tolower(activity_labels$Activity)
activity_labels$Activity <- sub("_"," ",activity_labels$Activity)

# Merge the activity labels with the existing data frame, and remove
# the now-unneeded column of numeric activity IDs.
df <- merge(activity_labels, df, by.y="Activity", by.x="activity_id")
df <- subset(df, select=-activity_id)
######################################################################


######################################################################
## 4. Appropriately labels the data set with descriptive variable
##    names.
######################################################################

# Define a list of (original, replacement) pairs, which we will use to
# replace the existing names of the mean and standard deviation
# variables with longer, more descriptive names.  The choice of naming
# scheme and the rationale for it are both explained in the README.md
# and CodeBook.md files.
label_substitutions <- list(
    c("tBodyAcc-mean\\(\\)-",
      "MeanOfBodyAccelerationAlong"),
    c("tBodyAcc-std\\(\\)-",
      "StdDevOfBodyAccelerationAlong"),
    c("tGravityAcc-mean\\(\\)-",
      "MeanOfGravitationalAccelerationAlong"),
    c("tGravityAcc-std\\(\\)-",
      "StdDevOfGravitationalAccelerationAlong"),
    c("tBodyAccJerk-mean\\(\\)-",
      "MeanOfBodyJerkAlong"),
    c("tBodyAccJerk-std\\(\\)-",
      "StdDevOfBodyJerkAlong"),
    c("tBodyGyro-mean\\(\\)-",
      "MeanOfBodyAngularVelocityAround"),
    c("tBodyGyro-std\\(\\)-",
      "StdDevOfBodyAngularVelocityAround"),
    c("tBodyGyroJerk-mean\\(\\)-",
      "MeanOfBodyAngularJerkAround"),
    c("tBodyGyroJerk-std\\(\\)-",
      "StdDevOfBodyAngularJerkAround"),
    c("fBodyAcc-mean\\(\\)-",
      "MeanOfFourierBodyAccelerationAlong"),
    c("fBodyAcc-std\\(\\)-",
      "StdDevOfFourierBodyAccelerationAlong"),
    c("fBodyAccJerk-mean\\(\\)-",
      "MeanOfFourierJerkAlong"),
    c("fBodyAccJerk-std\\(\\)-",
      "StdDevOfFourierJerkAlong"),
    c("fBodyGyro-mean\\(\\)-",
      "MeanOfFourierAngularVelocityAround"),
    c("fBodyGyro-std\\(\\)-",
      "StdDevOfFourierAngularVelocityAround"),
    c("tBodyAccMag-mean\\(\\)",
      "MeanOfBodyAccelerationMagnitude"),
    c("tBodyAccMag-std\\(\\)",
      "StdDevOfBodyAccelerationMagnitude"),
    c("tGravityAccMag-mean\\(\\)",
      "MeanOfGravitationalAccelerationMagnitude"),
    c("tGravityAccMag-std\\(\\)",
      "StdDevOfGravitationalAccelerationMagnitude"),
    c("tBodyAccJerkMag-mean\\(\\)",
      "MeanOfBodyJerkMagnitude"),
    c("tBodyAccJerkMag-std\\(\\)",
      "StdDevOfBodyJerkMagnitude"),
    c("tBodyGyroMag-mean\\(\\)",
      "MeanOfBodyAngularVelocityMagnitude"),
    c("tBodyGyroMag-std\\(\\)",
      "StdDevOfBodyAngularVelocityMagnitude"),
    c("tBodyGyroJerkMag-mean\\(\\)",
      "MeanOfBodyAngularJerkMagnitude"),
    c("tBodyGyroJerkMag-std\\(\\)",
      "StdDevOfBodyAngularJerkMagnitude"),
    c("fBodyAccMag-mean\\(\\)",
      "MeanOfFourierBodyAccelerationMagnitude"),
    c("fBodyAccMag-std\\(\\)",
       "StdDevOfFourierBodyAccelerationMagnitude"),
    c("fBodyBodyAccJerkMag-mean\\(\\)",
       "MeanOfFourierBodyJerkMagnitude"),
    c("fBodyBodyAccJerkMag-std\\(\\)",
       "StdDevOfFourierBodyJerkMagnitude"),
    c("fBodyBodyGyroMag-mean\\(\\)",
       "MeanOfFourierBodyAngularVelocityMagnitude"),
    c("fBodyBodyGyroMag-std\\(\\)",
       "StdDevOfFourierBodyAngularVelocityMagnitude"),
    c("fBodyBodyGyroJerkMag-mean\\(\\)",
       "MeanOfFourierBodyAngularJerkMagnitude"),
    c("fBodyBodyGyroJerkMag-std\\(\\)",
       "StdDevOfFourierBodyAngularJerkMagnitude"))

# Loop over the list of pairs, applying each substitution to the
# column names of the data frame in turn.
for (pair in label_substitutions) {
    names(df) <- sub(pair[1], pair[2], names(df))
}
######################################################################


######################################################################
## 5. From the data set in step 4, create a second, independent tidy
##    data set with the average of each variable for each activity and
##    each subject.
######################################################################

# Create a dplyr data frame "tbl" from the data frame, so that we can
# leverage dplyr's functionality to create the tidy data set.
tidy_df <- tbl_df(df)

# Use dplyr's "chaining" functionality to group the tbl by the
# "observation" columns, and then summarize each of the "measurement"
# columns by its mean value.
tidy_df <- tidy_df %>%
      group_by(Subject, Activity) %>%
      summarize_each(funs(mean))

# Write the tidy data set to a (space-separated) text file.
write.table(tidy_df, "TidyData.txt", row.names=FALSE)
######################################################################
