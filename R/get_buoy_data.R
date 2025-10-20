#' Gets buoy data from ERDDAP
#'
#' Pulls data from ERDDAP. All buoys will have the same format. However there will be
#' cases where some variables will have NAs for the entire variable.
#'
#'@param buoyid Character. Name of buoys id. See `buoyDataWorld` for list of buoys available
#'@param vars Character vector. Vector of variables to pull. Default = NULL, pull all available variables. If you select spcific variables the resulting data frame will be considerably smaller
#'
#'@return A data frame
#'
#'@examples
#'\dontrun{
#'get_buoy_data(buoyid="42066", vars = NULL)
#'
#'}
#'
#'@export
#'

get_buoy_data <- function(
  buoyid,
  vars = NULL
) {
  # # ERDDAP url
  erddap_url <- 'https://coastwatch.pfeg.noaa.gov/erddap/'
  datasetid <- "cwwcNDBCMet"
  info <- suppressMessages(rerddap::info(datasetid, url = erddap_url))

  var_table <- get_variables()
  if (is.null(vars)) {
    vars <- setdiff(
      var_table$variable_name,
      c("station", "longitude", "latitude")
    )
  } else {
    vars <- c("time", vars)
  }

  success <- FALSE
  while (!success) {
    tryCatch(
      {
        buoy_data <- rerddap::tabledap(
          datasetid,
          fields = vars,
          query = paste0('station="', buoyid, '"')
        )
        success <- TRUE
      },
      error = function(e) {
        message("An error occurred: ", conditionMessage(e))
        message(paste0("Trying again ..."))
        return(NULL)
      }
    )
  }

  return(buoy_data)
}
