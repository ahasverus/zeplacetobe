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
  
  dl_administrative_layers(path_data)
  
  
  ## Download Corine Land Cover ----
  
  dl_landcover(path_data)
  
  
  ## Download Hospital locations ----
  
  dl_hospitals(path_data)
  
  
  ## Download Earth quake risk ----
  
  dl_earthquake(path_data)
  
  
  ## Download Sunshine duration ----
  
  dl_sunshine(path_data)
  
  
  ## Download current climate layers ----
  
  dl_elevation_layer(path_data)
  
  
  ## Download current climate layers ----
  
  dl_current_climate_layers(path_data)
  
  
  ## Download future climate layers ----
  
  dl_future_climate_layers(path_data)
}
