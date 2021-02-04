# Getting-and-Cleaning-Data
This project involves getting and cleaning a part of a data collected from the accelerometers of the Samsung Galaxy S2 smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones.

The data for the project is available here:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

The script 'run_analysis.R' does the followiing on the data (which is downloaded into "./Sam_Gal_S2_Dataset"):

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The data set obtained from #4 above is written to 'MergedUCISamsungGal2Data.txt'

The data set obtained from #5 above is written to 'TidyUCISamsungGal2Data.txt'

A codebook 'Codebook_UCI_SamsungGal2_Data.pdf' describes the the variables in each data set.
