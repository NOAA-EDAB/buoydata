# buoydata 1.0.1

Data pull: November 21, 2025

### Stations added 

* 42031 - West End CP, AL: [30.09,-88.212]. 2025-2025 (1 yrs).
* 42357 - DISL Sofar Spotter: [30.092,-88.212]. 2025-2025 (1 yrs).
* 45221 - North Lake Champlain: [44.756,-73.355]. 2025-2025 (1 yrs).
* CXHN6 - Coxsackie, Hudson River (8518979): [42.353,-73.795]. 2025-2025 (1 yrs).
* DCXA2 - Devils Cove: [58.351,-154.127]. 2025-2025 (1 yrs).
* ELXA2 - Cape St. Elias: [59.798,-144.6]. 2025-2025 (1 yrs).
* PAUA2 - ST PAUL MXAK, AK: [57.124,-170.271]. 2025-2025 (1 yrs).
* SKDA2 - Skagway Ore Dock: [59.449,-135.331]. 2025-2025 (1 yrs).
* WBXA2 - Womens Bay Cargo Pier: [57.729,-152.516]. 2025-2025 (1 yrs).
* WFXA2 - Womens Bay Fuel Pier: [57.726,-152.519]. 2025-2025 (1 yrs).

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


