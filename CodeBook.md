Variables :
 
urlFile <- Link tro the ZIP File
dateDownloaded <- Save the download date

df_xTrain <- DataFrame for storage Training Set
df_yTrain <- DataFrame for storage Training Label
df_subjectTrain <- DataFrame for storage Subject Training
df_xTest <- DataFrame for storage Test Set
df_yTest <- DataFrame for storage Test Label
df_subjectTest <- DataFrame for storage Subject Test
df_featureLabel <- DataFrame for storage Feature Label
df_activityLabel <- DataFrame for storage activity Label
df_xData <- DataFrame with all/merge (Train + Test) Set
df_yData <- DataFrame with all/merge (Train + Test) Label
df_subjectData <- DataFrame with all/merge (Train + Test) Subject
df_yDataF <- dataFrame factor of Activity names
dataSet <- dataframe with the measurements on the mean and standard deviation for each measurement
index <- vector for extract the mean / Standard deviation / subject / Activity
secondDataSet <- second tidy data set with the average of each variable for each activity and each subject

Explanation :

Create a directory (if not already exist)
save the ZIP File
extract File
Create dataFrame with the différents file from the Extract ZIP
Merge the differents dataFrame for make one dataframe
rename col
create a new file tidydata.txt

Select the col for create a second tidy data set with the average of each variable for each activity and each subject
create a new file tidydataAV.txt
