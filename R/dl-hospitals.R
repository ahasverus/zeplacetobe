dl_hospitals <- function(path) {
  
  dir.create(path         = file.path(path, "services"), 
             showWarnings = FALSE, 
             recursive    = TRUE)
  
  url <- paste0("https://www.data.gouv.fr/fr/datasets/r/9163e7ef-67fd-4db8-", 
                "bfca-e2e290e5f1dc")
  
  filename <- "france_hospitals.gpkg"
  
  if (!file.exists(file.path(path, "services", filename))) {
    
    departments <- c("2A", "2B", gsub(" ", "0", format(1:95)))
    departments <- sort(departments[departments != "20"])
    
    list_of_care_centers <- data.frame()
    
    for (department in departments) {
    
      base_url <- paste0("https://etablissements.fhf.fr/annuaire/search?",
                         "department=", department, 
                         "&type=etablissement")
      
      block <- FALSE
      n_page  <- 0
      
      while (!block) {
        
        page <- rvest::session(paste0(base_url, "&page=", n_page))
        
        articles <- rvest::html_elements(page, "article")
        
        if (length(articles) > 0) {
          
          types <- rvest::html_elements(articles, ".card-type") %>%
            rvest::html_text() %>%
            gsub("\\s+", " ", .) %>%
            gsub("Annuaire \\/ Établissement ", " ", .) %>%
            trimws(.)
          
          titles <- rvest::html_elements(articles, ".card-title") %>%
            rvest::html_text() %>%
            gsub("\\s+", " ", .) %>%
            gsub("\\s\\(.*\\)", "", .) %>%
            trimws(.)
          
          addresses <- rvest::html_elements(articles, ".address") %>%
            rvest::html_text() %>%
            gsub("\\s+", " ", .) %>%
            trimws(.)
          
          data <- data.frame("departement"   = department,
                             "etablissement" = types, 
                             "name"          = titles, 
                             "address"       = addresses)
          
          list_of_care_centers <- rbind(list_of_care_centers, data)
          
          n_page <- n_page + 1
          
        } else {
          
          block <- TRUE
        }
      }
      
      Sys.sleep(0.01)
    }
    
    list_of_care_centers
    
    
    ## Clean data ----
    
    cares <- list_of_care_centers[list_of_care_centers$etablissement %in% c("CH", "HL", "CHU"), ]
    cares <- cares[-grep("psy|admin|geront|géront|logis|product|rééd|reed|enfant|dentai|réadapt|readapt",
                         cares$"name",
                         ignore.case = TRUE), ]
    
    cares$"address" <- substr(cares$"address", 7, nchar(cares$"address"))
    
    cares$"address" <- tools::toTitleCase(tolower(cares$"address"))
    cares$"address" <- gsub(" Cedex", "", cares$"address")
    
    cares <- cares[-which(duplicated(paste(cares$"etablissement", cares$"address"))), ]
    
    cares$"address" <- gsub("Montereau Faut Yonne", "Montereau Fault Yonne", cares$"address")
    cares$"address" <- gsub("Villeuneuve-Sur-Yonne", "Villeneuve-Sur-Yonne", cares$"address")
    
    villes <- cares[ , c("departement", "address")]
    
    villes <- villes[-which(duplicated(villes$"address")), ]
    
    deps <- rvest::session("https://fr.wikipedia.org/wiki/Liste_des_d%C3%A9partements_fran%C3%A7ais") %>%
      rvest::html_table() %>%
      .[[2]] %>%
      as.data.frame() %>%
      .[-c(1:2), 1:2] %>%
      .[1:96, ]
    
    deps[ , 2] <- gsub(" \\(.*|\\[.*", "", deps[ , 2])
    
    colnames(deps) <- c("departement", "nom")
    rownames(deps) <- NULL
    
    villes <- merge(deps, villes, by = "departement")
    villes$"lon" <- NA
    villes$"lat" <- NA
    villes$"osm_name" <- NA
    
    for (i in 1:nrow(villes)) {
      cat(i, "\r")
      city <- paste0(villes[i, "address"], ", ", villes[i, "nom"])
      tmp <- address_to_coords(city)
      tmp$"name" <- strsplit(tmp$"name", ", ")[[1]][1]
      villes[i, "lon"] <- tmp[1, "lon"]
      villes[i, "lat"] <- tmp[1, "lat"]
      villes[i, "osm_name"] <- tmp[1, "name"]
    }
    
    villes$"CHU" <- 0
    villes$"CH"  <- 0
    villes$"HL"  <- 0
    
    for (i in 1:nrow(villes)) {
      
      villes[i, cares[which(cares$"departement" == villes[i, "departement"] &
                              cares$"address" == villes[i, "address"]), 
                      "etablissement"]] <- 1
    }
    
    villes <- sf::st_as_sf(villes, coords = 4:5, crs = sf::st_crs(4326))
    
    sf::st_write(villes, file.path(path, "services", filename))

  }
  
  invisible(NULL)
}
