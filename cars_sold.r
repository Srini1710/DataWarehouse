library(readxl)

#Read the Data sheet from excel file
registrations <- read_excel("statistic_id312594_number-of-motorcycles-and-cars-registered-in-great-britain--uk--2000-2017.xlsx", sheet = "Data")
registrations

#save as data-frame
car_registration <- as.data.frame(registrations[8:19,2])
car_registration

#save as data-frame
motorcycle_registration <- as.data.frame(registrations[8:19,3])
motorcycle_registration

#Read the Data sheet from excel file
road_transport_investment <- read_excel("statistic_id438720_investment-in-road-transport-infrastructure-in-the-uk-2004-2016.xlsx", sheet = "Data")
road_transport_investment

#save as data-frame
years <- as.data.frame(road_transport_investment[4:15,1])
years

#save as data-frame
amount_spent_on_road_development <- as.data.frame(road_transport_investment
                                                  [4:15,2])
amount_spent_on_road_development

#join the dataframe and give column names
extracted_statista_data_1 <-cbind(years, amount_spent_on_road_development) 
colnames(extracted_statista_data_1) <- c("Year","Amount_Spent_on_Road_Development")
extracted_statista_data_1

#join the dataframe and give column names
extracted_statista_data_2 <- cbind(years, car_registration, motorcycle_registration)
colnames(extracted_statista_data_2) <- c("Year","Cars_Registered","Motorcycle_Registered")

extracted_statista_data_2

#write to a csv file
write.csv(extracted_statista_data_2, file = "registration.csv",
          row.names = FALSE)

#write to a csv file
write.csv(extracted_statista_data_1, file = "Statista.csv",
          row.names = FALSE)