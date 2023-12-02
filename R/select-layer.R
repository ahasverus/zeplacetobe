select_layer <- function(layer, point) {
  
  if (nrow(point) > 0) {
    
    city_osm <- strsplit(point$"name", ", ")[[1]][1]
    city_sf <- layer$"cities"[layer$"cities"$"nom" == city_osm, ]
    
    if (nrow(city_sf) == 0) {
      city_sf <- layer$"france"
    }
    
    if (nrow(city_sf) > 1) {
      point_sf <- sf::st_as_sf(point, coords = 1:2, crs = sf::st_crs(4326))
      inter <- sf::st_intersects(city_sf, point_sf)
      inter <- which(unlist(lapply(inter, function(x) length(x))) == 1)
      city_sf <- city_sf[inter, ]
    }
    
  } else {
    
    # point <- sf::st_coordinates(sf::st_centroid(layer$"france"))
    city_sf <- layer$"france"
  }
  
  city_sf
}
