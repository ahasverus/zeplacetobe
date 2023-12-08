dl_sunshine <- function(path) {
  
  
  dir.create(path         = file.path(path, "sunshine"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  baseurl  <- paste0("https://www.data.gouv.fr/fr/datasets/r/4cf82433-9053-", 
                     "4ea8-87d7-c8d409dd7bb7")
  
  filename <- "France_sunshine.rds"
  csvname  <- "temps-densoleillement-par-an-par-departement-feuille-1.csv"
  
  
  if (!file.exists(file.path(path, "sunshine", filename))) {
    
    utils::download.file(url      = paste0(baseurl),
                         destfile = file.path(path, "sunshine", csvname),
                         mode     = "wb")
    
    sunshine <- read.csv(file.path(path, "sunshine", csvname))
    colnames(sunshine) <- c("departement", "ensoleillement")
    
    sunshine$"departement" <- gsub("Eure-et-Loire", "Eure-et-Loir", 
                                   sunshine$"departement")
    sunshine$"departement" <- gsub("Côte-d’Or", "Côte-d'Or", 
                                   sunshine$"departement")
    
    sunshine$"key" <- tolower(sunshine$"departement")
    sunshine$"key" <- gsub("-|'", " ", sunshine$"key")
    sunshine$"key" <- iconv(sunshine$"key",from="UTF-8",to="ASCII//TRANSLIT")
    
    deps <- rvest::session(paste0("https://fr.wikipedia.org/wiki/Liste_des_", 
                                  "d%C3%A9partements_fran%C3%A7ais")) %>%
      rvest::html_table() %>%
      .[[2]] %>%
      as.data.frame() %>%
      .[-c(1:2), 1:2] %>%
      .[1:96, ]
    
    deps[ , 2] <- gsub(" \\(.*|\\[.*", "", deps[ , 2])
    
    colnames(deps) <- c("departement", "nom")
    rownames(deps) <- NULL
    
    deps$"key" <- tolower(deps$"nom")
    deps$"key" <- gsub("-|'", " ", deps$"key")
    deps$"key" <- iconv(deps$"key",from="UTF-8",to="ASCII//TRANSLIT")
    
    sunshine <- merge(sunshine, deps, by = "key")
    
    sunshine <- sunshine[ , c(4, 5, 3)]
    colnames(sunshine) <- c("code", "departement", "ensoleillement")
    
    saveRDS(sunshine, file.path(path, "sunshine", filename))
    
    invisible(file.remove(file.path(path, "sunshine", csvname)))
  }
  
  invisible(NULL)
}
