render_current_climate <- function(data) {
  
  if (length(data) == 0) {
    data <- rep("___", 9)
  } else {
    data[1:3] <- paste0(data[1:3], " m")
    data[c(4, 8:9)] <- paste0(data[c(4, 8:9)], "&deg;C")
    data[5:7] <- paste0(data[5:7], " mm")
  }
  
  html <- NULL
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Températures moyennes (1981-2010)</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Annuelle : ", 
                         data[4], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Mois le plus froid : ", 
                         data[9], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Mois le plus chaud : ", 
                         data[8], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Précipitations totales (1981-2010)</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Annuelle : ", 
                         data[5], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Mois le plus sec : ", 
                         data[7], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Mois le plus humide : ", 
                         data[6], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<span class='source'>Source : <a href='", 
                         "https://chelsa-climate.org/", 
                         "'>Chelsa Database</a></span>"))
  
  HTML(paste0(html, collapse = ""))
}
