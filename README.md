
<!-- README.md is generated from README.Rmd. Please edit that file -->

# medrxivr <img src="man/figures/hex-medrxivr.png" align="right" width="20%" height="20%" />

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![rOpenSci
Badge](https://badges.ropensci.org/380_status.svg)](https://github.com/ropensci/software-review/issues/380)
<br> [![R build
status](https://github.com/mcguinlu/medrxivr/workflows/R-CMD-check/badge.svg)](https://github.com/mcguinlu/medrxivr/actions)
[![Travis build
status](https://travis-ci.com/mcguinlu/medrxivr.svg?branch=master)](https://travis-ci.com/mcguinlu/medrxivr)
[![AppVeyor build
status](https://ci.appveyor.com/api/projects/status/github/mcguinlu/medrxivr?branch=master&svg=true)](https://ci.appveyor.com/project/mcguinlu/medrxivr)
[![Codecov test
coverage](https://codecov.io/gh/mcguinlu/medrxivr/branch/master/graph/badge.svg)](https://codecov.io/gh/mcguinlu/medrxivr?branch=master)
<!-- badges: end -->

[medRxiv](https://www.medrxiv.org/) is a free online repository for
complete but unpublished manuscripts (preprints) in the medical,
clinical, and related health sciences. The `medrxivr` package provides
programmatic access to metadata (title, authors, date, etc.) on the
preprints contained in the repository via the [medRxiv
API](https://api.biorxiv.org/) or a maintained static snapshot (see
[Data sources](#data-sources).) `medrxivr` also provides functions to
search medRxiv records using regular expressions and Boolean logic, in
addition to helper functions to export your search results to a .BIB
file for easy import to a reference manager and to download the
full-text PDFs of relevant preprints.

**Note:** `medrxivr` is now available as a web-app, which lets you build
complex searches via a user-friendly interface, explore the results and
export them for screening. In an effort to improve reproducibility, it
also creates the code needed to run the search straight from R. The app
is available [here.](https://mcguinlu.shinyapps.io/medrxivr/)

## Installation

You can install the development version of this package using:

``` r
devtools::install_github("mcguinlu/medrxivr")
library(medrxivr)
```

## Usage

### Data sources

`medrixvr` provides two ways to access medRxiv data:

  - `mx_api_content()` creates a local copy of all data available from
    the medRxiv API at the time the function is run.

  - `mx_snapshot()` provides access to a static snapshot of the
    database. The snapshot is created each morning at 6am using
    `mx_api_content()` and is stored as CSV file in the [medrxivr-data
    repository](https://github.com/mcguinlu/medrxivr-data). This method
    does not rely on the API (which can become unavailable during peak
    usage times) and is usually faster (as it reads data from a CSV
    rather than having to re-extract it from the API). Discrepancies
    between the most recent static snapshot and the live database can be
    assessed using `mx_crosscheck()`.

The relationship between the two methods is summarised in the figure
below:

<img src="vignettes/data_sources.png" width="500px" height="400px" />

## Perform a simple search

### Using data from the API

``` r

# Get a copy of the database from the live API
medrxiv_data <- mx_api_content()

# Perform a simple search
results <- mx_search(data = medrxiv_data,
                     query ="dementia")
```

### Using the daily snapshot

``` r

# Get a copy of the database from the daily snapshot
medrxiv_data <- mx_snapshot()

# Perform a simple search
results <- mx_search(data = medrxiv_data,
                     query ="dementia")
```

## Further functionality

### Export records identified by your search to a .BIB file

`medrxivr` provides a helper function to export your search results to a
.BIB file so that they can be easily imported into a reference manager
(e.g. Zotero, Mendeley)

``` r

mx_export(data = results,
          file = "mx_search_results.bib")
```

### Download PDFs for records returned by your search

Pass the results of your search above to the `mx_download()` function to
download a copy of the PDF for each record.

``` r

mx_download(results,        # Object returned by mx_search(), above
            "pdf/",         # Directory to save PDFs to 
            create = TRUE)  # Create the directory if it doesn't exist
```

## Detailed guidance

Detailed guidance, including advice on how to design complex search
strategies, is available on the [`medrxivr`
website.](https://mcguinlu.github.io/medrxivr/)

## Linked repositories

See here for the [code used to take the daily
snapshot](https://github.com/mcguinlu/medrxivr-data) and [the code that
powers the `medrxivr` web
app](https://github.com/mcguinlu/medrxivr-app).

## Code of conduct

Please note that the `medrxivr` project is released with a [Contributor
Code of Conduct](CODE_OF_CONDUCT.md). By contributing to this project,
you agree to abide by its terms.

## Disclaimer

This package and the data it accesses/returns are provided “as is”, with
no guarantee of accuracy. Please be sure to check the accuracy of the
data yourself (and do let me know if you find an issue so I can fix it
for everyone\!)
