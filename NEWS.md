# buoydata 1.0.0

NDBC data is pulled via a cron job and hosted on ERDDAP. The package now pulls from ERDDAP rather than scraping the NDBC site

## Major changes

* Renamed bundled data set to `buoy_data`
* Pull from ERDDAP rather than scraping NDBC site
* `get_variables()` function. Displays list of buoy variables
* `get_buoy_data()` now pulls data into session. No longer exports/downloads to files
* `combine_buoy_data()` removed - no longer needed since files are not downloaded

## Minor

* Additional documentation
* Contributor guidelines and code of conduct


# buoydata 0.2

Data pull: June 6, 2024

* Additional buoys included
* Existing buoys have additional data

# buoydata 0.1

* Initial submission.


