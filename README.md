
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

Find all buoys located between latitude \[41,43\] and longitude
\[-71,-67\] with a time series of at least 20 years. Then pull and
process data from a single buoy.

``` r
library(ndbcbuoy)
library(magrittr)

ndbcbuoy::buoyData %>% dplyr::filter(LAT > 41,LAT < 43) %>%
  dplyr::filter(LON > -71, LON < -69) %>%
  dplyr::filter(nYEARS >= 20)
#>      ID   Y1   YN nYEARS    LAT     LON                      STATION_LOC
#> 1 44013 1984 2019     36 42.346 -70.651 BOSTON 16 NM East of Boston, MA.
#> 2 iosn3 1984 2019     36 42.967 -70.623              Isle of Shoals, NH.
#>   STATION_NAME
#> 1         <NA>
#> 2         <NA>
```

``` r
# get the data for buoy 44013
get_buoy_data(buoyid="44013",year=1984:2019,outDir=here::here("output"))

# process sea surface temperature (celcius) into one large data frame
data <- combine_buoy_data(buoyid = "44013",variable="WTMP",inDir = here::here("output"))
```

Then plot the data

``` r
 ggplot2::ggplot(data) +
   ggplot2::geom_line(ggplot2::aes(x=DATE,y=WTMP)) + 
   ggplot2::ylab("Sea Surface Temp (Celcius)") +
   ggplot2::xlab("")
```

<img src="man/figures/WTMP44013.png" align="center" width="100%"/>
