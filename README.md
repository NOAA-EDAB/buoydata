
<!-- README.md is generated from README.Rmd. Please edit that file -->

# buoydata <img src="man/figures/logo.png" align="right" width="120" />

<!-- badges: start -->

[![gh-pages](https://github.com/NOAA-EDAB/buoydata/actions/workflows/pkgdown.yml/badge.svg)](https://github.com/NOAA-EDAB/buoydata/actions/workflows/pkgdown.yml)
[![gitleaks](https://github.com/NOAA-EDAB/buoydata/actions/workflows/secretScan.yml/badge.svg)](https://github.com/NOAA-EDAB/buoydata/actions/workflows/secretScan.yml)
[![R-CMD-check](https://github.com/NOAA-EDAB/buoydata/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/NOAA-EDAB/buoydata/actions/workflows/R-CMD-check.yaml)
[![ERDDAP
pull](https://github.com/NOAA-EDAB/buoydata/actions/workflows/pull_erddap.yml/badge.svg)](https://github.com/NOAA-EDAB/buoydata/actions/workflows/pull_erddap.yml)
<!-- badges: end -->

The goal of `buoydata` is to easily download and process buoy data
hosted by [National Data Buoy Center](https://www.ndbc.noaa.gov/).

**Note: the [rnoaa](https://github.com/ropensci/rnoaa) package also has
functions to get buoy data. The difference is that (in
[rnoaa](https://github.com/ropensci/rnoaa)) only one years worth of data
can be downloaded at any time from a single buoy. As of 2023
[rnoaa](https://github.com/ropensci/rnoaa) is no longer officially
supported**

`buoydata` downloads all of the buoys data from ERDDAP ™. In addition
the lazily loaded station description data provided with the package
combines many more attributes (than
[rnoaa](https://github.com/ropensci/rnoaa)) by which to filter.

*Date of most recent data pull: 2025-12-03*

## Installation

``` r
pak::pak("NOAA-EDAB/buoydata")
```

## Data

All of the buoy data is pulled from the coastwatch [ERDDAP
™]('https://coastwatch.pfeg.noaa.gov/erddap/') server. The data set ID
is = `cwwcNDBCMet`. The metadata for this data set can be found at
<https://coastwatch.pfeg.noaa.gov/erddap/tabledap/cwwcNDBCMet.html>.

The ERDDAP ™ server retrieves and combines historic data and real-time
data from the [NDBC](https://www.ndbc.noaa.gov/) site. The data you
retrieve using this package will be ALL data from a particular buoy up
to the most recent measurement available.

To view the available data (by year) for all station visually (on an
interactive world map) see the `vignette("buoymap")`

If you observe a discrepancy between the data on the NDBC website and
what is available in this package, first check to see if it is available
on [ERDDAP
™](https://coastwatch.pfeg.noaa.gov/erddap/tabledap/cwwcNDBCMet.html) or
use `get_buoy_data()` from this package. If it is not please contact
`erd.data at noaa.gov` otherwise create a [data
issue](https://github.com/NOAA-EDAB/buoydata/issues)

## Reference

[Documentation](https://www.ndbc.noaa.gov/faq/measdes.shtml) of the
meteorological data can be found on the National Data Buoy Center
website

## Contact

| [andybeet](https://github.com/andybeet)                                                                        |
|----------------------------------------------------------------------------------------------------------------|
| [![andybeet avatar](https://avatars1.githubusercontent.com/u/22455149?s=100&v=4)](https://github.com/andybeet) |

#### Legal disclaimer

*This repository is a scientific product and is not official
communication of the National Oceanic and Atmospheric Administration, or
the United States Department of Commerce. All NOAA GitHub project code
is provided on an ‘as is’ basis and the user assumes responsibility for
its use. Any claims against the Department of Commerce or Department of
Commerce bureaus stemming from the use of this GitHub project will be
governed by all applicable Federal law. Any reference to specific
commercial products, processes, or services by service mark, trademark,
manufacturer, or otherwise, does not constitute or imply their
endorsement, recommendation or favoring by the Department of Commerce.
The Department of Commerce seal and logo, or the seal and logo of a DOC
bureau, shall not be used in any manner to imply endorsement of any
commercial product or activity by DOC or the United States Government.*
