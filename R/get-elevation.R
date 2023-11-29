get_elevation_layer <- function(path) {
  
  dir.create(path         = file.path(path, "elevation"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  filename <- "FRA_elv_msk"
  
  if (!file.exists(file.path(path, "elevation", filename))) {
    
    invisible(
      geodata::elevation_30s(country = "FRA", 
                             path    = file.path(path, "elevation"), 
                             mask    = TRUE))
  }
  
  invisible(NULL)
}
