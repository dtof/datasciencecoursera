## Step 1: Check if appropriate files are there, if not, then download. Code also removes unneeded files.

zipname <- "Course_project.zip"

if (!file.exists("UCI HAR Dataset")){
        zipURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
        download.file(zipURL, zipname, method="curl")
}  

if (!file.exists("UCI HAR Dataset")) { 
        unzip(zipname) 
}

if (file.exists("UCI HAR Dataset")) { 
        file.remove(zipname) 
}

# Step 2: Import and create raw datasets from appropriate files. 

features <- read.table("UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt", col.names = "code")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt", col.names = "code")

# Step 3: Merge the test and train datasets together.

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
subjectxy <- cbind(subject, x, y)

# Step 4: Launch the dplyr package and select only the means and standard deviations for each measurement.

library(dplyr)

reduced_subjectxy <- subjectxy %>% select(subject, code, contains("mean"), contains("std"))

# Step 5: Rename the activity column in the dataset and add labels to the activities.

names(reduced_subjectxy)[2] = "Activity"
reduced_subjectxy$Activity <- activity_labels[reduced_subjectxy$Activity, 2]

# Step 6: Rename the rest of the variable names in the dataset.

names(reduced_subjectxy)<-gsub("Acc", "Accelerometer", names(reduced_subjectxy))
names(reduced_subjectxy)<-gsub("Gyro", "Gyroscope", names(reduced_subjectxy))
names(reduced_subjectxy)<-gsub("BodyBody", "Body", names(reduced_subjectxy))
names(reduced_subjectxy)<-gsub("Mag", "Magnitude", names(reduced_subjectxy))
names(reduced_subjectxy)<-gsub("^t", "Time", names(reduced_subjectxy))
names(reduced_subjectxy)<-gsub("^f", "Frequency", names(reduced_subjectxy))
names(reduced_subjectxy)<-gsub("tBody", "TimeBody", names(reduced_subjectxy))
names(reduced_subjectxy)<-gsub("-mean()", "Mean", names(reduced_subjectxy), ignore.case = TRUE)
names(reduced_subjectxy)<-gsub("-std()", "STD", names(reduced_subjectxy), ignore.case = TRUE)
names(reduced_subjectxy)<-gsub("-freq()", "Frequency", names(reduced_subjectxy), ignore.case = TRUE)
names(reduced_subjectxy)<-gsub("angle", "Angle", names(reduced_subjectxy))
names(reduced_subjectxy)<-gsub("gravity", "Gravity", names(reduced_subjectxy))

# Step 7: Create the final data with the means of each activity for each subject.

final <- reduced_subjectxy %>% group_by(subject, Activity) %>% summarise_all(mean)

# Step 8: Export the final data into a new file called Final.txt

write.table(final, "Final.txt", row.name=FALSE)
