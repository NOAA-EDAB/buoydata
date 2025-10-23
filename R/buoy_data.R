#' buoy_data: NDBC Standard Meteorological Buoy Data, 1970-present
#'
#' A complete list of buoys listed on ERDDAP along with buoy specific features such as location and data range.
#'
#' @format A data frame
#' \describe{
#'     \item{ID}{Buoy ID name}
#'     \item{Y1}{First year of data}
#'     \item{YN}{Last year of data}
#'     \item{nYEARS}{Number of years of data}
#'     \item{lastMeasurement}{Date/Time of the last recorded measurement}
#'     \item{LAT}{Latitude}
#'     \item{LON}{Longitude}
#'     \item{STATION_LOC}{Description of station location}
#'     \item{TTYPE}{Number of years of data}
#'     \item{TIMEZONE}{Time Zone}
#'     \item{OWNER}{Code assigned to OWNERNAME}
#'     \item{OWNERNAME}{Owner organization of data }
#'     \item{COUNTRY}{Country code associated with OWNERNAME}
#'     \item{HULL}{}
#'     \item{PAYLOAD}{}
#'     \item{FORECAST}{}
#'     \item{NOTE}{NDBC notes regarding buoy}
#'}
#'
#'
#'@source ERDDAP: \url{https://coastwatch.pfeg.noaa.gov/erddap/tabledap/cwwcNDBCMet.html}. This data is pulled from National Data Buoy Center: \url{ndbc.noaa.gov} on a cron job
"buoy_data"
