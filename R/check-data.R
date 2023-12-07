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
  
  
  ## Download Corine Land Cover ----
  
  get_landcover(path_data)
  
  
  ## Download Hospital locations ----
  
  get_hospitals(path_data)
  
  
  ## Download Earth quake risk ----
  
  get_earthquake(path_data)
  
  
  ## Download current climate layers ----
  
  get_elevation_layer(path_data)
  
  
  ## Download current climate layers ----
  
  get_current_climate_layers(path_data)
  
  
  ## Download future climate layers ----
  
  get_future_climate_layers(path_data)
}
