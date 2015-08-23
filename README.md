# Programming Assignment - Getting and Cleaning Data

This repository provides data processing script `run_analysis.R` and data description file `CodeBook.md` for Getting and Cleaning Data course project.

## Data

The original data set is: [**Human Activity Recognition Using Smartphones Data Set**](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).
Detailed data description is provided in `CodeBook.md` file.

## run_analysis.R
The included data preprocessing script *run_analysis.R* performs following operations on the original data:

1. Downloads the original data from the addres provided above.
2. Loads data and merges test and train sets to create one data set.
3. Extracts only measurements on mean and standard deviation for each measurement.
4. Labels the measurements with descriptive variable names. Labels subject and activity variables.
5. Assigns descriptive activity names to the activity variable.
6. Aggregates the data set into new tidy data set with average mean and standard deviation for each measurement grouped by subject and activity.

## Dependencies
The script `run_analysis.R` depends on `data.table` and `reshape2` packages.