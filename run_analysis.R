

## Download & unzip the file with the datasets
if(!file.exists("./Human Activity Recog w Smartphone dataset")){dir.create("./Human Activity Recog w Smartphone dataset")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl,destfile="./Human Activity Recog w Smartphone dataset/Dataset.zip")
unzip(zipfile = "./Human Activity Recog w Smartphone dataset/Dataset.zip", exdir = "./Human Activity Recog w Smartphone dataset")


## read all files required
setwd("./Human Activity Recog w Smartphone dataset/UCI HAR dataset")
activities <- read.table("activity_labels.txt", header = FALSE)
features <- read.table("features.txt", header=FALSE)
setwd("train")
subject_train <- read.table("subject_train.txt", header = FALSE)
train_x <- read.table("X_train.txt", header=FALSE)
train_y <- read.table("y_train.txt", header=FALSE)
setwd('..')
setwd("test")
subject_test <- read.table("subject_test.txt", header = FALSE)
test_x <- read.table("X_test.txt", header=FALSE)
test_y <- read.table("y_test.txt", header=FALSE)
setwd('..')



## STEP Nr. 1 of ASSIGNMENT  -    Create only 1 dataset by merging the TRAIN & TEST datasets   ########

## Merge the Test & Train datasets (that have the MEASUREMENTS), by rows (by bind_row function from dplyr)
library(dplyr)
all_obs <- bind_rows(train_x, test_x)

## Merge ACTIVITY labels for both the Test & Train records (summed_activities)
summed_activities <- bind_rows(train_y, test_y)

## Row binds the Test & Train SUBJECTS (all_subjects)
all_subjects <- bind_rows(subject_train, subject_test)
colnames(all_subjects)[1] <- c("Subject_Nr")

## Rename columns of "all_obs" to match names of the 561 features/measurements (Step Nr. 4)
colnames(all_obs) <- features[ , 2]

## Column bind all 3 DFs to obtain the final merged dataset (merged_dset)
merged_dset <- bind_cols(all_subjects, summed_activities, all_obs)



## STEP Nr. 3 - Assign "descriptive" names to the activities in the merged dataset  ######
colnames(activities) <- c("activityId", "activityLabel")
merged_dset$V1 <- factor(merged_dset$V1, levels = activities[, 1], labels = activities[, 2])
## Remove special characters and rename variables to be more descriptive
merged_set_colnames <- colnames(merged_dset)
merged_set_colnames <- gsub("[\\(\\)-]", "", merged_set_colnames)
merged_set_colnames <- gsub("^t", "Time", merged_set_colnames)
merged_set_colnames <- gsub("^f", "Frequency", merged_set_colnames)
merged_set_colnames <- gsub("mean", "Mean", merged_set_colnames)
merged_set_colnames <- gsub("std", "SD", merged_set_colnames)
colnames(merged_dset) <- merged_set_colnames

## STEP Nr. 2 - Extracts ONLY measurements of X and SD for each measurement  #############
extractedset <- merged_dset[ , c(1:2, grep("Mean|SD", colnames(merged_dset)))]
colnames(extractedset)[2] <- c("Activity")


## STEP Nr. 5 - Create a 2nd, indept. data set with average of measurements (by activity and by subject)
extractedset <- group_by(extractedset, Subject_Nr, Activity )
dsetnr2 <- summarise_all(extractedset, mean)


## Save DSETNR2 to a txt file
setwd('~')
write.table(dsetnr2, "tidy_dset.txt", row.names = FALSE, quote = FALSE)

