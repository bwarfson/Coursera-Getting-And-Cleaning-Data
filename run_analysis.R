library(dplyr)
"Checks for data directory and creates one if it doesn't exist"
if (!file.exists("data")) {
  message("Creating data directory")
  dir.create("data")
}

# download the data
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
zipfile="data/UCI_HAR_data.zip"
message("Downloading data")
download.file(fileURL, destfile=zipfile)
unzip(zipfile, exdir="data")

# Read features and activity levels
activity.labels <- read.table("data/UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE, col.names = c("activity_id", "activity"))
activity.labels[,2] <- tolower(activity.labels[,2])
activity.labels[,2] <- gsub("_"," ", activity.labels[,2])


features <- read.table("data/UCI HAR Dataset/features.txt", row.names = 1, stringsAsFactors = FALSE, col.names = c("id", "fnames")) #[,2]
colnames <- features$fnames 
# Read test data
X.test <- read.table("data/UCI HAR Dataset/test/X_test.txt")
names(X.test) <- colnames
y.test <- read.table("data/UCI HAR Dataset/test/y_test.txt", col.names = "activity_id")
subject.test <- read.table("data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
# Read training data
x.train <- read.table("data/UCI HAR Dataset/train/X_train.txt")
names(x.train) <- colnames
y.train <- read.table("data/UCI HAR Dataset/train/y_train.txt", col.names = "activity_id")
subject.training <- read.table("data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")

#Merge training and test datasets and add columns for subjects and activities
subjects <- rbind(subject.training, subject.test)
activities <- rbind(y.train, y.test)
readings <- rbind(x.train, X.test)

data <- cbind(subjects,activities,readings)

#Extracts only the measurements on the mean and standard deviation for each measurement.
my.measures <- grep("mean\\(|std\\(", names(readings), value = TRUE)
data <- data[, c("subject", "activity_id", my.measures)]

#Uses descriptive activity names to name the activities in the data set
data <- inner_join(data, activity.labels, by="activity_id")
data <- data[, c("subject", "activity", my.measures)]

#Appropriately labels the data set with descriptive variable names. 
names(data) <- gsub("\\()","", names(data))
names(data) <- tolower(names(data))
names(data) <- gsub("bodybody", "body", names(data))
names(data) <- gsub("std", "standarddeviation", names(data))
names(data) <- gsub("^t", "timedomain", names(data)) 
names(data) <- gsub("^f", "freqdomain", names(data))
names(data) <- gsub("gyro", "gyroscope", names(data))
names(data) <- gsub("acc", "accelerometer", names(data))
names(data) <- gsub("mag", "magnitude", names(data))


#From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidy.data <- data %>%
  group_by(subject, activity) %>%
  summarise_each(funs(mean))

#set as a txt file created with write.table() using row.name=FALSE
write.table(tidy.data, "tidydata.txt", row.names = FALSE)





