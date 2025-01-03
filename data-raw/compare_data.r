# Save current rda file and compare with new one
#

compare_data <- function() {

  current <- readRDS(here::here("data-raw/tempData.rds"))
  new <- readRDS(here::here("data-raw/newData.rds"))
  #new <- readRDS(here::here("data-raw/testdata.rds"))

  sameDim <- all.equal(dim(current),dim(new))

  # look for changes in some of the columns
  cols <- c("ID","Y1","YN", "nYEARS")
  for (aname in cols) {
    bool <- all.equal(current[[aname]],new[[aname]])
    #message(paste0("Same ",aname," = ",bool))
  }

  # compare just these columns
  cc <- current |> dplyr::select(dplyr::all_of(cols))
  nn <- new |> dplyr::select(dplyr::all_of(cols)) |> dplyr::as_tibble()
  sameMain <- all.equal(nn,cc)

  # return if good

  aa <- dplyr::setdiff(current,new)
  bb <- dplyr::setdiff(new,current) |> dplyr::as_tibble()

  df <- NULL
  # loop through all stations and find differences
  stations <- aa$ID
  for (aid in stations) {
    for (aname in names(aa)) {

      # print(c(aid,aname))
      row <- list()
      aaa <- aa |> dplyr::filter(ID == aid)
      bbb <- bb |> dplyr::filter(ID == aid)

      if ((nrow(aaa) == 0 | nrow(bbb) == 0)) {
        next
      }

      if (is.na(aaa[[aname]]) & is.na(bbb[[aname]])) {
        next
      }
      if (any(is.na(aaa[[aname]]),is.na(bbb[[aname]]))) {
        row <- c(aid,aname,aaa[[aname]],bbb[[aname]])
        # print(aid)
        # print(aaa[[aname]] )
        # print(bbb[[aname]] )
        #print("33333")
        df <- rbind(df,row)
        next
      }


      if (aaa[[aname]] != bbb[[aname]]) {
        if (aname %in% c("LAT","LON")) {
          if (abs(aaa[[aname]]-bbb[[aname]]) > .001) {
            row <- c(aid,aname,aaa[[aname]],bbb[[aname]])
            # print(aid)
            # print(abs(aaa[aname]-bbb[aname]))
            # print("11111")
            df <- rbind(df,row)
          }

        } else {
          row <- c(aid,aname,aaa[[aname]],bbb[[aname]])
          # print(aid)
          # print(aaa[[aname]] )
          # print(bbb[[aname]] )
          #print("22222")
          df <- rbind(df,row)
        }
      }


    }

  }
  df <- data.frame(df,row.names = NULL)
  names(df) <- c("ID","Var","Current","New")


  return(list(df=df,sameDim=sameDim,sameMain=sameMain,mainVars = cols))

}
