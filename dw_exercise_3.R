## Springboard | Fundamentals of Data Science | Data Wrangling | Exercise 3: 
## Human Activity Recognition
require("dplyr")
require("tidyr")

## Construct path to file
fpath <- file.path(getwd(), "titanic_original.csv");

## 0: Load the data in RStudio
titanic <- read.csv(fpath)
# The following can also be used to load the csv file
#titanic <- read.csv(fpath, na.strings = c("NA", ""))

## 1: Port of embarkation
# Replace missing values in the embarked with "S"
titanic$embarked[titanic$embarked %in% c("", " ", "NA")] <- "S"
# Actually there are two missing values in the embarked column, rows 169 & 285

## 2: Age
# Replace missing values in age colum with mean
titanic$age[is.na(titanic$age)] <- mean(titanic$age, na.rm = TRUE)
mean(titanic$age, na.rm = TRUE) # Mean age: [1] 29.88113
median(titanic$age, na.rm = TRUE) # Median age: [1] 28
# We could also pick median to replace missing age values. Since both mean and
# median are very close, we could use either of them in this case.

## 3: Lifeboat
# Replace missing values in the boat column with NA
titanic$boat[titanic$boat %in% c("", " ", "NA")] <- NA

## 4: Cabin
# It doesn't make sense to replace the missing values in cabin column. Missing
# values here might mean that these passengers do not have a cabin (low fare 
# passengers)
# Create a dummy column has_cabin_number which has 1 if there is a cabin number, 
# and 0 otherwise.
titanic <- titanic %>%
  mutate(has_cabin_number = ifelse(cabin %in% c("", " ", "NA"), 0, 1))

# Write CSV file
write.csv(titanic, "titanic_clean.csv", row.names=FALSE)