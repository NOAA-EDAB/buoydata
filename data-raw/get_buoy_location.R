#' Grabs station info for all stations
#'
#' Uses output fron \code{get_buoy_names} and then parse each of the buoys webpages to extract common name, location, etc
#'
#'@param buoyData Data frame. Output from get_buoy_names
#'
#'

get_buoy_location <- function(buoyData) {
  webPageLink <- "https://www.ndbc.noaa.gov/station_history.php?station="

  buoyTable <- data.frame()

  for (ibuoy in 1:dim(buoyData)[1]) {
    abuoy <- buoyData$ID[ibuoy]
    message(paste0("buoy ", ibuoy, " of ", dim(buoyData)[1]))

    # form webpage link, get page and then line with info we need
    buoyPage <- paste0(webPageLink, abuoy)
    res <- tryCatch(
      {
        htmlPage <- readLines(buoyPage)
        res <- TRUE
      },
      error = function(e) {
        message(paste0("Warning: No webpage for buoy ", abuoy))
        res <- FALSE
      },
      warning = function(w) {
        message(paste0("Warning: No webpage for buoy ", abuoy))
        res <- FALSE
      }
    )

    if (!res) {
      buoy <- data.frame(
        buoyData[ibuoy, ],
        LAT = NA,
        LON = NA,
        STATION_LOC = NA,
        STATION_NAME = NA
      )
    } else {
      line <- htmlPage[grepl("DC\\.description", htmlPage)]
      # now split line and grab pieces
      locString <- strsplit(line, toupper(abuoy))[[1]][2]
      locString <- strsplit(locString, "\\s-\\s")

      # scrape lat and long
      latLong <- sub("^\\s", "", locString[[1]][1])
      latLong <- sub("\\(", "", latLong)
      latLong <- sub("\\)", "", latLong)
      latLongDir <- strsplit(latLong, "\\s")
      latLongDir[[1]][2] <- sub("\\.\"$", "", latLongDir[[1]][2])

      islat <- (grepl("[nN]", latLongDir[[1]][1]) * 2) - 1 # convert EW to +1, -1
      lat <- as.numeric(sub("[A-z]", "", latLongDir[[1]][[1]])) * islat
      islon <- (grepl("[eE]", latLongDir[[1]][2]) * 2) - 1
      lon <- as.numeric(sub("[A-z]", "", latLongDir[[1]][[2]])) * islon

      print(length(locString[[1]]))
      print(line)
      print("###########################################################")
      if (length(locString[[1]]) == 3) {
        # latlon, station num, station name
        name <- locString[[1]][2]
        loc <- strsplit(locString[[1]][3], "\"")[[1]][1]
      } else if (length(locString[[1]]) == 2) {
        #latlon, station name
        name <- NA
        loc <- strsplit(locString[[1]][2], "\"")[[1]][1]
      } else if (length(locString[[1]]) == 4) {
        name <- paste(locString[[1]][2:3], collapse = "-")
        loc <- strsplit(locString[[1]][4], "\"")[[1]][1]
        print(name)
        print(loc)
      } else if (length(locString[[1]]) > 4) {
        print(locString)
        stop("FORMAT")
      }

      buoy <- data.frame(
        buoyData[ibuoy, ],
        LAT = lat,
        LON = lon,
        STATION_LOC = loc,
        STATION_NAME = name
      )
    }

    buoyTable <- rbind(buoyTable, buoy)
  }
  buoyData <- buoyTable

  return(buoyData)
}
