# Find the best place to live in France

<!-- badges: start -->
[![License: GPL (\>=
2)](https://img.shields.io/badge/License-GPL%20%28%3E%3D%202%29-blue.svg)](https://choosealicense.com/licenses/gpl-2.0/)
<!-- badges: end -->



## Table of contents

<p align="left">
• <a href="#overview">Overview</a><br>
• <a href="#system-requirements">System requirements</a><br>
• <a href="#installation">Installation</a><br>
• <a href="#usage">Usage</a><br>
• <a href="#data-description">Data description</a><br>
• <a href="#citation">Citation</a><br>
• <a href="#contributing">Contributing</a>
</p>


## Overview

This repository contains the code to build and run the Shiny App **Find the best place to live in France** available at <https://ahasverus.shinyapps.io/zeplacetobe>. For a given French city, user can get information on administration, demography, geography, land cover, climate change, etc. A [Leaflet](https://rstudio.github.io/leaflet/) map allows user to access satellite images of the city.

Currently, this app is only available for Mainland France.

The next three sections explain how to run the Shiny app locally.


## System requirements

This project requires the software [R](https://cran.r-project.org/). Windows users need to install the additional software [RTools](https://cran.r-project.org/bin/windows/Rtools/).
This project handles spatial objects and requires some system dependencies (GDAL, PROJ and GEOS). Please visit [this page](https://github.com/r-spatial/sf/#installing) to correctly install these tools.


## Installation

- [Fork](https://docs.github.com/en/get-started/quickstart/contributing-to-projects) this repository using the GitHub interface.
- [Clone](https://docs.github.com/en/repositories/creating-and-managing-repositories/cloning-a-repository) 
your fork using `git clone fork-url` (replace `fork-url` by the URL of your fork). 
Alternatively, open RStudio IDE and create a New Project from Version Control.
- Install required packages by running:


```r
# Install the `remotes` package
install.packages("remotes")

# Install required packages
remotes::install_deps()
```



## Usage

To start and use the Shiny app, run the following command:

```r
# Run the Shiny app
shiny::runApp()
```

On a web browser, go to the URL `http://127.0.0.1:XXX`, where `XXX` is the port listening the Shiny server.

**Note:** running the app for the first time can take several minutes as all required datasets will be downloaded.



## Data description

#### Administrative borders

- Borders of Mainland France come from the [GADM](https://gadm.org) database.
- Borders of French municipalities come from [OpenStreetMap](https://www.data.gouv.fr/fr/datasets/decoupage-administratif-communal-francais-issu-d-openstreetmap/) database.


#### Base maps

- [OpenStreetMap](https://www.openstreetmap.org/copyright/) layer, released under the [ODbl](https://opendatacommons.org/licenses/odbl/) license.
- [Esri WorldImagery](https://www.arcgis.com/home/item.html?id=10df2279f9684e4a9f6a7f08febac2a9) layer.


#### Administration, demography and geography

- Data come from [Wikipedia](https://wikipedia.org/).


#### Elevation

- Data come from [SRTM 90m](https://csidotinfo.wordpress.com/data/srtm-90m-digital-elevation-database-v4-1/) Digital Elevation Model and have been downloaded with the R package [`geodata`](https://cran.r-project.org/package=geodata).


#### Sunshine duration

- Data come from [Data Gouv France](https://www.data.gouv.fr/fr/datasets/donnees-du-temps-densoleillement-par-departements-en-france/).


#### Services

- Data for hospitals come from the [Fédération Hospitalière de France](https://etablissements.fhf.fr/). Only the CHR (Centres Hospitaliers Régionaux), CH (Centres hospitaliers), and HL (Hôpitaux locaux) are used in the app.


#### Land cover

- Data come from the [Corine Land cover](https://www.statistiques.developpement-durable.gouv.fr/corine-land-cover-0?rubrique=348&dossier=1759) database.


#### Climate data

- Climate layers for the period 1981-2010 come from the [Chelsa](https://chelsa-climate.org/) database.
- Climate layers for the period 2041-2070 come from the [Chelsa](https://chelsa-climate.org/) database and the Global Climate Model [GFDL-ESM4](https://www.gfdl.noaa.gov/earth-system-esm4/) run under the SSP scenario [SSP585](https://view.es-doc.org/?renderMethod=name&project=cmip6&type=cim.2.designing.NumericalExperiment&client=esdoc-url-rewrite&name=ssp585).


## Citation

> Casajus N (2023) A Shiny app to find the best place to live in France. URL: <https://ahasverus.shinyapps.io/zeplacetobe/>.


## Contributing

All types of contributions are encouraged and valued. For more
information, check out our [Contributor
Guidelines](https://github.com/ahasverus/zeplacetobe/blob/main/CONTRIBUTING.md).

Please note that the `zeplacetobe` project is released with a
[Contributor Code of
Conduct](https://contributor-covenant.org/version/2/1/CODE_OF_CONDUCT.html).
By contributing to this project, you agree to abide by its terms.
