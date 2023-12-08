dl_elevation_layer <- function(path) {
  
  dir.create(path         = file.path(path, "elevation"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  zipname  <- "FRA_elv_msk.zip"
  filename <- "FRA_elv_msk.tif"
  
  if (!file.exists(file.path(path, "elevation", filename))) {
    
    invisible(
      geodata::elevation_30s(country = "FRA", 
                             path    = file.path(path, "elevation"), 
                             mask    = TRUE))
  }
  
  if (file.exists(file.path(path, "elevation", zipname))) {
    
    invisible(file.remove(file.path(path, "elevation", zipname)))
  }
  
  invisible(NULL)
}
