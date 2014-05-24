# Read in the component datasets for training and test - first the measurements
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
sub_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
sub_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
# now the labels and the subjects
mylabels <-read.table("./UCI HAR Dataset/features.txt",colClasses="character")
library("qdap")
mylabelstrip <- sapply(mylabels,strip,digit.remove=F)
# rename the measurement data with meaningful column names
colnames(x_train) <- mylabelstrip[,2]
colnames(x_test) <- mylabelstrip[,2]
# find the columns that contain mean and std values
mycols <-names(x_train)
newcols <- c(grep("mean",mycols,ignore.case=T) , grep(c("std"),mycols,ignore.case=T))
# sort them so that the mean and std cols for each variable are together
newcols <-sort(newcols)
out_train <- x_train[,newcols]
out_test <- x_test[,newcols]
# remove the 'angle' features from the dataset as calculating means on these seems unsafe
# (there are 7 angle features starting at column 80)
for (i in 1:7)
{
  out_test[80] <- NULL
  out_train[80] <- NULL
}
# read the activity data and the labels for the factors
act_train <-read.table("./UCI HAR Dataset/train/y_train.txt")
act_test <-read.table("./UCI HAR Dataset/test/y_test.txt")
act_label <-read.table("./UCI HAR Dataset/activity_labels.txt")
# add the activity to the measurement data, looking up the activity label
out_train$activity <-apply(act_train, 1, lookup, act_label)
out_test$activity <-apply(act_test, 1, lookup, act_label)
# add the subject to the measurement data
out_train$subjectId <-as.vector(sub_train$V1)
out_test$subjectId <-as.vector(sub_test$V1)
# calculate the aggregate means for each variable grouped by activity and subject
out_final <- rbind(out_train,out_test)
myAgg2 <- aggregate(. ~ subjectId + activity, data=out_final, FUN = mean)
# Write out the tidy data - excluding the row index.
write.csv(myAgg2,"./tidy_phone.csv",row.names=F)


