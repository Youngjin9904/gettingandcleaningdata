install.packages("data.table")
library(data.table)
fileurl = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
if(!file.exists('./UCI HAR Dataset.zip')){
  download.file(fileurl,'./UCI HAR Dataset.zip',mode='wb')
  unzip("UCI HAR Dataset.zip", exdir=getwd())
}
features <- read.csv('./UCI HAR Dataset/features.txt',header=FALSE,sep='')
features <- as.character(features[,2])
train.x <- read.table('./UCI HAR Dataset/train/X_train.txt')
train.y <- read.table('./UCI HAR Dataset/train/y_train.txt', header=FALSE, sep='')
train.subject <- read.table('./UCI HAR Dataset/train/subject_train.txt', header=FALSE, sep='')
train <- data.frame(train.subject, train.y, train.x)
names(train) <- c(c('subejct','activity'), features)
test.x <- read.table('./UCI HAR Dataset/test/X_test.txt')
test.y <- read.table('./UCI HAR Dataset/test/y_test.txt', header=FALSE, sep='')
test.subject <- read.table('./UCI HAR Dataset/test/subject_test.txt', header=FALSE, sep='')
test <- data.frame(test.subject, test.y, test.x)
names(test) <- c(c('subejct','activity'), features)

# 1.merges
all <- rbind(train,test)
# 2.extracts
mean.std <- grep('mean|std', features)
sub <- all[,c(1,2,mean.std + 2)]
# 3.descriptive activity
activity_label <- read.table('./UCI HAR Dataset/activity_labels.txt', header=FALSE)
activity_label <- as.character(activity_label[,2])
sub$activity <- activity_label[sub$activity]
# 4.labels
new <- names(sub)
new <- gsub("[(][)]","",new)
new <- gsub("^t","TimeDomain_",new)
new <- gsub("^f","FrequencyDomain_",new)
new <- gsub("Acc","Accelerometer",new)
new <- gsub("Gyro", "Gyroscope", new)
new <- gsub("Mag", "Magnitude", new)
new <- gsub("-mean-", "_Mean_", new)
new <- gsub("-std-", "_StandardDeviation_", new)
new <- gsub("-","_",new)
names(sub) <- new
# 5.tidy data set
tidy.data <- aggregate(sub[,3:81], by=list(acitivity=sub$activity, subject = sub$subejct), FUN=mean)
write.table(x=tidy.data, file="tidy_data.txt", row.names=FALSE)
