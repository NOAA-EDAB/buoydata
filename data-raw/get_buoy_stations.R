#' Gets bouy data from from nbdc
#'
#' Parses historic data webpage and joins with station data listed in txt file stored on web at "https://www.ndbc.noaa.gov/data/stations/"
#'
#'
#'@return lazy data
#'
#'@section READ THIS:
#'
#'This is the main file to create the lazy data exported with the package.
#'
library(magrittr)


get_buoy_stations <- function(){

  #url where all data is stored
  dataPath <- "https://www.ndbc.noaa.gov/data/stations/"

  # grab txt file of station info
  stations <- read.delim(paste0(dataPath,"station_table.txt"),sep="|",stringsAsFactors = F,header = T)
  stations <- stations[-1,] # first row is empty. Awful text file formatting

  # grab station owners data
  owners <- read.delim(paste0(dataPath,"station_owners.txt"),sep="|",stringsAsFactors = F,header = F)
  owners <- owners[c(-1,-2),] # first row is empty. Awful text file formatting
  names(owners) <- c("OWNER","OWNERNAME","COUNTRYCODE")
  owners <- owners %>% dplyr::mutate(OWNER = sub("\\s$","",OWNER))

  # now select columns TTYPE, TIMEXONE, OWNER from table and join with scaped data
  newData <- table %>% dplyr::filter(X..STATION_ID %in% ndbcbuoy::buoyData$ID) %>%
    dplyr::select(X..STATION_ID,TTYPE,TIMEZONE,OWNER) %>%
    dplyr::rename(ID = X..STATION_ID)

  newData <- dplyr::left_join(newData,owners,by="OWNER")# adds the name and country

  # now get buoy names and stations from web scraping
  buoyData <- get_buoy_names()
  buoyData <- get_buoy_location(buoyData)

  # now add additional fields to dataframe
  buoyData <- dplyr::left_join(buoyData,newData,by="ID")
  save(buoyData,file="data/buoyData.RData")

  return(buoyData)



}


