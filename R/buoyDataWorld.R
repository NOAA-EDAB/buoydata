#' buoyDataWorld: List of stations
#'
#' A complete list of buoys listed on ndbc website along with buoy specific features such as location and data range.
#'
#' @format A data frame of several elements
#' \describe{
#'     \item{ID}{Buoy ID name}
#'     \item{Y1}{First year of data}
#'     \item{YN}{Last year of data}
#'     \item{nYEARS}{Number of years of data}
#'     \item{LAT}{Latitude}
#'     \item{LON}{Longitude}
#'     \item{STATION_LOC}{Description of station location}
#'     \item{STATION_NAME}{Name of Station}
#'     \item{TTYPE}{Number of years of data}
#'     \item{TIMEZONE}{Time Zone}
#'     \item{OWNER}{Code assigned to OWNERNAME}
#'     \item{OWNERNAME}{Owner organization of data }
#'     \item{COUNTRYCODE}{Country code associated with OWNERNAME}
#'}
#'
#'
#'@source National Data Buoy Center: \url{ndbc.noaa.gov}
"buoyDataWorld"
