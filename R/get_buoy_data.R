#' Gets bouy data from nbdc
#'
#' @param buoyid Character vector. Vector of buoy id names
#' @param year Numeric vector. Years of data to pull
#'@param outDir Character string. Full path to where output should be written
#'
#'@export
#'

get_buoy_data <- function(buoyid="bzbm3",year,outDir){

  dataPath <- "http://www.ndbc.noaa.gov/data/historical/stdmet"

  if(!dir.exists(outDir)){
    dir.create(outDir)
  }

  buoyid <- tolower(buoyid)
  year <- as.character(year)

  for (ay in year) {
    message("Processing year = ",ay," in station = ",buoyid)
    fn <- paste0(buoyid,"h",ay,".txt.gz")
    fpath <- paste0(dataPath,"/",fn)
    outFolder <- paste0(outDir,"/",buoyid)

    if(!dir.exists(outFolder)){
      dir.create(outFolder)
    }

    destfile <- paste0(outFolder,"/",ay,".txt.gz")

    result <- tryCatch(
      {
      download.file(fpath,destfile=destfile,quiet=TRUE)
      res <- TRUE
      },
      error = function(e) return(FALSE),
      warning = function(w) return(FALSE)
    )

    if (!result) {
      file.remove(destfile)
      next
    }

    con <- gzfile(destfile)
    open(con)

    headers <- readLines(con,n=1)
    headers <- strsplit(substr(headers,2,nchar(headers)),"\\s+")
    buoyData <- read.table(con)
    colnames(buoyData) <- headers[[1]]

    close(con)

    file.remove(destfile)

    # write the buoy data as a csv file
    readr::write_csv(buoyData,path = paste0(outFolder,"/",buoyid,"_",ay,".csv"),col_names = TRUE)

  }


}
