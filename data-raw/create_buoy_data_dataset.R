#' Gets bouy data from from nbdc via ERDDAP
#'
#' THIS IS THE NEW FILE USING ERDDAP
#'
#' Reads in static files containing station data and joins with stations pulled from ERDDAP
#'
#' @param exportFile Boolean. Create rda files and save to data folder (Default = F)
#' @param isRunLocal Boolean. Is function being run locally (Default = T).
#'  A different file name is created if running locally that doesn't interfere with git
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

create_buoy_data_dataset <- function(exportFile = F, isRunLocal = T) {
  # ERDDAP url
  erddap_url <- 'https://coastwatch.pfeg.noaa.gov/erddap/'
  datasetid <- "cwwcNDBCMet"
  info <- suppressMessages(rerddap::info(datasetid, url = erddap_url))

  # distinct stations
  erddap_stations <- rerddap::tabledap(
    info,
    fields = c("station", "longitude", "latitude"),
    distinct = TRUE
  ) |>
    dplyr::rename(LAT = latitude, LON = longitude)

  #url where all data is stored on ndbc site
  ndbc_url <- "https://www.ndbc.noaa.gov/data/stations/"

  # grab txt file of station info
  stations <- read.delim(
    paste0(ndbc_url, "station_table.txt"),
    sep = "|",
    stringsAsFactors = F,
    header = T
  ) |>
    dplyr::rename(ID = X..STATION_ID, STATION_LOC = NAME) |>
    dplyr::filter(!grepl("#", ID)) |> # poor file format - junk rows
    dplyr::mutate(
      dplyr::across(where(is.character), trimws),
      ID = toupper(ID)
    ) |> # erddap has all stations as uppercase
    dplyr::mutate(
      ID = dplyr::case_when((nchar(ID) == 4) ~ paste0(ID, "_"), .default = ID)
    ) |> # erddap changes
    dplyr::select(-LOCATION) |> # a duplicate of LAT and LON
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

  # combine all into one dataframe & Format like exported data
  buoyDataWorld <- dplyr::bind_rows(buoyDataWorld, missing_stations) |>
    dplyr::relocate(
      ID,
      LAT,
      LON,
      STATION_LOC,
      TTYPE,
      TIMEZONE,
      OWNER,
      OWNERNAME,
      COUNTRY
    )

  ## ERDDAP times out too frequently so error handling hd to be introduced
  ## For each station find data availability.
  # This will take about 2 hrs (~ 1300 buoys)
  stationi_meta <- list()
  station_meta <- NULL
  for (i in 1:length(erddap_stations$station)) {
    station_id <- erddap_stations$station[i]
    message(paste0("Processing station: ", i, " - ", station_id))
    attempt <- 1
    success <- FALSE
    while (!success) {
      attempt <- attempt + 1
      tryCatch(
        {
          d <- rerddap::tabledap(
            datasetid,
            fields = c("time"),
            query = paste0('station="', station_id, '"'),
            distinct = TRUE
          )
          success <- TRUE
        },
        error = function(e) {
          message("An error occurred: ", conditionMessage(e))
          message(paste0("Attempt # ", attempt))
          return(NULL)
        }
      )
    }

    yrs <- lubridate::year(d$time) |>
      unique() |>
      sort()

    stationi_meta <- data.frame(
      ID = station_id,
      Y1 = min(yrs),
      YN = max(yrs),
      nYEARS = length(yrs),
      lastMeasurement = tail(d$time, 1)
    )

    station_meta <-
      rbind(station_meta, stationi_meta)
  }

  # join table with metadata
  main_table <- buoyDataWorld |>
    dplyr::left_join(station_meta, by = "ID") |>
    dplyr::relocate(ID, Y1, YN, nYEARS, lastMeasurement)

  # create a different file if run locally

  if (isRunLocal) {
    fn <- "localdatapull.txt"
    saveRDS(main_table, here::here("data-raw/new_data.rds"))
  } else {
    fn <- "datapull.txt"
  }

  file.create(here::here("data-raw", fn))
  dateCreated <- Sys.time()
  cat(paste0(dateCreated, "\n"), file = here::here("data-raw", fn))
  cat(
    paste0("Number of Stations read = ", nrow(station_meta), "\n"),
    file = here::here("data-raw", fn),
    append = TRUE
  )
  cat(
    paste0(
      "number of Stations in buoydata = ",
      nrow(buoydata::buoy_data),
      "\n"
    ),
    file = here::here("data-raw", fn),
    append = TRUE
  )

  buoy_data <- main_table

  if (exportFile) {
    usethis::use_data(buoy_data, overwrite = T)
  }

  return(buoy_data)
}
