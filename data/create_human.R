#Julius Rissanen
#create human dataset

# read human development
hd_webpage <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/human_development.csv"
hd <- read.csv(hd_webpage, stringsAsFactors = F)

# Reading the gender inequality data
gii_webpage <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_2218/datasets/gender_inequality.csv"
gii <- read.csv(gii_webpage, stringsAsFactors = F, na.strings = "..")

#exploring dataset
head(hd)
dim(hd)
str(hd)
summary(hd)


# Gender inequality data describes gender inequality in 195 countries. There is a one gender inequality index (GII) variable and 8 other variables used to create the index. 
head(gii)
dim(gii)
str(gii)
summary(gii)

#checking the names of the variables
names(hd)
names(gii)

#change names to shorter ones
library(plyr)
names(hd)[1] <- "HD.rank"
names(hd)[2] <- "country"
names(hd)[3] <- "hdi"
names(hd)[4] <- "lifexpect"
names(hd)[5] <- "eduexpect"
names(hd)[6] <- "meanedu"
names(hd)[7] <- "gni"
names(hd)[8] <- "GNI_HDI_diff"

# changin the variable names of the gii data
names(gii)[1] <- "gii_rank"
names(gii)[2] <- "country"
names(gii)[3] <- "gii_index"
names(gii)[4] <- "mortality"
names(gii)[5] <- "adole_birth"
names(gii)[6] <- "parlia_represent"
names(gii)[7] <- "eduFem"
names(gii)[8] <- "eduMale"
names(gii)[9] <- "labourFem"
names(gii)[10] <- "labourMale"

library(dplyr)
gii <- mutate(gii, eduF2M = eduFem / eduMale, labourF2m = labourFem / labourMale)
names(gii)

# join variable
join_by <- "country"

# join by country
human <- inner_join(hd, gii, by = join_by)
dim(human)

setwd("C:/Users//Julius//yliopisto//kansis//datascience//IODS-project")
getwd()

write.csv(human, file = "data/human")
