render_sunshine <- function(layers, layer) {
  
  sunshine <- "___"
  
  if ("insee" %in% colnames(layer)) {
    
    code_insee <- as.character(sf::st_drop_geometry(layer[1, "insee"]))
    code_insee <- substr(code_insee, 1, 2)
    
    sunshine <- layers$"sunshine"[layers$"sunshine"$"code" == code_insee, 
                                  "ensoleillement"]
    
    if (length(sunshine) == 0) {
      
      sunshine <- "___"
      
    } else {
      
      sunshine <- paste0(sunshine, " jours/an")
    }
  }
  
  html <- NULL
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Ensoleillement</p>"))
  
  html <- c(html, paste0("<p class='wiki-label'>Ensoleillement : ", 
                         sunshine, "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<span class='source'>Source : <a href='", 
                         "https://www.data.gouv.fr/fr/datasets/donnees-du-temps-densoleillement-par-departements-en-france/", 
                         "'>Data Gouv France</a></span>"))
  
  HTML(paste0(html, collapse = ""))  
}
