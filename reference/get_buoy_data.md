# Gets buoy data from ERDDAP

Pulls data from ERDDAP. All buoys will have the same format. However
there will be cases where some variables will have NAs for the entire
variable.

## Usage

``` r
get_buoy_data(buoyid, vars = NULL)
```

## Arguments

- buoyid:

  Character. Name of buoys id. See
  [`buoy_data`](https://noaa-edab.github.io/buoydata/reference/buoy_data.md)
  for list of buoys available

- vars:

  Character vector. Vector of variables to pull. Default = NULL, pull
  all available variables. If you select spcific variables the resulting
  data frame will be considerably smaller

## Value

A data frame

## Examples

``` r
if (FALSE) { # \dontrun{
get_buoy_data(buoyid="42066", vars = NULL)

} # }
```
