leaflet_map <- function(layer) {
  
  
  ## Zoom level ----
  
  leaflet_view <- sf::st_bbox(layer)
  names(leaflet_view) <- NULL
  
  
  ## Map ----
  
  leaflet(layer) %>% 
    
    addTiles(group = "Plan") %>% 
    addProviderTiles(providers$Esri.WorldImagery, group = "Satellite") %>%
    
    fitBounds(leaflet_view[1], leaflet_view[2], 
              leaflet_view[3], leaflet_view[4]) %>% 
    
    addPolygons(weight = 1.75, color = "red", fillOpacity = 0) %>%
    
    addLayersControl(
      baseGroups = c("Plan", "Satellite"),
      options    = layersControlOptions(collapsed = FALSE))
}
