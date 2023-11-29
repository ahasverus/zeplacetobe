check_data <- function() {
  
  ## Time used by wget ----
  
  o_timeout <- options()$"timeout"
  options(timeout = 300)
  on.exit(options(timeout = o_timeout))
  
  
  ## High level folders ----
  
  path_data <- here::here("data")
  
  dir.create(path         = file.path(path_data), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  
  ## Download administrative layers ----
  
  get_administrative_layers(path_data)
  
  
  ## Download current climate layers ----
  
  get_elevation_layer(path_data)
  
  
  ## Download current climate layers ----
  
  get_current_climate_layers(path_data)
}