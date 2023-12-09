compute_values <- function(layers, layer) {
  
  data <- list()
  
  if ("wikipedia" %in% colnames(layer)) {
    
    
    ## Elevation ----
    
    elevation <- terra::extract(layers$"elevation", layer)
    colnames(elevation)[-1] <- "elevation"
    
    data$"elevation" <- c(
      "mean" = paste0(round(mean(elevation[ , 2], na.rm = TRUE)), " m"),
      "max"  = paste0(round(max(elevation[ , 2], na.rm = TRUE)), " m"),
      "min"  = paste0(round(min(elevation[ , 2], na.rm = TRUE)), " m")
    )
  
  } else {
    
    data$"elevation" <- c(
      "mean" = "___",
      "max"  = "___",
      "min"  = "___"
    )
  }
    
  
  if ("wikipedia" %in% colnames(layer)) {
    
    ## Current climate ----
    
    current_climate <- terra::extract(layers$"current_climate", layer)
    current_climate <- apply(current_climate[ , -1], 2, mean, na.rm = TRUE)
    
    names(current_climate) <- NULL
    
    data$"current" <- c(
      "bio01" = paste0(round(current_climate[1]), "&deg;C"),
      "bio05" = paste0(round(current_climate[5]), "&deg;C"),
      "bio06" = paste0(round(current_climate[6]), "&deg;C"),
      "bio12" = paste0(round(current_climate[2]), " mm"),
      "bio13" = paste0(round(current_climate[3]), " mm"),
      "bio14" = paste0(round(current_climate[4]), " mm")
    )
    
  } else {
      
    data$"current" <- c(
      "bio01" = "___",
      "bio05" = "___",
      "bio06" = "___",
      "bio12" = "___",
      "bio13" = "___",
      "bio14" = "___"
    )
  }
  
  
  if ("wikipedia" %in% colnames(layer)) {
    
    ## Future climate ----
    
    future_climate <- terra::extract(layers$"future_climate", layer)
    future_climate <- apply(future_climate[ , -1], 2, mean, na.rm = TRUE)
    
    names(future_climate) <- NULL
    
    data$"future" <- c(
      "bio01" = paste0(round(future_climate[1]), "&deg;C"),
      "bio05" = paste0(round(future_climate[5]), "&deg;C"),
      "bio06" = paste0(round(future_climate[6]), "&deg;C"),
      "bio12" = paste0(round(future_climate[2]), " mm"),
      "bio13" = paste0(round(future_climate[3]), " mm"),
      "bio14" = paste0(round(future_climate[4]), " mm")
    )
    
  } else {
      
    data$"future" <- c(
      "bio01" = "___",
      "bio05" = "___",
      "bio06" = "___",
      "bio12" = "___",
      "bio13" = "___",
      "bio14" = "___"
    )
  }
    
  
  if ("wikipedia" %in% colnames(layer)) {
    
    ## Future climate (deltas) ----
    
    data$"deltas" <- c(
      "bio01" = paste0(round(future_climate[1] - current_climate[1]), "&deg;C"),
      "bio05" = paste0(round(future_climate[5] - current_climate[5]), "&deg;C"),
      "bio06" = paste0(round(future_climate[6] - current_climate[6]), "&deg;C"),
      "bio12" = paste0(round(future_climate[2] - current_climate[2]), " mm"),
      "bio13" = paste0(round(future_climate[3] - current_climate[3]), " mm"),
      "bio14" = paste0(round(future_climate[4] - current_climate[4]), " mm")
    )
    
  } else {
      
    data$"deltas" <- c(
      "bio01" = "___",
      "bio05" = "___",
      "bio06" = "___",
      "bio12" = "___",
      "bio13" = "___",
      "bio14" = "___"
    )
  }
    
  
  ## Scrap Wikipedia ----
  
  data$"wikipedia" <- scrap_wikipedia(layer)
    
  
  if ("wikipedia" %in% colnames(layer)) {
    
    ## Earth quake ----
    
    insee <- as.character(sf::st_drop_geometry(layer[1, "insee"]))
    data$"risk" <- layers$"earth_quake"[layers$"earth_quake"$"insee" == insee, 
                                 "sismicite"]
    
    if (length(data$"risk") == 0) data$"risk" <- "___"
    
  } else {
    
    data$"risk" <- "___"
  }
  
  
  ## Land cover ----
  
  if ("wikipedia" %in% colnames(layer)) {
    
    code_insee <- as.character(sf::st_drop_geometry(layer[1, "insee"]))
    lcl <- layers$"landcover"[layers$"landcover"[ , "code_insee"] == 
                                code_insee, ]
    
    if (nrow(lcl) > 0) {
      
      data$"clc" <- as.numeric(lcl[which.max(lcl$"version"), -c(1:2)])
      
      data$"clc" <- round(100 * data$"clc" / sum(data$"clc"), 1)  
      data$"clc" <- paste0(format(data$"clc"), "%")
      data$"clc" <- gsub("\\.", ",", data$"clc")
      names(data$"clc") <- colnames(lcl)[-c(1:2)]
    }
    
  } else {
    
    data$"clc" <- c("territoires_artificialisés"      = "___",
                    "territoires_agricoles"           = "___",
                    "forêts_et_milieux_semi_naturels" = "___",
                    "zones_humides"                   = "___",
                    "surfaces_en_eau"                 = "___")
  }
  
  
  if ("wikipedia" %in% colnames(layer)) {
    
    ## Sunshine ----
    
    code_insee <- as.character(sf::st_drop_geometry(layer[1, "insee"]))
    code_insee <- substr(code_insee, 1, 2)
    
    sunshine <- layers$"sunshine"[layers$"sunshine"$"code" == code_insee, 
                                  "ensoleillement"]
    
    if (length(sunshine) == 0) {
      
      data$"sunshine" <- "___"
      
    } else {
      
      data$"sunshine" <- paste0(sunshine, " jours/an")
    }
    
  } else {
    
    data$"sunshine" <- "___"
  }
    
  
  if ("wikipedia" %in% colnames(layer)) {
    
    ## Hospital ----
    
    dist_to_hospital <- sf::st_distance(layers$"hospitals", layer)
    
    city <- layers$"hospitals"[which(dist_to_hospital == min(dist_to_hospital)), ]
    city <- as.character(sf::st_drop_geometry(city[1, "osm_name"]))
    
    dist_to_hospital <- round(as.numeric(min(dist_to_hospital)) / 1000)
    
    if (dist_to_hospital == 0) {
        
      data$"hospital" <- "Oui"
        
    } else {
        
      data$"hospital" <- paste0("à ", dist_to_hospital, " km (", city, ")") 
    }
    
  } else {
    
    data$"hospital" <- "___"
  }
  
  if ("wikipedia" %in% colnames(layer)) {
    
    ## Water quality ----
    
    code_insee <- as.character(sf::st_drop_geometry(layer[1, "insee"]))
    
    water <- layers$"water"[layers$"water"$"insee" == code_insee, "water"]
    
    if (is.na(water)) {
      
      data$"water" <- "___"
      
    } else {
      
      data$"water" <- water
    }
  
  } else {
    
    data$"water" <- "___"
  }
  
  data
}
