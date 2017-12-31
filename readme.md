---
title: "readme"
author: "Proshoon"
date: "December 31, 2017"
output: html_document
---

## Getting and Cleaning Data -- Project

The R script (run_analysis.R) does the following:

1. Data to be downloaded and unzipped already
2. Load activity and features
3. Extracts only the measurements on the mean and standard deviation for each measurement. 
4. Changes mean and sdev column names appropriately (Mu=Mean, Sigma=SDev)
5. Loads needed columns from Train and Test files
6. Merges the training and the test sets to create one data set.
7. Uses descriptive activity names to name the activities in the merged data set
8. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The end result is downloaded to the file tidy.txt

