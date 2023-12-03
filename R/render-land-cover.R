render_land_cover <- function(layers, layer) {
  
  clc <- data.frame("territoires_artificialisés"      = "___",
                    "territoires_agricoles"           = "___",
                    "forêts_et_milieux_semi_naturels" = "___",
                    "zones_humides"                   = "___",
                    "surfaces_en_eau"                 = "___")
  
  if ("insee" %in% colnames(layer)) {
    
    code_insee <- as.character(sf::st_drop_geometry(layer[1, "insee"]))
    lcl <- layers$"landcover"[layers$"landcover"[ , "code_insee"] == 
                                code_insee, ]
    
    if (nrow(lcl) > 0) {
      
      clc <- lcl[which.max(lcl$"version"), -c(1:2)]
      clc[1, ] <- round(100 * clc[1, ] / sum(clc), 1)  

    }
  }
  
  html <- NULL
  
  html <- c(html, paste0("<p class='wiki-section'>&#10148; Occupation des sols</p>"))
  
  for (i in 1:ncol(clc)) {
    
    nom <- gsub("_", " ", colnames(clc)[i])
    nom <- paste0(toupper(substr(nom, 1, 1)), substr(nom, 2, nchar(nom)))
    val <- ifelse(clc[1, i] == "___", "___", paste0(clc[1, i], "%"))
    
    html <- c(html, paste0("<p class='wiki-label'>", nom, " : ", 
                           val, "</p>"))
    
  }
  
  html <- c(html, paste0("<br />"))
  
  html <- c(html, paste0("<span class='source'>Source : <a href='", 
                         "https://www.statistiques.developpement-durable.gouv.fr/corine-land-cover-0?rubrique=348&dossier=1759", 
                         "'>Corine Land Cover</a></span>"))

  HTML(paste0(html, collapse = ""))  
}
