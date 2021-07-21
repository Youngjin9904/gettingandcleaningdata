run_analysis.R script merges 'train' data and 'test' data in the zip file from the UCI HAR Dataset. In the script, the feature columns are renamed into R data frame column names, and also the activities are changed from integers to descriptive strings. 

The mean and std columns of UCI dataset are selected, grouped by subject and acitivity (x and y values for each train and test data) and the mean of each of groups is stored in a 'tiday' data frame. The tidy data is written with code write.table().

The two columns of tidy data are corresponding to subject and activity. The rest of columns are the mean of scaled point numbers which are between -1 and +1. 

**Example**
subject: ID of subject, int (1-30)
activity_num:	ID of activity, int (1-6)
activity_name: Label of activity, Factor w/ 6 levels

variable: comlete name of the feature, Factor w/ 66 levels (eg. tBodyAcc-mean()-X)
value: the actual value, num (range: -1:1)
dimension:dimension of measurement, Factor w/ 2 levels: t (Time) or f (Frequency)
source: source of measurement, Factor w/ 3 levels: Body,BodyBody or Gravity
type: type of measurement, Factor w/ 2 levels: Acc (accelerometer) or Gyro (gyroscope)
jerk: 'Jerk' signal , Factor w/ 2 levels: Jerk or (non Jerk)
magnitude: 'Magnitude' value , Factor w/ 2 levels: Mag or (non Mag)
method: result from method , Factor w/ 2 levels: mean (average) or std (standard deviation)
axis: FFT exrapolated to axis , Factor w/ 2 levels: (no FFT-axis) or X,Y or Z 
...etc.
