require(data.table)
require(reshape2)

# Download and extract data
#download.file('https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip', 'data.zip', method = 'curl')
#unzip('data.zip')

###    Read data    ###

# Train set
read.table('UCI HAR Dataset/train/X_train.txt') -> train_X
read.table('UCI HAR Dataset/train/y_train.txt') -> train_y
read.table('UCI HAR Dataset/train/subject_train.txt') -> train_subject

# Test set
read.table('UCI HAR Dataset/test/X_test.txt') -> test_X
read.table('UCI HAR Dataset/test/y_test.txt') -> test_y
read.table('UCI HAR Dataset/test/subject_test.txt') -> test_subject

# Labels
read.table('UCI HAR Dataset/activity_labels.txt')[,2] -> activity_labels
read.table('UCI HAR Dataset/features.txt')[,2] -> features_labels


###    1. Merges the training and the test sets to create one data set   ###

rbind(train_X, test_X) -> X
rbind(train_subject, test_subject) -> subject
rbind(train_y, test_y) -> y

###    2. Extracts only the measurements on the mean and standard deviation for each measurement    ###

grep("mean()", features_labels, fixed = TRUE) -> mean_columns
grep("std()", features_labels, fixed = TRUE) -> std_columns
X[,c(mean_columns, std_columns)] -> X

###    3. Uses descriptive activity names to name the activities in the data set    ###

activity_labels[y$V1] -> y

###    4. Appropriately labels the data set with descriptive variable names    ###

cbind(X, subject, y) -> data_set
c(as.character(features_labels[c(mean_columns, std_columns)]), "Subject", "Activity") -> colnames(data_set)

###    5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.    ###

melt(data_set, id.vars = c("Subject", "Activity")) -> melted_data_set
dcast(melted_data_set, Subject + Activity ~ variable, mean) -> tidy

write.table(tidy, file = "tidy_aggregated.txt", row.names = FALSE)


