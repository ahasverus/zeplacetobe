load_data <- function(path = here::here("data")) {
  
  data_list <- list()
  
  data_list$"france" <- sf::st_read(dsn   = file.path(path, "administrative", 
                                                      "gadm41_FRA.gpkg"), 
                                    layer = "ADM_ADM_0")
  
  data_list$"cities" <- readRDS(file.path(path, "administrative",
                                          "list_of_cities.rds"))
  
  data_list$"landcover" <- read.csv2(file.path(path, "land-cover",
                                               "clc_etat_com_n1.csv"))
  
  data_list$"hospitals" <- sf::st_read(dsn = file.path(path, "services", 
                                                       "france_hospitals.gpkg"))

  data_list$"earth_quake" <- readRDS(file.path(path, "earth-quake",
                                               "France_zonage_sismique.rds"))
  
  data_list$"elevation" <- terra::rast(file.path(path, "elevation", 
                                                 "FRA_elv_msk.tif"))
  
  current_climate <- list.files(file.path(path, "current-climate"), 
                                full.names = TRUE)
  
  current_climate_names <- basename(current_climate)
  current_climate_names <- strsplit(current_climate_names, "_")
  current_climate_names <- unlist(lapply(current_climate_names, 
                                         function(x) x[2]))
  
  data_list$"current_climate" <- terra::rast(current_climate)
  names(data_list$"current_climate") <- current_climate_names
  
  future_climate <- list.files(file.path(path, "future-climate"), 
                               full.names = TRUE)
  
  future_climate_names <- basename(future_climate)
  future_climate_names <- strsplit(future_climate_names, "_")
  future_climate_names <- unlist(lapply(future_climate_names, 
                                        function(x) x[2]))
  
  data_list$"future_climate" <- terra::rast(future_climate)
  names(data_list$"future_climate") <- future_climate_names
  
  data_list
}
