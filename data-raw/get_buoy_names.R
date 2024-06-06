#' Gets bouy names from nbdc
#'
#' Parses historic data webpage
#'
#'
#'@return lazy data
#'


get_buoy_names <- function(){

  #url where all data is stored
  dataPath <- "http://www.ndbc.noaa.gov/data/historical/stdmet"

  # grab xml and scan it
  webPageNode <- xml2::read_html(dataPath)
  webPage <- xml2::xml_text(webPageNode)
  webPage <- strsplit(webPage,"\\s+")
  # pick out file names
  index <- sapply(webPage[[1]],grepl,pattern="\\.gz")
  files <- webPage[[1]][index]
  files <- unlist(stringr::str_extract_all(files,"[a-zA-Z0-9.]+\\.gz"))

  # now split file names to get df of buoyid and year
  buoyhdate <- simplify2array(strsplit(files,"\\."))[1,]
  buoyid <- simplify2array(strsplit(buoyhdate,"h\\d{4}"))
  year <- regmatches(buoyhdate, regexpr("\\d{4}$", buoyhdate))
  df <- data.frame(ID=buoyid,YEAR=year,stringsAsFactors=FALSE)

  #generate master table
  buoyData <- df |>
    dplyr::group_by(ID) |>
    dplyr::mutate(Y1 = min(as.numeric(YEAR)),YN = max(as.numeric(YEAR)),nYEARS= YN-Y1+1) |>
    dplyr::select(-YEAR) |>
    dplyr::distinct()

  return(buoyData)

}


