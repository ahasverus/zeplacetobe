render_future_climate <- function(data) {
  
  if (length(data) == 0) {
    
    data <- rep("___", 15)
    
  } else {
    
    deltas <- c(data[10] - data[4],
                data[11] - data[5],
                data[12] - data[6],
                data[13] - data[7],
                data[14] - data[8],
                data[15] - data[9])
    
    data[1:3] <- paste0(data[1:3], " m")
    data[c(4, 8:9, 10, 14:15)] <- paste0(data[c(4, 8:9, 10, 14:15)], "&deg;C")
    data[c(5:7, 11:13)] <- paste0(data[c(5:7, 11:13)], " mm")
    
    data[10] <- paste0(data[10], " <i>(", 
                       ifelse(deltas[1] < 0, 
                              gsub("-", "-", deltas[1]), 
                              paste0("+", deltas[1])), 
                       "&deg;C)</i>")
    data[11] <- paste0(data[11], " <i>(", 
                       ifelse(deltas[2] < 0, 
                              gsub("-", "-", deltas[2]), 
                              paste0("+", deltas[2])), 
                       " mm)</i>")
    data[12] <- paste0(data[12], " <i>(", 
                       ifelse(deltas[3] < 0, 
                              gsub("-", "-", deltas[3]), 
                              paste0("+", deltas[3])), 
                       " mm)</i>")
    data[13] <- paste0(data[13], " <i>(", 
                       ifelse(deltas[4] < 0, 
                              gsub("-", "-", deltas[4]), 
                              paste0("+", deltas[4])), 
                       " mm)</i>")
    data[14] <- paste0(data[14], " <i>(", 
                       ifelse(deltas[5] < 0, 
                              gsub("-", "-", deltas[5]), 
                              paste0("+", deltas[5])), 
                       "&deg;C)</i>")
    data[15] <- paste0(data[15], " <i>(", 
                       ifelse(deltas[6] < 0, 
                              gsub("-", "-", deltas[6]), 
                              paste0("+", deltas[6])), 
                       "&deg;C)</i>")
  }
  
  html <- NULL
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Températures moyennes (2041-2070)</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Annuelle : ", 
                         data[10], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Mois le plus froid : ", 
                         data[15], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Mois le plus chaud : ", 
                         data[14], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Précipitations totales (2041-2070)</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Annuelle : ", 
                         data[11], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Mois le plus sec : ", 
                         data[13], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Mois le plus humide : ", 
                         data[12], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<span class='source'>Source : <a href='", 
                         "https://chelsa-climate.org/", 
                         "'>GFDL-ESM4 SSP585</a></span>"))
  
  HTML(paste0(html, collapse = ""))
}
