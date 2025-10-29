#' creates internal data sets for use in vignettes
#'
#'
#' @param exportFile Boolean. Create rda files and save to data folder (Default = F)
#' @param isRunLocal Boolean. Is function being run locally (Default = T).
#'  A different file name is created if running locally that doesn't interfere with git
#'
#'@return lazy data
#'
#'
#'

create_internal_data <- function(exportFile = F, isRunLocal = T) {
  # get vars table
  vars <- buoydata::get_variables()
  # get buoy data
  buoy_44018 <- buoydata::get_buoy_data(buoyid = "44018", var = "wtmp")

  if (exportFile) {
    usethis::use_data(vars, buoy_44018, overwrite = T, internal = T)
  }

  return(list(vars = vars, buoy_44018 = buoy_44018))
}
