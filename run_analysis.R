library(Stack)
# Merges the training and the test sets to create one data set.

features <- read.table("features.txt")

train <- read.table("train/X_train.txt", sep="", row.names=NULL)
trainfull <- cbind(train, read.table("train/subject_train.txt"), read.table("train/y_train.txt"))
names(trainfull) <- c(as.character(features$V2), "subject", "label")

test <- read.table("test/X_test.txt", sep="", row.names=NULL)
testfull <- cbind(test, read.table("test/subject_test.txt"), read.table("test/y_test.txt"))
names(testfull) <- c(as.character(features$V2), "subject", "label")

dat <- rbind(trainfull, testfull, deparse.level=1)


# Extracts only the measurements on the mean and standard deviation for each measurement. 

cols <- c(grep('^(.*mean\\(.*|.*std.*|subject|label)$', names(dat))) 

subdat <- dat[,cols]
subdat <- cbind(subdat, )

# Uses descriptive activity names to name the activities in the data set
subs <- rbind(
  c("tBodyAccJerk", "Derivative_of_Acceleration_component"),
  c("tBodyAcc", "Acceleration_component"),
  c("tGravityAcc", "Gravity_Acceleration_component"),
  c("tBodyGyroJerk", "Derivative_of_Gyroscope_component"),
  c("tBodyGyro", "Gyroscope_component"),
  c("tBodyAccMag", "Magnitude_of_Acceleration"),
  c("tGravityAccMag", "Magnitude_of_Gravity_Acceleration"),
  c("tBodyGyroMag", "Magnitude_of_Gyroscope"),
  c("tBodyGyroJerkMag", "Derivative_of_Magnitude_of_Gyroscope"),
  c("fBodyAccJerk", "FFT_of_Derivative_of_Acceleration_component"),
  c("fBodyGyro", "FFT_of_Gyroscope_component"),
  c("fBodyAccMag", "FFT_of_Magnitude_of_Acceleration"),
  c("fBodyBodyAccJerkMag", "FFT_of_Derivative_of_Magnitude_of_Acceleration"),
  c("fBodyBodyGyroMag", "FFT_of_Magnitude_of_Gyroscope"),
  c("fBodyBodyGyroJerkMag", "FFT_of_Derivative_of_Magnitude_of_Gyroscope"),
  c("-mean\\(\\)", "_mean"),
  c("-std\\(\\)", "_standard_deviation"),
  c("-X", "_in_X_direction"),
  c("-Y", "_in_Y_direction"),
  c("-Z", "_in_Y_direction")
)

# Ensure that we do replacements in the right order
subs <- subs[order(subs[,1], decreasing=TRUE),]
colnames <- names(subdat)

# Appropriately labels the data set with descriptive variable names. 

for(i in 1:length(colnames))
  for(j in 1:nrow(subs))
    colnames[i] <- gsub(subs[j,1], subs[j,2], colnames[i])
  
names(subdat) <- colnames
  
write.table(subdat, file="final_full_tidy_data.txt",row.names=FALSE)

# Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

sumdat <- data.frame(
  with(subdat, 
       tapply(Acceleration_component_mean_in_X_direction, list(subject, label), mean
       )
  )
)

activity_names <- read.table("activity_labels.txt")
names(sumdat) <- activity_names$V2

write.table(sumdat, file="final_mean_data.txt",row.names=FALSE)