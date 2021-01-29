install.packages("DBI")
install.packages("RMySQL")

library(DBI)
library(RMySQL)


MyDataBase <- dbConnect(
  
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest"
)

dbListTables(MyDataBase)

dbListFields(MyDataBase, 'CountryLanguage')

dataLanguage <- 
  dbGetQuery(MyDataBase, "Select * from CountryLanguage")

names(dataLanguage)

install.packages("dplyr")
library(dplyr)

languageCountry <- dataLanguage %>% 
  filter(Language == "Spanish")

languageCountryDF <- 
  as.data.frame(languageCountry)

install.packages("ggplot2")
library(ggplot2)

languageCountryDF %>% 
  ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()
