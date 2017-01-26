
#store internet address to variable
internetAddress <- "http://www.helsinki.fi/~kvehkala/JYTmooc/JYTOPKYS3-data.txt"

#load data, it actually has tab separedt values so that is taken into account
fullLearning2014 <- read.csv(internetAddress, sep = "\t", header = T)

#check structure and that everything is fine
str(fullLearning2014)

#install needed packages by uncommenting lower line
#install.packages("dplyr")

#call needed libraries
library(dplyr)


#needed variables stored to memoery which are ready
ready_variables <- c("gender", "Points", "Attitude", "Age")

#new dataset with ready variables.
learning2014 <- select(fullLearning2014, one_of(ready_variables))
#check it's correctly selected
summary(learning2014)
str(learning2014)

#pick the right question for making variables
deep_questions <- c("D03", "D11", "D19", "D27", "D07", "D14", "D22", "D30","D07","D14","D22","D30")
surface_questions <- c("SU02","SU10","SU18","SU26", "SU05","SU13","SU21","SU29","SU08","SU16","SU24","SU32")
strategic_questions <- c("ST01","ST09","ST17","ST25","ST04","ST12","ST20","ST28")

#making the 'deep' variable
deep_columns <- select(fullLearning2014, one_of(deep_questions))
learning2014$deep <- rowMeans(deep_columns)

#making the 'surf' variable
surface_columns <- select(fullLearning2014, one_of(surface_questions))
learning2014$surf <- rowMeans(surface_columns)

#making the 'stra' variable 
stra_columns <- select(fullLearning2014, one_of(strategic_questions))
learning2014$stra <- rowMeans(stra_columns)

#delete everyone with 0 in points variable
learning2014 <- filter(learning2014, Points > 0)

#check new dataset for problems
str(learning2014)
summary(learning2014)
# ---> looks fine =)

#set working directory to the right one
setwd("C:/Users//Julius//yliopisto//kansis//datascience//IODS-project")
getwd()

#write our learning2014 dataset to the data folder of our working directory
write.csv(learning2014, file = "data/learning2014")

#test to see if reading works also correctly. Needed to correct that first row is not variable
# thus 'row.names = 1'
readTestLearning2014 <- read.csv(file = "data/learning2014", row.names = 1)
str(readTestLearning2014)
summary(readTestLearning2014)
