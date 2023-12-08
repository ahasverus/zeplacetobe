dl_current_climate_layers <- function(path) {
  
  
  dir.create(path         = file.path(path, "current-climate"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  
  url <- paste0("https://os.zhdk.cloud.switch.ch/envicloud/chelsa/chelsa_V2/", 
                "GLOBAL/climatologies/1981-2010/bio/")
  
  filenames <- paste0("CHELSA_", chelsa_layers(), "_1981-2010_V.2.1.tif")
  
  need_to_crop <- FALSE
  
  for (i in 1:length(filenames)) {
  
    if (!file.exists(file.path(path, "current-climate", filenames[i]))) {
      
      utils::download.file(url      = paste0(url, filenames[i]),
                           destfile = file.path(path, "current-climate", 
                                                filenames[i]),
                           mode     = "wb")
      
      need_to_crop <- TRUE
    }
  }
  
  if (need_to_crop) {
    
    fra <- sf::st_read(dsn   = file.path(path, "administrative", 
                                         "gadm41_FRA.gpkg"), 
                       layer = "ADM_ADM_0")
    
    raster_names <- list.files(file.path(path, "current-climate"), 
                               full.names = TRUE, pattern = "\\.tif$")
    layers <- terra::rast(raster_names)
    
    layers <- terra::crop(layers, fra)
    layers <- terra::mask(layers, fra)
    
    invisible(
      lapply(1:terra::nlyr(layers), function(i) {
        terra::writeRaster(x        = terra::subset(layers, i), 
                           filename = file.path(path, "current-climate", 
                                                paste0(names(layers)[i], 
                                                       ".tif")),
                           overwrite = TRUE)
      })
    )
  }
  
  invisible(NULL)
}
