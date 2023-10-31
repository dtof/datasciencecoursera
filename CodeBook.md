This project combines, sorts, reorganizes, and summarizes embedded
accelerometer and gyroscope data from a smartphone, model Samsung Galaxy
S II), worn on the waste in 30 volunteers, ages 19-48 years, as they
performed six activities, specifically walking, walking upstairs,
walking downstairs, sitting, standing, & laying. 3-axial linear
acceleration and 3-axial angular velocity at a constant rate of 50Hz.

The original description of this data set can be viewed using the
following url:

<https://archive.ics.uci.edu/dataset/240/human+activity+recognition+using+smartphones>

The original data set and supporting document can be obtained using the
following url:

<https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>

===============================================================================

The download for this data set was done on

    ## [1] "2023-10-31"

.

The R Studio version for this analysis was

    ## [1] "R version 4.3.1 (2023-06-16)"

.

===============================================================================

The run\_analysis.R script obtains the raw data set from the URL
document above and then combines, sorts, reorganizes, and summarizes the
data raw data set using. These tasks are accomplished using eight steps.

Step 1: A temporary file into which the data set may be downloaded. The
program checks to see if the data set, named “UCI HAR Datasaet”) exists.
If it does not exist, it downloads the zipped data set to a temporary
file, unzips the dataset into your working directory to a folder
entitled “UCI HAR Dataset” and deletes the zipped data set.

Step 2: Raw data sets are imported as data.frame objects into R studio
with correct handling of individual file headers. The raw data files and
a brief description of each used for this portion are as follows:

“UCI HAR Dataset/features.txt” List of all features.

“UCI HAR Dataset/activity\_labels.txt” Links the class labels with their
activity name.

“UCI HAR Dataset/test/subject\_test.txt” Each row identifies the subject
who performed the activity for each window sample.

“UCI HAR Dataset/test/X\_test.txt” Test data set.

“UCI HAR Dataset/test/y\_test.txt” Test data labels.

“UCI HAR Dataset/train/subject\_train.txt” Each row identifies the
subject who performed the activity for each window sample.

“UCI HAR Dataset/train/X\_train.txt” Training data set.

“UCI HAR Dataset/train/y\_train.txt” Training data labels.

Step 3: Raw data sets for training and test with labels and subject
identification are combined together. The combined dataset is entitled
“subjectxy”(10299 rows, 563 columns).

Step 4: Utilizing and the dplyr package, the combined data set entitled
“subjectxy” is reduced to only include the subject, code, means, and
standard deviations for each measurements. This is stored in a new data
set entitled “reduced\_subjectxy” (10299 rows, 88 columns).

Step 5: The activity column is renamed and labels are added to the
activities using the “activity\_labels.txt” derived data.frame.

Step 6: The rest of variable headers are renamed with descriptive
titles.

Step 7: The means of each variable for each activity and each subject
are derived from the data set entitled “reduced\_subjectxy” and stored
into a final data set entitled “final” (180 rows, 88 columns).

Step 8: The final data is exported into the working directory in a file
entitled “Final.txt”.
