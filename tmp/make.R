#' To run the ShinyApp locally
#' 
#' @author Nicolas Casajus \email{nicolas.casajus@gmail.com}
#' 
#' @date 2023/11/02



## Install Dependencies (listed in DESCRIPTION) ----

remotes::install_deps(upgrade = "never")


## Load Project Addins (R Functions and Packages) ----

pkgload::load_all(here::here())


## Start the App ----

shiny::runApp()
