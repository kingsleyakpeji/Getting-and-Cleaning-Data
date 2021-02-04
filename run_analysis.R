#load needful packages
library(dplyr)
library(tidyr)

#Read in all datasets

trainDtPath <- "./Sam_Gal_S2_Dataset/train/X_train.txt"
trainSubPath <- "./Sam_Gal_S2_Dataset/train/subject_train.txt"
trainActIDpath <- "./Sam_Gal_S2_Dataset/train/y_train.txt"

testDtPath <- "Sam_Gal_S2_Dataset/test/X_test.txt"
testSubPath <- "./Sam_Gal_S2_Dataset/test/subject_test.txt"
testActIDpath <- "./Sam_Gal_S2_Dataset/test/y_test.txt"

ActLabPath <- "./Sam_Gal_S2_Dataset/activity_labels.txt"

featuresPath <- "./Sam_Gal_S2_Dataset/features.txt"

#Read in all datasets
readDtFun <- function (Dt) { #dummy function for multiple file read
	read.table(Dt, sep = "")
}

AllDtPath <- list(trainSubPath, trainActIDpath, trainDtPath,
			   testSubPath, testActIDpath, testDtPath)

AllDt <- lapply(AllDtPath, readDtFun)

names(AllDt) <-  c("trainSub", "trainActIDpath", "trainDt", 
			    "testSub", "testActIDpath", "testDt")

features <-  read.table(featuresPath, sep = "")[,2]
actLab <- read.table(ActLabPath, sep = "") [,2]

#Unify train/test subject, activity level, and measurements into one dataframe
trtesDt <- rbind(
			cbind(AllDt$trainSub, AllDt$trainActIDpath, AllDt$trainDt),
			cbind(AllDt$testSub, AllDt$testActIDpath, AllDt$testDt)
			)

#Replace variable names in merged dataset with actual feature names
names(trtesDt) <- c("SubjectID", "Activity", features)

##Extract sub dataframe with only subject ID, activity, mean and std data
#Excluding variables with string "meanFreq."
trtesDtSb <- trtesDt[, c(1, 2, grep("mean()|std()", names(trtesDt)))]
trtesDtSb <- trtesDtSb[, -c(grep("meanFreq", names(trtesDtSb)))]

#Remove special characters in variable names and make them more descriptive
names(trtesDtSb) <- gsub("\\()", "", names(trtesDtSb))
names(trtesDtSb) <- gsub("-", ".", names(trtesDtSb))
names(trtesDtSb) <- gsub("tB", "timeDomain.B", names(trtesDtSb))
names(trtesDtSb) <- gsub("tG", "timeDomain.G", names(trtesDtSb))
names(trtesDtSb) <- gsub("fB", "FreqDomain.B", names(trtesDtSb))
names(trtesDtSb) <- gsub("Gyro", "Gyroscope", names(trtesDtSb))
names(trtesDtSb) <- gsub("Acc", "Accelerometer", names(trtesDtSb))

#Replace activity labels with activity names
trtesDtSb$Activity <- actLab[trtesDtSb$Activity]

#Convert trtesDt dataframe to dataframe table
trtesDtSb <- tbl_df(trtesDtSb)

#Create a second independent tidy data set with the average of each variable for
#each activity and each subject
trtesDtSb2 <- trtesDtSb %>% 
	group_by(SubjectID, Activity) %>%
	summarise(across(.cols = everything(), mean))

#Write Merged data (trtesDtSb) and tidy data set (trtesDtSb2) to txt files
write.table(trtesDtSb, file = "MergedUCISamsungGal2Data.txt")
write.table(trtesDtSb, file = "TidyUCISamsungGal2Data.txt")
