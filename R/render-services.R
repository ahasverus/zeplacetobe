render_services <- function(layers, layer) {
  
  dist_to_hospital <- "___"
  
  if ("insee" %in% colnames(layer)) {
    
    dist_to_hospital <- sf::st_distance(layers$"hospitals", layer)
    
    city <- layers$"hospitals"[which(dist_to_hospital == min(dist_to_hospital)), ]
    city <- as.character(sf::st_drop_geometry(city[1, "osm_name"]))
    
    dist_to_hospital <- round(as.numeric(min(dist_to_hospital)) / 1000)
    
    if (dist_to_hospital == 0) {
      
      dist_to_hospital <- "Oui"
      
    } else {
      
      dist_to_hospital <- paste0("à ", dist_to_hospital, " km (", city, ")") 
    }
  }
  
  html <- NULL
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Services</p>"))
  
  html <- c(html, paste0("<p class='wiki-label'>Hôpital public : ", 
                         dist_to_hospital, "</p>"))
    
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<span class='source'>Source : <a href='", 
                         "https://www.data.gouv.fr/fr/datasets/localisation-des-hopitaux-dans-openstreetmap/", 
                         "'>OpenStreetMap</a></span>"))
  
  HTML(paste0(html, collapse = ""))  
}
