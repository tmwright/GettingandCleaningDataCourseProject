### Code Book — Samsung HAR data 
Tod Wright 5 August 2016

## Introduction
The data frame `df` created internally by `run_analysis.R` and the tidy data set that this script outputs to `TidyData.txt` both contain a total of 68 columns.  Two of these columns contain variables that are "Fixed" in the classification of reference [1] — i.e., they define the distinct observations represented in the data set.  The remaining 66 columns are "Measured" variables [1], which contain the results of measurements for each of the observations (or the means of such measurements in the case of `TidyData.txt`).

In this code book we list each of the variables, noting in each case the type of the variable ("Fixed" or "Measured"), its class (`integer`, `numeric`, or `character`), and its English-language description.  We also note the values that the variable may take in the data set, which is in each case either a range of integers, a domain of continuous (floating-point) numbers, or a set of strings.  For each of the fixed variables we note the files in which the variables (or their underlying numeric representations) are found in the original UCI data set.  For each of the measured variables we indicate the abbreviated name of the variable found in `features.txt` in the original data set.

Note that all measured variables are normalized to a given range in the original data set, and are therefore given in arbitrary units.  Also, many of the measured variables correspond to vectorial quantities and therefore appear in sets of three variables, ending in "`X`", "`Y`", and "`Z`".  To eliminate some redundancy we therefore use the notation `{X,Y,Z}` to indicate such triples of variables, and the coordinate axes to which they respectively refer, throughout this document.

## Variables

### `Subject`
* Type: "Fixed"
* Class: `integer`
* Description: The numeric ID of the experimental subject to which the observation corresponds.
* Values: `1..30`
* Origin files: `subject_train.txt`, `subject_test.txt`


### `Activity`
* Type: "Fixed"
* Class: `character`
* Description: The activity the subject was undertaking during the observation.
* Values: "`laying`", "`sitting`", "`standing`", "`walking`", "`walking downstairs`", "`walking upstairs`"
* Origin files: `y_train.txt`, `y_test.txt`


### `MeanOfBodyAccelerationAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of acceleration of the subject's body along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tBodyAcc-mean()-{X,Y,Z}`


### `StdDevOfBodyAccelerationAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of acceleration of the subject's body along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tBodyAcc-std()-{X,Y,Z}`


### `MeanOfGravitationalAccelerationAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of gravitational acceleration along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tGravityAcc-mean()-{X,Y,Z}`


### `StdDevOfGravitationalAccelerationAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of gravitational acceleration along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tGravityAcc-std()-{X,Y,Z}`


### `MeanOfBodyJerkAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of jerk of the subject's body along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tBodyAccJerk-mean()-{X,Y,Z}`


### `StdDevOfBodyJerkAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of jerk of the subject's body along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tBodyAccJerk-std()-{X,Y,Z}`


### `MeanOfBodyAngularVelocityAround{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of angular velocity of the subject's body around the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tBodyGyro-mean()-{X,Y,Z}`


### `StdDevOfBodyAngularVelocityAround{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of angular velocity of the subject's body around the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tBodyGyro-std()-{X,Y,Z}`


### `MeanOfBodyAngularJerkAround{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of angular jerk of the subject's body around the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tBodyGyroJerk-mean()-{X,Y,Z}`


### `StdDevOfBodyAngularJerkAround{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of angular jerk of the subject's body around the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `tBodyGyroJerk-std()-{X,Y,Z}`


### `MeanOfBodyAccelerationMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the acceleration vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `tBodyAccMag-mean()`


### `StdDevOfBodyAccelerationMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of magnitude of the acceleration vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `tBodyAccMag-std()`


### `MeanOfGravitationalAccelerationMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the gravitational acceleration vector.
* Values: `[-1,1]`
* Origin variable: `tGravityAccMag-mean()`


### `StdDevOfGravitationalAccelerationMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the magnitude of the gravitational acceleration vector.
* Values: `[-1,1]`
* Origin variable: `tGravityAccMag-std()`


### `MeanOfBodyJerkMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the jerk vector of subject's body.
* Values: `[-1,1]`
* Origin variable: `tBodyAccJerkMag-mean()`


### `StdDevOfBodyJerkMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the magnitude of the jerk vector of subject's body.
* Values: `[-1,1]`
* Origin variable: `tBodyAccJerkMag-std()`


### `MeanOfBodyAngularVelocityMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the angular velocity vector of subject's body.
* Values: `[-1,1]`
* Origin variable: `tBodyGyroMag-mean()`


### `StdDevOfBodyAngularVelocityMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the magnitude of the angular velocity vector of subject's body.
* Values: `[-1,1]`
* Origin variable: `tBodyGyroMag-std()`


### `MeanOfBodyAngularJerkMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the angular jerk vector of subject's body.
* Values: `[-1,1]`
* Origin variable: `tBodyGyroJerkMag-mean()`


### `StdDevOfBodyAngularJerkMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the magnitude of the angular jerk vector of subject's body.
* Values: `[-1,1]`
* Origin variable: `tBodyGyroJerkMag-std()`


### `MeanOfFourierBodyAccelerationAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the Fourier transformed acceleration of the subject's body along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `fBodyAcc-mean()-{X,Y,Z}`


### `StdDevOfFourierBodyAccelerationAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the Fourier transformed acceleration of the subject's body along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `fBodyAcc-std()-{X,Y,Z}`


### `MeanOfFourierJerkAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the Fourier transformed jerk of the subject's body along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `fBodyAccJerk-mean()-{X,Y,Z}`


### `StdDevOfFourierJerkAlong{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the Fourier transformed jerk of the subject's body along the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `fBodyAccJerk-std()-{X,Y,Z}`


### `MeanOfFourierAngularVelocityAround{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the Fourier transformed angular velocity of the subject's body around the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `fBodyGyro-mean()-{X,Y,Z}`


### `StdDevOfFourierAngularVelocityAround{X,Y,Z}`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the Fourier transformed angular velocity of the subject's body around the {X,Y,Z} axis.
* Values: `[-1,1]`
* Origin variable: `fBodyGyro-std()-{X,Y,Z}`


### `MeanOfFourierBodyAccelerationMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the Fourier transformed acceleration vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `fBodyAccMag-mean()`


### `StdDevOfFourierBodyAccelerationMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the magnitude of the Fourier transformed acceleration vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `fBodyAccMag-std()`


### `MeanOfFourierBodyJerkMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the Fourier transformed jerk vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `fBodyBodyAccJerkMag-mean()`


### `StdDevOfFourierBodyJerkMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the magnitude of the Fourier transformed jerk vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `fBodyBodyAccJerkMag-std()`


### `MeanOfFourierBodyAngularVelocityMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the Fourier transformed angular velocity vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `fBodyBodyGyroMag-mean()`


### `StdDevOfFourierBodyAngularVelocityMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the magnitude of the Fourier transformed angular velocity vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `fBodyBodyGyroMag-std()`


### `MeanOfFourierBodyAngularJerkMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Mean of the magnitude of the Fourier transformed angular jerk vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `fBodyBodyGyroJerkMag-mean()`


### `StdDevOfFourierBodyAngularJerkMagnitude`
* Type: "Measured"
* Class: `numeric`
* Description: Standard deviation of the magnitude of the Fourier transformed angular jerk vector of the subject's body.
* Values: `[-1,1]`
* Origin variable: `fBodyBodyGyroJerkMag-std()`



### Bibliography
[1] H. Wickham, [Tidy Data](http://vita.had.co.nz/papers/tidy-data.pdf), Journal of Statistical Software **59**, 1 (2014).

