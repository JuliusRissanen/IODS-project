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



#Chapter 5 continuation

library(stringr)


# GNI to numeric
human$gni <- str_replace(human$gni, pattern=",", replace ="") %>% as.numeric() 

    
# defining a subset of variables that would be used in later analyses
keep <- c("country", "eduF2M", "labourF2m", "eduexpect", "lifexpect", "gni", "mortality", "adole_birth", "parlia_represent")

# keep only variables defined above 
human <- select(human, one_of(keep))
str(human)

# filter that we include only complete.cases
human_ <- filter(human, complete.cases(human) == TRUE)

#which are regions?
human_$country
#->last 7 are regions

# remove regions
last <- nrow(human_) - 7
human_ <- human_[1:last, ]

# rownames as countrynames and remove country variable
rownames(human_) <- human_$country
human_ <- select(human_, -country)

# check rows and variables
dim(human_)
str(human_)
head(human_)


write.csv(human_, "data/human.csv", row.names = TRUE)
human_test<- read.csv("data/human.csv", header = TRUE, row.names = 1)
dim(human_test)
head(human_test)
str(human_test)
