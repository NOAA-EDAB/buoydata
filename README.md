
<!-- README.md is generated from README.Rmd. Please edit that file -->

# ndbcbuoy

<!-- badges: start -->

<!-- badges: end -->

The goal of ndbcbuoy is to easily download and process buoy data hosted
by National Data Buoy Center

## Installation

``` r
remotes::install_github("andybeet/ndbcbuoy")
```

## Example

This is a basic example which shows you how pull and process data from a
single buoy located in [Woods
Hole](https://www.ndbc.noaa.gov/station_history.php?station=bzbm3), buoy
id = “bzbm3”

``` r
library(ndbcbuoy)

# get the data
get_buoy_data(buoyid="bzbm3",year=2000:2020,outDir=here::here("output"))

# process Sea surface temperature (celcius) into one large data frame
data <- combine_buoy_data(buoyid = "bzbm3",variable="WTMP",inDir = here::here("output"))
```
