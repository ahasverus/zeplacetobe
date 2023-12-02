scrap_wikipedia <- function(layer) {
  
  labels <- c("Région", "Département", "Code postal", 
              "Populationmunicipale", "Densité", "Superficie")
  
  infos <- data.frame(label = labels, value = "___")
  
  url <- paste0("https://fr.wikipedia.org/")
  
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
  
  html <- NULL
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Administration</p>"))
  html <- c(html, paste0("<p class='wiki-label'>", infos[1, 1], " : ", 
                         infos[1, 2], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>", infos[2, 1], " : ", 
                         infos[2, 2], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>", "Commune", " : ",
                         infos[3, 2], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Démographie</p>"))
  html <- c(html, paste0("<p class='wiki-label'>", infos[4, 1], " : ", 
                         infos[4, 2], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>", infos[5, 1], " : ", 
                         infos[5, 2], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Géographie</p>"))
  html <- c(html, paste0("<p class='wiki-label'>", infos[6, 1], " : ", 
                         infos[6, 2], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<span class='source'>Source : <a href='", url, 
                         "'>Wikipedia</a></span>"))
  
  HTML(paste0(html, collapse = ""))
}
