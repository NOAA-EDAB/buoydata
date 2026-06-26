# Changelog

## buoydata 1.0.6

Data pull: June 23, 2026

#### Stations added

- 44074 - Great Bay Buoy: \[43.07,-70.86\]. 2026-2026 (1 yrs).
- 45217 - Wisconsin Point: \[46.706,-91.985\]. 2026-2026 (1 yrs).
- 45220 - Dunkirk Buoy: \[42.561,-79.432\]. 2026-2026 (1 yrs).
- TRTP1 - TREC Tower: \[42.11,-80.154\]. 2026-2026 (1 yrs).

#### Stations removed

- 44021 - Buoy D - New Meadows River: \[43.782,-69.888\]. 2006-2013 (5
  yrs).
- 44024 - Buoy N01 - Northeast Channel: \[42.312,-65.927\]. 2004-2021
  (14 yrs).
- 44031 - Buoy C0201 - Casco Bay: \[43.57,-70.06\]. 2004-2008 (5 yrs).
- 44035 - Buoy J0201 - Cobscook Bay: \[44.89,-67.02\]. 2004-2008 (5
  yrs).
- 44037 - Buoy M01 - Jordan Basin: \[43.484,-67.883\]. 2004-2024 (19
  yrs).
- 44038 - Buoy L0102 - Scotian Shelf: \[43.633,-66.55\]. 2004-2008 (5
  yrs).
- GKYF1 - Garden Key, FL: \[24.627,-82.872\]. 2019-2024 (6 yrs).

## buoydata 1.0.5

Data pull: May 19, 2026

#### Stations added

- BCTP1 - Beach 2 Tower: \[42.153,-80.131\]. 2026-2026 (1 yrs).
- GRCM4 - GLRC Observatory: \[47.121,-88.545\]. 2026-2026 (1 yrs).

## buoydata 1.0.4

Data pull: April 21, 2026

#### Stations added

- 46453 - Backyard Buoys - Quinault North: \[47.45,-124.43\]. 2026-2026
  (1 yrs).
- CSIM3 - Castle Island (NOS) 8444069: \[42.341,-71.012\]. 2026-2026 (1
  yrs).

## buoydata 1.0.3

Data pull: March 18, 2026

#### Stations added

- 42358 - FGBNMS Sofar Spotter: \[27.874,-93.815\]. 2026-2026 (1 yrs).

## buoydata 1.0.2

Data pull: January 22, 2026

#### Stations added

- 42027 - C23 - FLRACEP nWFS Buoy, 45m isobath: \[29.045,-85.305\].
  2025-2026 (2 yrs).
- 42028 - C24 - FLRACEP nWFS Buoy, 58m isobath: \[29.745,-86.227\].
  2025-2026 (2 yrs).
- BCFM2 - Brewerton Channel Range Front Light (8574831):
  \[39.205,-76.524\]. 2025-2026 (2 yrs).

## buoydata 1.0.1

Data pull: November 21, 2025

#### Stations added

- 42031 - West End CP, AL: \[30.09,-88.212\]. 2025-2025 (1 yrs).
- 42357 - DISL Sofar Spotter: \[30.092,-88.212\]. 2025-2025 (1 yrs).
- 45221 - North Lake Champlain: \[44.756,-73.355\]. 2025-2025 (1 yrs).
- CXHN6 - Coxsackie, Hudson River (8518979): \[42.353,-73.795\].
  2025-2025 (1 yrs).
- DCXA2 - Devils Cove: \[58.351,-154.127\]. 2025-2025 (1 yrs).
- ELXA2 - Cape St. Elias: \[59.798,-144.6\]. 2025-2025 (1 yrs).
- PAUA2 - ST PAUL MXAK, AK: \[57.124,-170.271\]. 2025-2025 (1 yrs).
- SKDA2 - Skagway Ore Dock: \[59.449,-135.331\]. 2025-2025 (1 yrs).
- WBXA2 - Womens Bay Cargo Pier: \[57.729,-152.516\]. 2025-2025 (1 yrs).
- WFXA2 - Womens Bay Fuel Pier: \[57.726,-152.519\]. 2025-2025 (1 yrs).

## buoydata 1.0.0

NDBC data is pulled via a cron job and hosted on ERDDAP. The package now
pulls from ERDDAP rather than scraping the NDBC site

### Major changes

- Renamed bundled data set to `buoy_data`
- Pull from ERDDAP rather than scraping NDBC site
- [`get_variables()`](https://noaa-edab.github.io/buoydata/reference/get_variables.md)
  function. Displays list of buoy variables
- [`get_buoy_data()`](https://noaa-edab.github.io/buoydata/reference/get_buoy_data.md)
  now pulls data into session. No longer exports/downloads to files
- `combine_buoy_data()` removed - no longer needed since files are not
  downloaded

### Minor

- Additional documentation
- Contributor guidelines and code of conduct

## buoydata 0.2

Data pull: June 6, 2024

- Additional buoys included
- Existing buoys have additional data

## buoydata 0.1

- Initial submission.
