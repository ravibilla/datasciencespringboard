# Springboard | Fundamentals of Data Science | Data Wrangling | Exercise 1: Basic Data Manipulation
require("dplyr")
require("tidyr")

# Construct path to file
fpath <- file.path(getwd(), "refine_original.csv");

# 0: Load the data in RStudio
mydata <- read.csv(fpath)

# 1: Clean up brand names
# Convert all column names to lowercase
names(mydata) <- tolower(names(mydata))

# Convert all company names to lowercase
mydata$company <- tolower(mydata$company)

# Fix misspellings for "philips"
mydata$company[which(mydata$company == "phillips" | 
                     mydata$company == "phllips"  |   
                     mydata$company == "phillps"  | 
                     mydata$company == "fillips"  | 
                     mydata$company == "phlips" 
             )] <- "philips"

# Fix misspellings for "akzo"
mydata$company[which(mydata$company == "akzo" | 
                     mydata$company == "akz0" |
                     mydata$company == "ak zo"  
            )] <- "akzo"

# Fix misspellings for "unilever"
mydata$company[which(mydata$company == "unilver")] <- "unilever"

# 3: Add product categories
mydata <- mydata %>% 
  separate(product.code...number, c("product_code", "product_number"), "-")

mydata <- mydata %>%
  mutate(product_category = ifelse(product_code == "p", "Smartphone", 
                                   ifelse(product_code == "v", "TV",
                                          ifelse(product_code == "x", "Laptop",
                                                 ifelse(product_code == "q", "Tablet","")))))

# 4: Add full address for geocoding
mydata <- mydata %>%
  unite(full_address, address, city, country, sep = ", ")

# 5: Create dummy variables for company and product category
# Create dummy variables for companies
mydata <- mydata %>%
  mutate(company_philips = ifelse(company == "philips", 1, 0))

mydata <- mydata %>%
  mutate(company_akzo = ifelse(company == "akzo", 1, 0))

mydata <- mydata %>%
  mutate(company_van_houten = ifelse(company == "van houten", 1, 0))

mydata <- mydata %>%
  mutate(company_unilever = ifelse(company == "unilever", 1, 0))

# Create dummy variables for product categories
mydata <- mydata %>%
  mutate(product_smartphone = ifelse(product_category == "Smartphone", 1, 0))

mydata <- mydata %>%
  mutate(product_tv = ifelse(product_category == "TV", 1, 0))

mydata <- mydata %>%
  mutate(product_laptop = ifelse(product_category == "Laptop", 1, 0))

mydata <- mydata %>%
  mutate(product_tablet = ifelse(product_category == "Tablet", 1, 0))

# Write CSV file
write.csv(mydata, "refine_clean.csv", row.names=FALSE)