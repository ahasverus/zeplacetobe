render_adminbox <- function(data) {
  
  html <- NULL
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Administration</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   data$"wikipedia"[1, "label"], " : ",
                   data$"wikipedia"[1, "value"], "</p>"))
 
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   data$"wikipedia"[2, "label"], " : ",
                   data$"wikipedia"[2, "value"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Commune", " : ",
                   data$"wikipedia"[3, "value"], "</p>"))

  html <- c(html, paste0("<br />"))
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Démographie</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   data$"wikipedia"[4, "label"], " : ",
                   data$"wikipedia"[4, "value"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   data$"wikipedia"[5, "label"], " : ",
                   data$"wikipedia"[5, "value"], "</p>"))

  html <- c(html, paste0("<br />"))

  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Géographie</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   data$"wikipedia"[6, "label"], " : ",
                   data$"wikipedia"[6, "value"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Altitude", " : ",
                   data$"elevation"["mean"], "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Ensoleillement", " : ",
                   data$"sunshine", "</p>"))

  HTML(paste0(html, collapse = ""))
}
