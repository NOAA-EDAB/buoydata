#' Gets list of variables available across all buoys
#'
#' Not every buoy contains data for all variables.
#'
#'@return data frame
#'
#'@examples
#'\dontrun{
#'get_variables()
#'
#'}
#'
#'@export
#'

get_variables <- function() {
  # if (!(buoyid %in% buoydata::buoyDataWorld$ID)) {
  #   stop(paste0("The buoy (", buoyid, ") is not a vaid buoy ID."))
  # }

  # ERDDAP url
  erddap_url <- 'https://coastwatch.pfeg.noaa.gov/erddap/'
  datasetid <- "cwwcNDBCMet"
  info <- suppressMessages(rerddap::info(datasetid, url = erddap_url))

  # Find description
  comment_table <- NULL
  for (var_name in info$variables$variable_name) {
    tab <- info$alldata[[var_name]]
    comment_value <- tab |>
      dplyr::filter(attribute_name == "long_name") |>
      dplyr::pull(value)

    df <- data.frame(variable_name = var_name, description = comment_value)

    comment_table <- rbind(
      comment_table,
      df
    )
  }

  # join to info
  table_meta <- info$variables |>
    dplyr::left_join(comment_table, by = "variable_name")

  return(table_meta)
}
