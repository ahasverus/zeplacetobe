leaflet_map <- function(layer) {
  
  
  ## Zoom level ----
  
  leaflet_view <- sf::st_bbox(layer)
  names(leaflet_view) <- NULL
  
  
  ## Map ----
  
  leaflet(layer) %>% 
    
    addTiles() %>% 
    
    fitBounds(leaflet_view[1], leaflet_view[2], 
              leaflet_view[3], leaflet_view[4]) %>% 
    
    addPolygons(weight = 1.75, color = "black", fillOpacity = 0.15, fillColor = "black")
}
