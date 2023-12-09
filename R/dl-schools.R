dl_schools <- function(path) {
  
  dir.create(path         = file.path(path, "services"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  url <- paste0("https://www.data.gouv.fr/fr/datasets/r/9eb02ac9-4bce-4fa8-", 
                "a6f7-451c5b366f66")
  
  filename <- "fr-en-annuaire-education.geojson"
  
  if (!file.exists(file.path(path, "services", filename))) {
    
    utils::download.file(url      = paste0(url),
                         destfile = file.path(path, "services", filename),
                         mode     = "wb")
    
    school <- sf::st_read(file.path(path, "services", filename))
    
    coords <- school[ , "code_commune"]
    coords <- coords[which(!duplicated(coords$"code_commune")), ]
    
    deps <- substr(coords$"code_commune", 1, 2)
    pos <- which(deps %in% c("97" ,"98"))
    if (length(pos) > 0) coords <- coords[-pos, ]
    
    school <- school[ , c("type_etablissement", "statut_public_prive", 
                          "code_commune", "ecole_maternelle", 
                          "ecole_elementaire")]
    
    school <- sf::st_drop_geometry(school)
    school <- school[which(school$"type_etablissement" %in% c("Ecole", 
                                                              "Collège", 
                                                              "Lycée")), ]
    school <- school[school$statut_public_prive == "Public", ]
    school <- school[ , c("type_etablissement", "code_commune", 
                          "ecole_maternelle", "ecole_elementaire")]
    
    maternelles  <- school[which(school$"ecole_maternelle" == 1), 
                           c("code_commune", "ecole_maternelle")]
    
    maternelles <- maternelles[which(!duplicated(maternelles$"code_commune")), ]
    
    elementaires <- school[which(school$"ecole_elementaire" == 1), 
                           c("code_commune", "ecole_elementaire")]
    
    elementaires <- elementaires[which(!duplicated(elementaires$"code_commune")), ]
    
    colleges <- school[which(school$"type_etablissement" == "Collège"), 
                       c("code_commune", "ecole_elementaire")]
    
    colleges <- colleges[which(!duplicated(colleges$"code_commune")), ]
    
    colnames(colleges)[2] <- "college"
    colleges$"college" <- 1
    
    lycees <- school[which(school$"type_etablissement" == "Lycée"), 
                     c("code_commune", "ecole_elementaire")]
    
    lycees <- lycees[which(!duplicated(lycees$"code_commune")), ]
    
    colnames(lycees)[2] <- "lycee"
    lycees$"lycee" <- 1
    
    
    school <- merge(maternelles, elementaires, by = "code_commune", all = TRUE)
    school <- merge(school, colleges, by = "code_commune", all = TRUE)
    school <- merge(school, lycees, by = "code_commune", all = TRUE)
    
    deps <- substr(school$"code_commune", 1, 2)
    pos <- which(deps %in% c("97" ,"98"))
    
    if (length(pos) > 0) school <- school[-pos, ]
    
    school <- merge(school, coords, by = "code_commune", all = TRUE)
    sf::st_geometry(school) <- "geometry"
    
    invisible(file.remove(file.path(path, "services", filename)))
    
    sf::st_write(school, file.path(path, "services", filename))
  }
  
  invisible(NULL)
}
