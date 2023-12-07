render_earth_quake <- function(layers, layer) {
  
  risk <- "___"
  
  if ("insee" %in% colnames(layer)) {
    
    code_insee <- as.character(sf::st_drop_geometry(layer[1, "insee"]))
    risk <- layers$earth_quake[layers$earth_quake$insee == code_insee, "sismicite"]
    
    if (length(risk) == 0) risk <- "___"
  }
  
  html <- NULL
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Risques</p>"))
  
  html <- c(html, paste0("<p class='wiki-label'>Risque sismique : ", 
                         risk, "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<span class='source'>Source : <a href='", 
                         "https://www.data.gouv.fr/fr/datasets/zonage-sismique-de-la-france-1/", 
                         "'>Data Gouv France</a></span>"))
  
  HTML(paste0(html, collapse = ""))  
}
