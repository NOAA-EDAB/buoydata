#' Gets bouy data from from nbdc
#'
#' THIS IS THE NEW FILE USING ERDDAP
#'
#' Reads in static files containing station data and joins with stations pulled from ERDDAP
#'
#' @param exportFile Boolean. Create rda files and save to data folder (Default = F)
#' @param isRunLocal Boolean. Is function being run locally (Default = T).
#'  A different file name is created if running locally that doesn't interfere with git
#' @param buoyIDs Character vector. List specific IDs to pull (Default = NULL, pulls all data)
#'
#'
#'@return lazy data
#'
#'@section READ THIS:
#'
#' NDBC files:
#' station metadata: https://www.ndbc.noaa.gov/data/stations/stations_table.txt
#' supporting owner table: https://www.ndbc.noaa.gov/data/stations/station_owners.txt
#'
#' ERDDAP: https://coastwatch.pfeg.noaa.gov/erddap/tabledap/cwwcNDBCMet.html
#'
#' This is the main file to create the lazy data exported with the package.
#'
#'
#'
library(magrittr)
source(here::here("data-raw", "get_buoy_names.R"))
source(here::here("data-raw", "get_buoy_location.R"))

get_buoyDataWorld <- function(exportFile = F, isRunLocal = T, buoyIDs = NULL) {
  # ERDDAP url
  erddap_url <- 'https://coastwatch.pfeg.noaa.gov/erddap/'
  datasetid <- "cwwcNDBCMet"
  info <- rerddap::info(datasetid, url = erddap_url)

  # distinct stations
  erddap_stations <- rerddap::tabledap(
    info,
    fields = c("station", "longitude", "latitude"),
    distinct = TRUE
  )

  #url where all data is stored on ndbc site
  ndbc_url <- "https://www.ndbc.noaa.gov/data/stations/"

  # grab txt file of station info
  stations <- read.delim(
    paste0(ndbc_url, "station_table.txt"),
    sep = "|",
    stringsAsFactors = F,
    header = T
  ) |>
    dplyr::rename(ID = X..STATION_ID) |>
    dplyr::filter(!grepl("#", ID)) |> # poor file format - junk rows
    dplyr::mutate(
      dplyr::across(where(is.character), trimws),
      ID = toupper(ID)
    ) |> # erddap has all stations as uppercase
    dplyr::mutate(
      ID = dplyr::case_when((nchar(ID) == 4) ~ paste0(ID, "_"), .default = ID)
    ) |> # erddap changes
    dplyr::as_tibble()

  # grab station owners data
  owners <- read.delim(
    paste0(ndbc_url, "station_owners.txt"),
    sep = "|",
    stringsAsFactors = F,
    header = F
  ) |>
    dplyr::rename(OWNERCODE = V1, OWNERNAME = V2, COUNTRY = V3) |>
    dplyr::filter(!grepl("#", OWNERCODE)) |> # poor file format
    dplyr::mutate(dplyr::across(where(is.character), trimws)) |>
    dplyr::as_tibble()

  # join the owners info to the station info
  station_table <- stations |>
    dplyr::left_join(owners, by = c("OWNER" = "OWNERCODE"))

  # filter the table based on available erdapp data
  buoyDataWorld <- station_table |>
    dplyr::filter(ID %in% erddap_stations$station) |>
    dplyr::left_join(erddap_stations, by = c("ID" = "station"))

  # find stations for which there is data but no metadata in station_table file
  stations_missing_metadata <- setdiff(
    erddap_stations$station,
    buoyDataWorld$ID
  )
  missing_stations <- erddap_stations |>
    dplyr::filter(station %in% stations_missing_metadata) |>
    dplyr::rename(ID = station)

  # combine all into one dataframe
  buoyDataWorld <- dplyr::bind_rows(buoyDataWorld, missing_stations)

  ## Format like exported data

  # # Get names of buoys for which there are data
  # buoyData <- get_buoy_names()
  # # now select columns TTYPE, TIMEXONE, OWNER from table and join with scraped data
  # newData <- stations %>%
  #   dplyr::filter(X..STATION_ID %in% buoyData$ID) %>%
  #   dplyr::select(X..STATION_ID, TTYPE, TIMEZONE, OWNER) %>%
  #   dplyr::rename(ID = X..STATION_ID)
  #
  # newData <- dplyr::left_join(newData, newOwners, by = "OWNER") # adds the name and country
  #
  # # now get buoy names and stations from web scraping
  # #buoyData <- get_buoy_names()
  # if (is.null(buoyIDs)) {
  #   buoyData <- get_buoy_location(buoyData)
  # } else {
  #   bd <- buoyData |> dplyr::filter(ID %in% buoyIDs)
  #   buoyData <- get_buoy_location(bd)
  # }
  #
  # # now add additional fields to dataframe
  # buoyDataWorld <- dplyr::left_join(buoyData, newData, by = "ID")

  # create a different file if run locally
  if (is.null(buoyIDs)) {
    if (isRunLocal) {
      fn <- "localdatapull.txt"
      saveRDS(buoyDataWorld, here::here("data-raw/newData.rds"))
    } else {
      fn <- "datapull.txt"
    }
  } else {
    fn <- "datapulltest.txt"
  }

  file.create(here::here("data-raw", fn))
  dateCreated <- Sys.time()
  cat(paste0(dateCreated, "\n"), file = here::here("data-raw", fn))

  #
  if (exportFile) {
    usethis::use_data(buoyDataWorld, overwrite = T)
  }

  return(buoyDataWorld)
}
