#destname <- "HAR2.zip"
#
# if (!file.exists(destname)){
# 
#   sourceURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#   download.file(sourceURL, destname, method="curl")
# 
# }
#
#unzip (destname)


#load activity levels and features... and capture column names
#change to CHAR to perform charcter type operations later
activitylabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitylabels[,2] <- as.character(activitylabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

#capture only the columns with 'mean' or 'std'
featureneed <- grep(".*mean.*|.*std.*", features[,2])
featureneed.names <- features[featureneed,2]
featureneed.names <- gsub('-mean', 'Mu', featureneed.names) #Mu denotes mean
featureneed.names <- gsub('-std', 'Sigma', featureneed.names) #Sigma denotes standard deviation
featureneed.names <- gsub('[-()]', '', featureneed.names) #clean up extraneous stuff

# Load files -- train and test -- only the needed columns
train <- read.table("UCI HAR Dataset/train/X_train.txt")[featureneed]
trainactivity <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainsubject <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainsubject, trainactivity, train)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[featureneed]
testactivity <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubject <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testsubject, testactivity, test)

# merge data. change column names
mergedata <- rbind(train, test)
colnames(mergedata) <- c("subject", "activity", featureneed.names)

# turn activities & subjects into factors
mergedata$activity <- factor(mergedata$activity, levels = activitylabels[,1], labels = activitylabels[,2])
mergedata$subject <- as.factor(mergedata$subject)

#create averages for subject, activity
mergedata.melted <- reshape2::melt(mergedata, id = c("subject", "activity"))
mergedata.mean <- reshape2::dcast(mergedata.melted, subject + activity ~ variable, mean)

#write the tidy file
write.table(mergedata.mean, "tidy.txt", row.names = FALSE, quote = FALSE)


