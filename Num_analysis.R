#Nun_analysis.R
#Laurent GUERET
#Getting and Cleaning Data
# May 2020

#Load packages
library(data.table)
library(dplyr)

# Creation of the working directory
if(!file.exists("~/data")){dir.create("~/data")}

# ZIP file recovery
urlFile <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(urlFile, destfile = "~/data/dataset.zip")

# Download date recovery
dateDownloaded <- date()

# Extracting data from the ZIP file
unzip("~/data/dataset.zip", exdir = normalizePath('~/data'))

# Data recovery from files and storage in different dataframes
#
# Data from Train directory
df_xTrain <- read.table("~/data/UCI HAR Dataset/train/X_train.txt", header = FALSE)
df_yTrain <- read.table("~/data/UCI HAR Dataset/train/y_train.txt", header = FALSE)
df_subjectTrain <- read.table("~/data/UCI HAR Dataset/train/subject_train.txt", header = FALSE)

# Data from Test directory
df_xTest <- read.table("~/data/UCI HAR Dataset/test/X_test.txt", header = FALSE)
df_yTest <- read.table("~/data/UCI HAR Dataset/test/y_test.txt", header = FALSE)
df_subjectTest <- read.table("~/data/UCI HAR Dataset/test/subject_test.txt", header = FALSE)

# Data from features
df_featureLabel <- read.table("~/data/UCI HAR Dataset/features.txt", header = FALSE)

# Data from activity
df_activityLabel <- read.table("~/data/UCI HAR Dataset/activity_labels.txt", header = FALSE)

# Combine data (x, y, Subject) by Rows into new dataframe
df_xData <- rbind(df_xTrain,df_xTest)
df_yData <- rbind(df_yTrain,df_yTest)
df_subjectData <- rbind(df_subjectTrain,df_subjectTest)

# Rename columns in activityLabel, yData, SubjectData, xData dataframes.  
names(df_activityLabel) <- c("activityCode","activity")
names(df_yData) <- "activityCode"
names(df_subjectData) <- "subject"
names(df_xData) <- df_featureLabel$V2

# Get factor of Activity names
df_yDataF <- as.data.frame(left_join(df_yData, df_activityLabel, "activityCode")[, 2])

# Rename activity columns
names(df_yDataF) <- "activity"

# Create one large Dataset with only these variables: SubjectData,  Activity,  FeaturesData
dataSet <- cbind(df_subjectData, df_yDataF)
dataSet <- cbind(dataSet, df_xData)

# Create New datasets by extracting only the measurements on the mean and standard deviation for each measurement
index <- df_featureLabel$V2[grep("mean\\(\\)|std\\(\\)",df_featureLabel$V2)]
index <- c("subject","activity",as.character(index))
dataSet <- dataSet[,index]

# Rename the columns of the large dataset using more descriptive activity names
names(dataSet)<-gsub("^t", "time", names(dataSet))
names(dataSet)<-gsub("^f", "frequency", names(dataSet))
names(dataSet)<-gsub("Acc", "Accelerometer", names(dataSet))
names(dataSet)<-gsub("Gyro", "Gyroscope", names(dataSet))
names(dataSet)<-gsub("Mag", "Magnitude", names(dataSet))
names(dataSet)<-gsub("BodyBody", "Body", names(dataSet))

# Create a second, independent tidy data set with the average of each variable for each activity and each subject
secondDataSet<-aggregate(. ~subject + activity, dataSet, mean)
secondDataSet<-secondDataSet[order(secondDataSet$subject,secondDataSet$activity),]

# Save this tidy dataset to local file
write.table(secondDataSet, file = "tidydata.txt",row.name=FALSE)

