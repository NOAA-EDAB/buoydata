#' read in News.md and change content
#'
#'

write_to_news <- function(aa, con) {
  nms <- letters[1:length(names(aa))]
  names(aa) <- nms
  g <- aa |>
    dplyr::mutate(a = paste0(a, " - ", g, ": ")) |>
    dplyr::mutate(
      entry = paste0(a, "[", e, ",", f, "]. ", b, "-", c, " (", d, " yrs).")
    ) |>
    dplyr::select(entry)
  for (iline in 1:nrow(g)) {
    writeLines(paste("*", as.character(g[iline, ])), con)
  }
  writeLines("", con)
}


update_news <- function(version, compare) {
  if (is.null(version)) {
    # No changes found between new and old data
    # no changes to news.md
  } else {
    # read in News.md file
    con <- file(here::here("NEWS.md"), open = "r")
    currentNews <- readLines(con)
    close(con)

    con <- file(here::here("NEWS.md"), open = "w")

    # translate compare to md text
    writeLines(paste0("# buoydata ", version), con)
    writeLines("", con)
    writeLines(paste0("Data pull: ", format(Sys.Date(), "%B %d, %Y")), con)
    writeLines("", con)

    # write changes to top of file then write old news
    if (!is.null(compare$added_rows) && nrow(compare$added_rows) > 0) {
      writeLines("### Stations added ", con)
      writeLines("", con)

      reduce_fields_add <- compare$added_rows |>
        dplyr::select(ID, Y1, YN, nYEARS, LAT, LON, STATION_LOC)

      write_to_news(reduce_fields_add, con)
    }
    if (!is.null(compare$removed_rows) && nrow(compare$removed_rows) > 0) {
      writeLines("### Stations removed ", con)
      writeLines("", con)

      reduce_fields_remove <- compare$removed_rows |>
        dplyr::select(ID, Y1, YN, nYEARS, LAT, LON, STATION_LOC)

      write_to_news(reduce_fields_remove, con)
    }

    writeLines(currentNews, con)
    close(con)
  }
}
