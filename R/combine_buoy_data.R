#' Combine annual buoy data files
#'
#' All files available for a buoy are concatenated over time. Caution: some variables have changed in name over time
#'
#'@param buoyid Character vector. Vector of buoy id names
#'@param variable Character string. Name of the variable to pull
#'@param inDir Character string. Full path to the buoy folder. Same as outDir in \code{get_buoy_data}
#'
#'@return dataframe (nx4)
#'\item{YEAR}{Year}
#'\item{MONTH}{Month}
#'\item{DAY}{Day}
#'\item{"Variable"}{The name of the variable passed to the function}
#'
#'
#'@examples
#'\dontrun{
#'combine_buoy_data(buoyid="bzbm3",variable = "WTMP",inDir= here::here("output"))
#'
#'}
#'
#'@export


combine_buoy_data <- function(buoyid,variable,inDir){

 # create path to buoy directory and list file names
 buoyid <- tolower(buoyid)
 buoyDir <- paste0(inDir,"/",buoyid)
 annualFiles <- list.files(buoyDir)
 annualFiles <- annualFiles[grepl("*.csv",annualFiles)]


 masterBuoyData <- data.frame()

 # process each csv file by year and concatenate
 for (afile in annualFiles) {
   fileParts <- strsplit(afile,"\\.")
   year <- strsplit(fileParts[[1]][1],"_")[[1]][2]
   message("Processing year = ",year)
   fData <- read.csv(paste0(buoyDir,"/",afile),stringsAsFactors = FALSE)
   # check for unit headers in first row
   if (any(grepl("#*",fData[1,]))) {
      fData <- fData[-1,]
   }


   # fix for Year column. Early years YYY later Years YY
   dataNames <- colnames(fData)
   year <- dataNames[grepl("YY*",dataNames)]

   fileData <- fData[,c(year,"MM","DD",variable)]
   names(fileData) <- c("YEAR","MONTH","DAY",variable)
   fileData$YEAR <- as.numeric(fileData$YEAR)
   fileData$YEAR[fileData$YEAR < 1999] <- fileData$YEAR[fileData$YEAR < 1999] + 1900
   fileData$MONTH <- as.numeric(fileData$MONTH)
   fileData$DAY <- as.numeric(fileData$DAY)
   fileData[[variable]] <- as.numeric(fileData[[variable]])
   fileData[[variable]][fileData[[variable]] == 999] <- NA

   fileData <- fileData |>
     dplyr::mutate(DATE = lubridate::ymd(paste0(YEAR,sprintf(paste0("%02d"),MONTH),sprintf(paste0("%02d"),DAY))))

   masterBuoyData <- rbind(masterBuoyData,fileData)

 }

 return(dplyr::as_tibble(masterBuoyData))


}
