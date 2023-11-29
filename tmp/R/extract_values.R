extract_values <- function(address) {
  
  xy <- address_to_coords(address)
  
  raster_names <- list.files(file.path("data", "derived-data"), full.names = TRUE,
                             pattern = "1981-2010.*gpkg$")
  
  varnames <- basename(raster_names)
  varnames <- strsplit(varnames, "_")
  varnames <- unlist(lapply(varnames, function(x) x[2]))
  
  layers <- terra::rast(raster_names)
  
  current_climate <- terra::extract(layers, xy)
  colnames(current_climate)[-1] <- varnames
  
  elevation <- terra::rast(file.path("data", "derived-data", "FRA_elv_msk.tif"))
  
  elevation <- terra::extract(elevation, xy)
  colnames(elevation)[-1] <- "elevation"
  
  data.frame(current_climate, "elevation" = elevation[ , -1])
}
