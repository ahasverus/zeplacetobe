render_curclimatebox <- function(data) {
  
  html <- NULL
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Températures actuelles</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Annuelle", " : ",
                   data$"current"["bio01"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Mois le plus froid", " : ",
                   data$"current"["bio06"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Mois le plus chaud", " : ",
                   data$"current"["bio05"], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Précipitations actuelles</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Annuelle", " : ",
                   data$"current"["bio12"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Mois le plus sec", " : ",
                   data$"current"["bio14"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Mois le plus humide", " : ",
                   data$"current"["bio13"], "</p>"))
  
  HTML(paste0(html, collapse = ""))
}
