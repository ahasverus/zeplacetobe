coords_to_address <- function(coords) {
  
  ## Check args ----
  
  if (missing(coords)) {
    stop("Argument 'coords' is required", call. = FALSE)
  }
  
  if (is.null(coords)) { 
    stop("Argument 'coords' cannot be NULL", call. = FALSE)
  }
  
  if (!is.numeric(coords)) {
    stop("Argument 'coords' must be numeric", call. = FALSE)
  }
  
  if (length(coords) != 2) {
    stop("Argument 'coords' must be numeric of length 2", call. = FALSE)
  }
  
  if (coords[1] > 90 || coords[1] < -90) {
    stop("Latitude must be the first element of 'coords'", call. = FALSE)
  }

  
  ## API URL ----
  
  api_url <- "https://nominatim.openstreetmap.org/reverse"
  
  
  ## Build request ----
  
  full_url <- paste0(api_url, "?lat=", coords[1], "&lon=", coords[2], 
                     "&format=json&limit=1")
  
  
  ## Send request ----
  
  results <- httr::GET(full_url)
  
  
  ## Check status code -----
  
  if (results$"status_code" != 200) {
    stop("An error with the Nominatim API occurred", call. = FALSE)
  }
  
  
  ## Parse results ----
  
  results <- httr::content(results, as = "text")
  results <- jsonlite::fromJSON(results)
  
  
  ## Clean results ----
  
  if (length(results) == 0) {
    
    address <- NULL
    
  } else {
    
    if (!is.null(results$"address"$"village")) {
      
      address <- paste0(results$"address"$"village", ", ",
                        results$"address"$"county")
      
    } else {
      
      if (!is.null(results$"address"$"town")) {
        
        address <- paste0(results$"address"$"town", ", ",
                          results$"address"$"county")
        
      } else {
        
        address <- paste0(results$"address"$"city", ", ",
                          results$"address"$"county")
      }
    }
  }
  
  address
}
