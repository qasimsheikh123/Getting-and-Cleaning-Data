library(dplyr)

#check if the file exists, download it if not, unzip it
file <- "getdata_dataset.zip"
if (!file.exists(file)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  download.file(file, url)
}
unzip(file)

#extract labels of activities and features, clean up the format of feature labels
activities <- read.table("UCI HAR Dataset/activity_labels.txt")
alabels <- as.character(activites[,2])
features <- read.table("UCI HAR Dataset/features.txt")
flabels <- as.character(features[,2])
fwanted <- grep(".*mean.*|.*std.*", flabels)
fnames <- flabels[fwanted]
fnames <- gsub('-std', 'Std', fnames)
fnames <- gsub('-mean', 'Mean', fnames)
fnames <- <- gsub('[-()]', '', fnames)

#get the data from each category of training variables and make a dataset
traindata <- read.table("UCI HAR Dataset/train/X_train.txt")[fwanted]
trainacts <- read.table("UCI HAR Dataset/train/Y_train.txt")
trainsubs <- read.table("UCI HAR Dataset/train/subject_train.txt")
train <- cbind(trainsubs, trainacts, traindata)

#get the data from each category of testing variables and make a dataset
testdata <- read.table("UCI HAR Dataset/test/X_test.txt")[fwanted]
testacts <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubs <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testsubs, testacts, testdata)

#combine the two datasets and clean up formatting
master <- rbind(train, test)
names(master) <- c("subject", "activity", fnames)

#make a new, clean dataset that groups by subject and activity and gives mean of each
clean <- master %>% group_by(subject, activity) %>%
  summarise_each(funs(mean))

#write the new dataset
write.table(clean, "tidy_data.txt", row.names = FALSE)