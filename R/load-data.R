load_data <- function(path = here::here("data")) {
  
  data_list <- list()
  
  data_list$"france" <- sf::st_read(dsn   = file.path(path, "administrative", 
                                                      "gadm41_FRA.gpkg"), 
                                    layer = "ADM_ADM_0")
  
  data_list$"cities" <- sf::st_read(dsn   = file.path(path, "administrative", 
                                                      "communes-20220101.gpkg"))
  
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
  
  data_list
}
