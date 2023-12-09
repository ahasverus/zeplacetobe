select_layer <- function(layer, point) {
  
  if (nrow(point) > 0) {
    
    city_osm <- strsplit(point$"name", ", ")[[1]][1]
    pos <- which(layer$"cities"$"nom" == city_osm)
    
    if (length(pos) == 0) {
      city_sf <- layer$"france"
    }
    
    if (length(pos) == 1) {
      city_sf <- readRDS(file.path("data", "administrative", 
                                   paste0("commune-", 
                                          layer$"cities"[pos, "insee"],
                                          ".rds")))
    }
    
    if (length(pos) > 1) {
      
      city_sf <- data.frame()
      for (i in pos) {
        city_sf <- rbind(city_sf,
                         readRDS(file.path("data", "administrative", 
                                           paste0("commune-", 
                                           layer$"cities"[i, "insee"],
                                           ".rds"))))
      }
      
      point_sf <- sf::st_as_sf(point, coords = 1:2, crs = sf::st_crs(4326))
      inter <- sf::st_intersects(city_sf, point_sf)
      inter <- which(unlist(lapply(inter, function(x) length(x))) == 1)
      city_sf <- city_sf[inter, ]
      
      if (nrow(city_sf) == 0) {
        city_sf <- layer$"france"
      }
    }
    
  } else {
    
    city_sf <- layer$"france"
  }
  
  city_sf
}
