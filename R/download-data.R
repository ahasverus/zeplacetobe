get_administrative_layers <- function(path) {
  
  
  dir.create(path         = file.path(path, "administrative"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  
  ## France contour -----
  
  gadm_url <- "https://geodata.ucdavis.edu/gadm/gadm4.1/gpkg/"
  filename <- "gadm41_FRA.gpkg"
  
  if (!file.exists(file.path(path, "administrative", filename))) {
    
    utils::download.file(url      = paste0(gadm_url, filename),
                         destfile = file.path(path, "administrative", filename),
                         mode     = "wb")  
  }
  
  
  ## Municipality contours ----
  
  osm_url  <- "https://osm13.openstreetmap.fr/~cquest/openfla/export/"
  filename <- "communes-20220101.gpkg"
  zipname  <- "communes-20220101-shp.zip"
  
  if (!file.exists(file.path(path, "administrative", "list_of_cities.rds"))) {
    
    utils::download.file(url      = paste0(osm_url, zipname),
                         destfile = file.path(path, "administrative", zipname),
                         mode     = "wb")
    
    unzip(zipfile = file.path(path, "administrative", zipname), 
          exdir   = file.path(path, "administrative", "tmp"))
    
    cities <- sf::st_read(file.path(path, "administrative", "tmp", 
                                    "communes-20220101.shp"))
    sf::st_write(cities, file.path(path, "administrative", filename))
    
    invisible(file.remove(file.path(path, "administrative", zipname)))
    
    files_to_dl <- list.files(file.path(path, "administrative", "tmp"), 
                              full.names = TRUE)
    invisible(lapply(files_to_dl, function(x) invisible(file.remove(x))))
    invisible(unlink(file.path(path, "administrative", "tmp"), force = TRUE, 
                     recursive = TRUE))
    
    for (i in 1:nrow(cities)) {
      saveRDS(cities[i, ], 
              file = file.path(path, "administrative", 
                               paste0("commune-",
                                      as.character(sf::st_drop_geometry(
                                        cities[i, "insee"])), 
                                      ".rds")))
    }
    
    cities <- as.data.frame(sf::st_drop_geometry(cities))
    
    saveRDS(cities, file = file.path(path, "administrative", 
                                     "list_of_cities.rds"))
    
    invisible(file.remove(file.path(path, "administrative", filename)))
  }
  
  invisible(NULL)
}
