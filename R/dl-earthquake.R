dl_earthquake <- function(path) {
  
  
  dir.create(path         = file.path(path, "earth-quake"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  baseurl  <- paste0("https://www.data.gouv.fr/fr/datasets/r/4f6bc1ec-5e29-", 
                     "404e-8214-bef23088eaf6")
  
  filename <- "France_zonage_sismique.rds"
  zipname  <- "France_zonage_sismique.zip"
  
  
  if (!file.exists(file.path(path, "earth-quake", filename))) {
    
    utils::download.file(url      = paste0(baseurl),
                         destfile = file.path(path, "earth-quake", zipname),
                         mode     = "wb")
    
    unzip(zipfile = file.path(path, "earth-quake", zipname), 
          exdir   = file.path(path, "earth-quake", "tmp"))
    
    earth_quake <- sf::st_read(file.path(path, "earth-quake", "tmp",
                                    "France_zonage_sismique.shp"),
                               options = "ENCODING=WINDOWS-1252")

    
    earth_quake$"Sismicite" <- substr(earth_quake$"Sismicite", 5, 
                                      nchar(earth_quake$"Sismicite"))
    
    earth_quake <- earth_quake[substr(earth_quake$"insee", 1, 2) != 96, ]
    earth_quake <- earth_quake[substr(earth_quake$"insee", 1, 2) != 97, ]

    earth_quake <- sf::st_drop_geometry(earth_quake[ , -c(2:3)])
    colnames(earth_quake)[1:2] <- c("insee", "sismicite")
    
    earth_quake$"sismicite" <- gsub("Moyenne", "Moyen", earth_quake$"sismicite")
    earth_quake$"sismicite" <- gsub("Modérée", "Modéré", earth_quake$"sismicite")
    
    saveRDS(earth_quake, file.path(path, "earth-quake", filename))
    
    invisible(file.remove(file.path(path, "earth-quake", zipname)))
    
    files_to_dl <- list.files(file.path(path, "earth-quake", "tmp"), 
                              full.names = TRUE)
    invisible(lapply(files_to_dl, function(x) invisible(file.remove(x))))
    invisible(unlink(file.path(path, "earth-quake", "tmp"), force = TRUE, 
                     recursive = TRUE))
  }
  
  invisible(NULL)
}
