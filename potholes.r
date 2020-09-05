#libraries used
library(rvest)
library(stringr)
library(textclean)
library(tidyr)

#read webpage into a variable in html format
url <- read_html("https://www.fixmystreet.com/reports")

#extract canvas html node
image <- html_nodes(url, 'canvas')

#extract data-label attr
reported_problems_year <- html_attr(image, 'data-labels')

#store in data-frame
reported_problems_year_values <- as.data.frame(
  reported_problems_year[1],stringsAsFactors = FALSE)

#extract data-values-reports attr
reported_problems_number <- html_attr(image, 
                                      'data-values-reports')

#store in data-frame
reported_problems_number_values <- as.data.frame(
  reported_problems_number[1],stringsAsFactors = FALSE)

#extract data-values-fixed attr
reported_problems_fixed <- html_attr(image, 'data-values-fixed')

#store in data-frame
reported_problems_fixed_values <- as.data.frame(
  reported_problems_fixed[1],stringsAsFactors = FALSE)

#replace unwanted characters with null
reported_problems_year_values <- gsub("\\[", "", 
                                      reported_problems_year_values)
reported_problems_year_values <- gsub("\\]", "", 
                                      reported_problems_year_values)
reported_problems_year_values <- gsub("\"", "",
                                      reported_problems_year_values)

#split values based on separator
a <- separate(as.data.frame(reported_problems_year_values), 
              col = 1, into = c("1","2","3","4","5","6","7",
              "8","9","10","11","12","13"),sep=",")

#store as data-frame
a <- as.data.frame(t(a), stringsAsFactors = FALSE)
colnames(a) <- "Year"

#replace unwanted characters with null
reported_problems_number_values <- gsub("\\[", "", 
                                        reported_problems_number_values)
reported_problems_number_values <- gsub("\\]", "", 
                                        reported_problems_number_values)
#split values based on separator
b <- separate(as.data.frame(reported_problems_number_values), col = 1, 
              into = c("1","2","3","4","5","6","7","8","9",
                       "10","11","12","13"),sep=",")
#store as data-frame
b <- as.data.frame(t(b), stringsAsFactors = FALSE)
colnames(b) <- "No_of_problems"

#replace unwanted characters with null
reported_problems_fixed_values <- gsub("\\[", "", 
                                       reported_problems_fixed_values)
reported_problems_fixed_values <- gsub("\\]", "", 
                                       reported_problems_fixed_values)

#split values based on separator
c <- separate(as.data.frame(reported_problems_fixed_values), 
              col = 1, into = c("1","2","3","4","5","6","7","8",
              "9","10","11","12","13"),sep=",")

#store as data-frame
c <- as.data.frame(t(c), stringsAsFactors = FALSE)
colnames(c) <- "No_of_problems_Fixed"

#combine dataframes
problems <- cbind(a,b,c)

#save to a csv file
write.csv(problems,"problems.csv", row.names = FALSE)
