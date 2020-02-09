#' Combine annual buoy data files
#'
#' All files available for a buoy are concatenated over time. Caution: some variables have changed in name over time
#'
#'@param buoyid Character vector. Vector of buoy id names
#'@param variable Character string. Name of the variable to pull
#'@param inDir Character string. Full path to where annual files are located
#'
#'@return dataframe (nx4)
#'\item{YEAR}{Year}
#'\item{MONTH}{Month}
#'\item{DAY}{Day}
#'\item{"Variable"}{The name of the variable passed to the function}
#'
#'@export
#'

combine_buoy_data <- function(buoyid="bzbm3",variable,inDir){

 buoyid <- tolower(buoyid)
 annualFiles <- list.files(inDir)

 masterBuoyData <- data.frame()

 for (afile in annualFiles) {
   fileParts <- strsplit(afile,"\\.")
   year <- strsplit(fileParts[[1]][1],"_")[[1]][2]
   message("Processing year = ",year)
   fData <- readr::read_csv(paste0(inDir,"/",afile),col_types = readr::cols())

   dataNames <- colnames(fData)
   year <- dataNames[grepl("YY*",dataNames)]

   fileData <- fData[,c(year,"MM","DD",variable)]
   names(fileData) <- c("YEAR","MONTH","DAY",variable)


   masterBuoyData <- rbind(masterBuoyData,fileData)

 }

 return(masterBuoyData)


}
