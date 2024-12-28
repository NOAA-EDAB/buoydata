#' Gets bouy data from from nbdc
#'
#' Parses historic data webpage and joins with station data listed in txt file stored on web at "https://www.ndbc.noaa.gov/data/stations/"
#'
#' @param exportFile Boolean. Create rda files and save to data folder (Default = F)
#' @param isRunLocal Boolean. Is function being run locally (Default = T).
#'  A different file name is created if running locally that doesn't interfere with git
#'
#'
#'@return lazy data
#'
#'@section READ THIS:
#'
#'This is the main file to create the lazy data exported with the package.
#'
library(magrittr)
source(here::here("data-raw","get_buoy_names.R"))
source(here::here("data-raw","get_buoy_location.R"))

get_buoy_stations <- function(exportFile=F,isRunLocal=T){

  #url where all data is stored
  dataPath <- "https://www.ndbc.noaa.gov/data/stations/"

  # grab txt file of station info
  stations <- read.delim(paste0(dataPath,"station_table.txt"),sep="|",stringsAsFactors = F,header = T)
  stations <- stations[-1,] # first row is empty. Awful text file formatting

  # grab station owners data
  owners <- read.delim(paste0(dataPath,"station_owners.txt"),sep="|",stringsAsFactors = F,header = F)
  owners <- owners[c(-1,-2),] # first row is empty. Awful text file formatting
  names(owners) <- c("OWNER","OWNERNAME","COUNTRYCODE")
  newOwners <- owners %>% dplyr::mutate(OWNER = trimws(OWNER)) %>%
    dplyr::mutate(OWNERNAME = trimws(OWNERNAME)) %>%
    dplyr::mutate(COUNTRYCODE = trimws(COUNTRYCODE))

  # Get names of buoys for which there are data
  buoyData <- get_buoy_names()
  # now select columns TTYPE, TIMEXONE, OWNER from table and join with scaped data
  newData <- stations %>% dplyr::filter(X..STATION_ID %in% buoyData$ID) %>%
    dplyr::select(X..STATION_ID,TTYPE,TIMEZONE,OWNER) %>%
    dplyr::rename(ID = X..STATION_ID)

  newData <- dplyr::left_join(newData,newOwners,by="OWNER")# adds the name and country

  # now get buoy names and stations from web scraping
  #buoyData <- get_buoy_names()
  buoyData <- get_buoy_location(buoyData)

  # now add additional fields to dataframe
  buoyDataWorld <- dplyr::left_join(buoyData,newData,by="ID")

  # create a different file if run locally
  if(isRunLocal){
    fn <- "localdatapull.txt"
  } else {
    fn <- "datapull.txt"
  }

  file.create(here::here("data-raw",fn))
  dateCreated <- Sys.time()
  cat(paste0(dateCreated,"\n"),file=here::here("data-raw",fn))

  #
  if (exportFile) {
    usethis::use_data(buoyDataWorld,overwrite = T)
  }


  return(buoyDataWorld)



}


