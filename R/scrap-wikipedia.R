scrap_wikipedia <- function(layer) {
  
  labels <- c("Région", "Département", "Code postal", 
              "Populationmunicipale", "Densité", "Superficie")
  
  infos <- data.frame(label = labels, value = "___")
  
  if ("wikipedia" %in% colnames(layer)) {
    
    page <- sf::st_drop_geometry(layer[1, "wikipedia", drop = TRUE])
    page <- as.character(page)
    page <- gsub("fr:", "", page)
    
    url <- paste0("https://fr.wikipedia.org/wiki/", page)
    url <- gsub("\\s", "_", url)
    
    content <- rvest::session(url) %>%
      rvest::html_table() %>%
      .[[1]] %>%
      as.data.frame() %>%
      .[ , 1:2]
    
    
    for (i in 1:nrow(infos)) {
      
      c_o_l <- which(content[ , 1] == infos[i, "label"])
      
      if (length(c_o_l) == 1) {
      
        infos[i, "value"] <- content[c_o_l, 2]
      }
    }
    
    infos[3, 2] <- as.character(sf::st_drop_geometry(layer[1, "nom"]))
    
  }
  
  infos[4, 1] <- "Population"
  infos[ , 2] <- gsub("\\(sous-préfecture\\)", "", infos[ , 2])
  infos[ , 2] <- gsub("\\(préfecture\\)", "", infos[ , 2])
  infos[ , 2] <- gsub("\\(chef-lieu\\)", "", infos[ , 2])
  infos[ , 2] <- gsub("\\s+\\(.*", "", infos[ , 2])
  
  infos
}
