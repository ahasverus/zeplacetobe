extract_values <- function(rasters, layer) {
  
  data <- NULL
  
  if ("wikipedia" %in% colnames(layer)) {
  
    ## Elevation ----
    
    elevation <- terra::extract(rasters$"elevation", layer)
    colnames(elevation)[-1] <- "elevation"
    
    data <- c(data,
              "alt_mean" = round(mean(elevation[ , 2], na.rm = TRUE)),
              "alt_max"  = round(max(elevation[ , 2], na.rm = TRUE)),
              "alt_min"  = round(min(elevation[ , 2], na.rm = TRUE)))
    
    
    ## Current climate ----
    
    current_climate <- terra::extract(rasters$"current_climate", layer)
    current_climate <- apply(current_climate[ , -1], 2, mean, na.rm = TRUE)
    
    names(current_climate) <- NULL
    
    data <- c(data,
              "bio1_c"  = current_climate[1],
              "bio12_c" = current_climate[2],
              "bio13_c" = current_climate[3],
              "bio14_c" = current_climate[4],
              "bio5_c"  = current_climate[5],
              "bio6_c"  = current_climate[6])
    
    
    ## Future climate ----
    
    future_climate <- terra::extract(rasters$"future_climate", layer)
    future_climate <- apply(future_climate[ , -1], 2, mean, na.rm = TRUE)
    
    names(future_climate) <- NULL
    
    data <- c(data,
              "bio1_f"  = future_climate[1],
              "bio12_f" = future_climate[2],
              "bio13_f" = future_climate[3],
              "bio14_f" = future_climate[4],
              "bio5_f"  = future_climate[5],
              "bio6_f"  = future_climate[6])
    
    data <- round(data)
  }
  
  data
}
