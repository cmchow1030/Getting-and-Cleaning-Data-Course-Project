#new a project and connect to github (https://github.com/cmchow1030/Getting-and-Cleaning-Data-Course-Project.git)

### 1. Merges the training and the test sets to create one data set.### 

#read the files, including data sets, feature names and activity labels
subject_test <-  read.table("test/subject_test.txt")
y_test <-  read.table("test/y_test.txt")
X_test <- read.table("test/X_test.txt")
subject_train <-  read.table("train/subject_train.txt")
y_train <-  read.table("train/y_train.txt")
X_train <- read.table("train/X_train.txt")
feature_name <- read.table("features.txt")
activity_labels <- read.table("activity_labels.txt")

#update the column name information for the combined dataframe
names <- data.frame(V2 = c("subject", "activity"))
column_names<-rbind(names, feature_name[2])

#combine the dataframe
test <- cbind(subject_test, y_test, X_test)
train <- cbind(subject_train, y_train, X_train)

#merge two data sets
data <- rbind(test, train)
#rename the columns
colnames(data)<-column_names[[1]] #alternative way: as.character(unlist(unclass(column_names)))
s_data <-data[order(data$subject), ]

### 2. Extracts only the measurements on the mean and # 
### standard deviation for each measurement. ##########

#select columns with names containing "mean" or "std" but keep the first two columns
ss_data <- s_data[ , grep("mean|std", names(s_data))]
sss_data<- cbind(s_data[c("subject", "activity")], ss_data) #sss_data<- cbind(s_data[ ,1:2], ss_data)

### 3. Uses descriptive activity names  ####
### to name the activities in the data set##

#add activity labels
#reorder the data sets according to subject and activity labels
colnames(activity_labels) <- c("activity", "activity_name")
rsss_data<- merge(activity_labels, sss_data, by = "activity")
rrsss_data <-rsss_data[order(rsss_data$subject, rsss_data$activity), ] 

### 4. Appropriately labels the data set with descriptive variable names. ###

# transform the traditional data.frame into a tibble
#load library tidyverse
library(tibble)
t_data <- as_tibble(rrsss_data)
library(tidyverse)

#make the feature names more descriptive
clean_t_data <- t_data %>%
        rename_with(~ gsub("\\(\\)", "", .x)) %>%        # remove parentheses
        rename_with(~ gsub("mean", "MeanValue", .x)) %>% # replace "mean" with "MeanValue"
        rename_with(~ gsub("std", "StdDev", .x)) %>%     # replace "std" with "StdDev"
        rename_with(~ gsub("-", "_", .x)) %>%           # replace "-" with "_"
        rename_with(~ ifelse(grepl("(X|Y|Z)$", .x),
                             paste0(.x, "_axis"), .x)) # add "_axis" only if ends with X/Y/Z

#averages each variable for each activity and each subject
averages <- clean_t_data %>%
        select(subject, activity_name, everything(), -activity) %>%
        group_by(activity_name, subject) %>%
        summarise(across(where(is.numeric), mean, na.rm = TRUE))

### 5. creates a second, independent tidy data set with the  ####
### average of each variable for each activity and each subject##

# output the table of averages as a text file as instructed in the assignment guide
write.table(averages, "clean_data.txt",  row.name=FALSE)
# output the table of averages as a csv file using readr package in tidyverse for reference
write_csv(averages, "clean_data.csv")

# output column name list for the codebook
col_name_list <- names(averages)
write_csv(as.data.frame(col_name_list), "col_name_list2.csv")