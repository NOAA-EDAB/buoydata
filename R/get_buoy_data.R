#' Gets bouy data from ndbc
#'
#' Grabs zipped annual files, unzips and saves as csv files
#' This function will create a folder on your machine and write csv files to it.
#'
#'@param buoyid Character vector. Vector of buoy id names
#'@param year Numeric vector. Years of data to pull
#'@param outDir Character string. Full path to where output should be written
#'
#'@return csv files written
#'
#'@examples
#'\dontrun{
#'get_buoy_data(buoyid="bzbm3",year = 2000:2010,outDir= here::here("output"))
#'
#'}
#'
#'@export
#'

get_buoy_data <- function(buoyid,year,outDir){

  #url where all data is stored
  dataPath <- "http://www.ndbc.noaa.gov/data/historical/stdmet"

  buoyid <- tolower(buoyid)
  year <- as.character(year)

  # ouput folder is buoyname under output folder.
  # This is created on users machine
  outFolder <- paste0(outDir,"/",buoyid)
  if(!dir.exists(outFolder)){
    dir.create(outFolder,recursive=TRUE)
  }

  # loop over years
  for (ay in year) {
    message("Processing year = ",ay," in station = ",buoyid)
    # file format and location of file to be read
    fn <- paste0(buoyid,"h",ay,".txt.gz")
    fpath <- paste0(dataPath,"/",fn)
    # write to a subfolder (buoyname) in outDir
    destfile <- paste0(outFolder,"/",ay,".txt.gz")

    # get file, catch error for missing file
    result <- tryCatch(
      {
        downloader::download(fpath,destfile=destfile,quiet=TRUE)
        res <- TRUE
      },
      error = function(e){
        message(paste0("No data for ",ay))
        return(FALSE)
      } ,
      warning = function(w) return(FALSE)
    )
    if (!result) {
      next
    }


    # Create a connection, read, file -----------------------------------------
    # if a file is present (they are all gz files) then open a connecton
    con <- gzfile(destfile)
    open(con)
    # then read content inside zipped file
    buoyData <- utils::read.delim(con,sep="")
    close(con)

    # remove zipped file
    file.remove(destfile)

    # write the buoy data as a csv file
    readr::write_csv(buoyData,file = paste0(outFolder,"/",buoyid,"_",ay,".csv"),col_names = TRUE)

  }


}
