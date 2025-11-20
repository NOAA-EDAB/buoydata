# buoy_data: NDBC Standard Meteorological Buoy Data, 1970-present

A complete list of buoys listed on ERDDAP along with buoy specific
features such as location and data range.

## Usage

``` r
buoy_data
```

## Format

A data frame

- ID:

  Buoy ID name

- Y1:

  First year of data

- YN:

  Last year of data

- nYEARS:

  Number of years of data

- lastMeasurement:

  Date/Time of the last recorded measurement

- LAT:

  Latitude

- LON:

  Longitude

- STATION_LOC:

  Description of station location

- TTYPE:

  Number of years of data

- TIMEZONE:

  Time Zone

- OWNER:

  Code assigned to OWNERNAME

- OWNERNAME:

  Owner organization of data

- COUNTRY:

  Country code associated with OWNERNAME

- HULL:

- PAYLOAD:

- FORECAST:

- NOTE:

  NDBC notes regarding buoy

## Source

ERDDAP:
<https://coastwatch.pfeg.noaa.gov/erddap/tabledap/cwwcNDBCMet.html>.
This data is pulled from National Data Buoy Center:
[ndbc.noaa.gov](https://noaa-edab.github.io/buoydata/reference/ndbc.noaa.gov)
on a cron job
