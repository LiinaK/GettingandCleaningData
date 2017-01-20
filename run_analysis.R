library(data.table)
library(dplyr)

#First getting the data from the link provided (and creating a directory for them if needed)

if(!file.exists("/.data")){dir.create("./data")}
fileUrl<-"https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "./data/UCI HAR Dataset.zip", method ="curl")

##Reading the training- and testfiles from the downloaded zip, one by one
xtest <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
##Decided to also have a look at each table to both make sure I got them loaded and to look at the data and see what I'm up against
head(xtest) ##Ok, it was truly dumb to look at it with head(), will only do that once
dim(xtest) ##Smarter, now I know a little more
str(xtest) ##And now I see a little what it is
ytest <- read.table("./data/UCI HAR Dataset/test/Y_test.txt") 
dim(ytest)##Making sure I read it
str(ytest) ##Just looking
subjecttest <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")
dim(subjecttest) ##Making sure I downloaded it
str(subjecttest) ##...and having a look

##downloading and looking at the trainingset
xtrain <- read.table("./data/UCI HAR Dataset/train/x_train.txt")
dim(xtrain)
str(xtrain)
ytrain <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
dim(ytrain)
str(ytrain)
subjecttrain <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
dim(subjecttrain)
str(subjecttrain)

##putting together the testingset and the trainingset
trainingdata <- cbind(xtrain, ytrain, subjecttrain) ##binding the trainingdata
dim(trainingdata)
testingdata <- cbind(xtest, ytest, subjecttest) ##binding the testingdata
dim(testingdata)

##putting it all together
ttdata <- rbind(trainingdata, testingdata)
dim(ttdata) ##I now have one large set

activitylabels <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
dim(activitylabels) ##looks fairly small so I will print it to look at it
activitylabels
features <- fread("./data/UCI HAR Dataset/features.txt") ##had to fread it, with read.table I keep getting the next step as a factor
dim(features) ##Doublecheck and a quick look

labels <- features[,V2]
class(labels) ##just checking
length(labels) ##just checking

placeholdernumbers <- c(1:563) #because I need numbers to combine with
alllabels <- c(labels, "subject", "activity")
labelswnumbers <- paste(placeholdernumbers, alllabels, sep = ".")

##adding the labels to my test- and traningdata
colnames(ttdata) <- labelswnumbers
head(ttdata) ##Having a look

## fix the data into "data frame tbl" to be able to wrangle it with dplyr 
ttdatatbldf <- tbl_df(ttdata)

meanandstdttdata <- select(ttdatatbldf, contains("mean()", ignore.case = TRUE), contains("std()", ignore.case = TRUE))
dim(meanandstdttdata) ##finding out how big it is
View(meanandstdttdata) ## having a look
## I now have a dataframe with 10299 rows in 66 rows

##Let's do something with the names in the set

names(meanandstdttdata) <- gsub("mean", "Mean", names(meanandstdttdata))
names(meanandstdttdata) <- gsub("std", "Std", names(meanandstdttdata))

##Number 5 in the assignment, create a tidy data set with the average of each of the columns above. 
thetidyset <- colMeans(meanandstdttdata)
View(thetidyset) #just having a look

write.table(thetidyset, file = "thetidyset.R", row.name = FALSE) #as instructed, not sure if should be included in this, please disregard if so


