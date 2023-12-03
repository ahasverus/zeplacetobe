render_elevation <- function(data) {
  
  if (length(data) == 0) {
    data <- rep("___", 3)
  } else {
    data <- paste0(data, " m")
  }

  html <- NULL
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Altitudes</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Moyenne : ", 
                         data[1], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Maximum : ", 
                         data[2], "</p>"))
  html <- c(html, paste0("<p class='wiki-label'>Minimum : ", 
                         data[3], "</p>"))
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<span class='source'>Source : <a href='", 
                         "https://csidotinfo.wordpress.com/data/srtm-90m-digital-elevation-database-v4-1/", 
                         "'>SRTM 90m DEM</a></span>"))
  
  HTML(paste0(html, collapse = ""))
}
