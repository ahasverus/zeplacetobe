render_landbox <- function(data) {
  
  html <- NULL
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Services</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Hôpital public", " : ",
                   data$"hospital", "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Ecole maternelle", " : ",
                   data$"maternelle", "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Ecole élémentaire", " : ",
                   data$"elementaire", "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Collège", " : ",
                   data$"college", "</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Lycée", " : ",
                   data$"lycee", "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Occupation des sols</p>"))
  
  for (i in 1:length(data$"clc")) {

    nom <- gsub("_", " ", names(data$"clc")[i])
    nom <- paste0(toupper(substr(nom, 1, 1)), substr(nom, 2, nchar(nom)))

    html <- c(html, 
              paste0("<p class='wiki-label'>", 
                     nom, " : ",
                     data$"clc"[i], "</p>"))

  }
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, 
            paste0("<p class='wiki-section'>&#10148; Risques</p>"))
  
  html <- c(html, 
            paste0("<p class='wiki-label'>", 
                   "Risque sismique", " : ",
                   data$"risk", "</p>"))
  
  HTML(paste0(html, collapse = ""))
}
