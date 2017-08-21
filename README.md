# Getting and Cleaning Data - Course Project

This is the course project for the "Getting and Cleaning Data" Coursera course.

One of the most exciting areas in all of data science right now is wearable computing - see for example [this article](http://www.insideactivitytracking.com/data-science-activity-tracking-and-the-battle-for-the-worlds-top-sports-brand/). Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users.

In this project, data collected from the accelerometer and gyroscope of the Samsung Galaxy S smartphone was retrieved, worked with, and cleaned, to prepare a tidy data that can be used for later analysis.

This repository contains the following files:

- `README.md`, this file, which provides an overview of the data set and how it was created.
- `tidy_dset.txt`, which contains the final data set.
- `CodeBook.md`, the code book, which describes the contents of the data set (data, variables and transformations used to generate the data).
- `run_analysis.R`, the R script that was used to create the data set (see the [Creating the data set](#creating-data-set) section below) 


## Study design <a name="study-design"></a>

The source data set that this project was based on was obtained from the [Human Activity Recognition Using Smartphones Data Set](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#), which describes how the data was initially collected as follows:

> The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING\_UPSTAIRS, WALKING\_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.
> 
> The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

Training and test data were first merged together to create one data set, then the measurements on the mean and standard deviation were extracted for each measurement (79 variables extracted from the original 561), and then the measurements were averaged for each subject and activity, resulting in the final data set.


The R script, `run_analysis.R`, does the following:

1. Downloads the dataset (if it does not already exist) in the directory "Human Activity Recog w Smartphone dataset"
2. Loads (reads) the activities and features information (labels)
3. Loads both the training and test datasets
4. Loads the activity and subject data for each dataset
5. Merges all 6 files into 1 single datasets
6. Assign "descriptive" names to the activities in the merged dataset
7. Extracts ONLY measurements of X and SD from the merged dataset
8. Creates a 2nd indepdendent dataset (from the merged one) using the "group_by" function of dplyr package
8. Creates a tidy dataset that consists of the average (mean) value of each measurement for each subject and activity pair.


