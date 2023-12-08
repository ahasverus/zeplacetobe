render_futclimatebox <- function(data) {
  
  html <- NULL
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Températures 2050</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Annuelle", " : ",
                   data$"future"["bio01"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Mois le plus froid", " : ",
                   data$"future"["bio06"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Mois le plus chaud", " : ",
                   data$"future"["bio05"], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Précipitations 2050</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Annuelle", " : ",
                   data$"future"["bio12"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Mois le plus sec", " : ",
                   data$"future"["bio14"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Mois le plus humide", " : ",
                   data$"future"["bio13"], "</p>"))
  
  HTML(paste0(html, collapse = ""))
}
