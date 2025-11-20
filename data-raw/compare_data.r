# Save current rda file and compare with new one
#
# Only care about difference in ID presence absence

compare_data <- function() {
  current <- readRDS(here::here("data-raw/current_data.rds"))
  new <- readRDS(here::here("data-raw/new_data.rds"))
  # current <- readRDS(here::here("data-raw/erddap/10292025.rds"))
  # new <- readRDS(here::here("data-raw/erddap/10302025.rds"))
  # current <- readRDS(here::here("data-raw/erddap/erddap.rds"))
  # new <- readRDS(here::here("data-raw/erddap/newerddap.rds"))

  # are data sets of the same dimension. May only expect rws to change
  sameDim <- all.equal(dim(current), dim(new))
  sameDim2 <- all.equal(current, new)
  # investigate why dims are different
  # compare col names and IDs
  if (sameDim != FALSE) {
    col_name_dropped <- setdiff(names(current), names(new))
    col_name_added <- setdiff(names(new), names(current))
    ID_dropped <- setdiff(current$ID, new$ID)
    ID_added <- setdiff(new$ID, current$ID)
  } else {
    col_name_dropped <- NA
    col_name_added <- NA
    ID_dropped <- NA
    ID_added <- NA
  }
  # dropped stations/ fields
  if (length(ID_dropped) > 0) {
    # list stations dropped
    dropped <- current |>
      dplyr::filter(ID %in% ID_dropped)
  } else {
    dropped <- NA
  }

  if (length(ID_added) > 0) {
    # list stations added
    added <- new |>
      dplyr::filter(ID %in% ID_added)
  } else {
    added <- NA
  }

  # # rows diffs based on current columns
  # # if new fields were included the whole data set would be a diff.
  # # filter out col differences and compare whats left
  # new <- new |> dplyr::select(-lastMeasurement)
  # current <- current |> dplyr::select(-lastMeasurement)
  #
  # cols_current <- names(current)
  # cols_new <- names(new)
  # dropped_rows <- NA
  # added_rows <- NA
  # if (length(col_name_dropped) > 0) {
  #   dropped_rows <- dplyr::setdiff(
  #     current |> dplyr::select(dplyr::all_of(cols_new)),
  #     new
  #   )
  #   added_rows <- dplyr::setdiff(
  #     new,
  #     current |> dplyr::select(dplyr::all_of(cols_new))
  #   )
  # }
  # if (length(col_name_added) > 0) {
  #   dropped_rows2 <- dplyr::setdiff(
  #     current,
  #     new |> dplyr::select(dplyr::all_of(cols))
  #   )
  #   added_rows2 <- dplyr::setdiff(
  #     new |> dplyr::select(dplyr::all_of(cols)),
  #     current
  #   )
  #   dropped_rows <- rbind(dropped_rows, dropped_rows2)
  #   added_rows <- rbind(added_rows, added_rows2)
  # }

  # checks for empty character strings
  if (identical(col_name_added, character(0))) {
    col_name_added <- NA
  }
  if (identical(col_name_dropped, character(0))) {
    col_name_dropped <- NA
  }
  if (identical(dropped, character(0))) {
    dropped <- NA
  }
  if (identical(added, character(0))) {
    added <- NA
  }
  # if (identical(dropped_rows, character(0))) {
  #   dropped_rows <- NA
  # }
  # if (identical(added_rows, character(0))) {
  #   added_rows <- NA
  # }

  df <- list()
  df$sameDim <- sameDim
  df$dimFields <- sameDim2
  df$col_name_added <- col_name_added
  df$col_name_removed <- col_name_dropped
  df$removed_IDs <- dropped
  df$added_IDs <- added
  # df$removed_rows <- dropped_rows
  # df$added_rows <- added_rows

  return(df)
}
