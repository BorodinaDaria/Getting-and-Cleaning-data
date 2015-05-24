x_train = read.table("./UCI HAR Dataset/train/X_train.txt")
y_train = read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train = read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test = read.table("./UCI HAR Dataset/test/X_test.txt")
y_test = read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test = read.table("./UCI HAR Dataset/test/subject_test.txt")

activity = read.table("./UCI HAR Dataset/activity_labels.txt")
features = read.table("./UCI HAR Dataset/features.txt")

names(x_train) = features[,2]
names(x_test) = features[,2]

x = rbind(x_train, x_test)
y = rbind(y_train, y_test)
subject = rbind(subject_train, subject_test)
names(subject) = "Subject"

y_activity = join(y, activity, by = "V1")
y = y_activity[,2]
names(data[,1]) = "Activity"

data = cbind(y, subject, x)

features_mean = grepl(pattern="-mean()", features[,2], fixed=TRUE)
features_std = grepl(pattern="-std()", features[,2], fixed=TRUE)
features_mean_std = features_mean | features_std
data_mean_std = data[, c(TRUE, features_mean_std)]

data_2 <- ddply(data_mean_std, .(Subject, Activity), colwise(mean))
write.table(data_2, file="result.txt", row.name=FALSE)
