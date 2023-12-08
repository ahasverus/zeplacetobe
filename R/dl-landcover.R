dl_landcover <- function(path) {
  
  
  dir.create(path         = file.path(path, "land-cover"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  url <- paste0("https://www.statistiques.developpement-durable.gouv.fr/sites", 
                "/default/files/2019-07/")
  
  zipname  <- "clc_etat_com_n1.zip"
  filename <- "clc_etat_com_n1.csv"
  
  if (!file.exists(file.path(path, "land-cover", filename))) {
    
    utils::download.file(url      = paste0(url, zipname),
                         destfile = file.path(path, "land-cover", zipname),
                         mode     = "wb")
    
    unzip(zipfile = file.path(path, "land-cover", zipname), 
          exdir   = file.path(path, "land-cover"))
    
    invisible(file.remove(file.path(path, "land-cover", zipname)))
    
    clc <- read.csv2(file.path(path, "land-cover", filename))
    clc <- clc[-c(1:3), -3]
    
    for (i in 2:ncol(clc)) clc[ , i] <- as.numeric(clc[ , i])
    
    colnames(clc) <- gsub("\\.+", ".", colnames(clc))
    colnames(clc) <- gsub("\\.", "_", colnames(clc))
    
    colnames(clc) <- gsub("Superficie_du_poste_[0-9]+_", "", colnames(clc))
    colnames(clc) <- gsub("_en_ha_", "", colnames(clc))
    colnames(clc) <- tolower(colnames(clc))
    
    colnames(clc) <- c("code_insee", 
                       "version",
                       "territoires_artificialisés",
                       "territoires_agricoles", 
                       "forêts_et_milieux_semi_naturels",
                       "zones_humides", 
                       "surfaces_en_eau")
    
    rownames(clc) <- NULL
    
    write.csv2(clc, file = file.path(path, "land-cover", filename), 
               row.names = FALSE)
  }
  
  invisible(NULL)
}
