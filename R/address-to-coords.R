address_to_coords <- function(address) {
  
  ## Check args ----
  
  if (missing(address)) {
    stop("Argument 'address' is required", call. = FALSE)
  }
  
  if (is.null(address)) { 
    stop("Argument 'address' cannot be NULL", call. = FALSE)
  }
  
  if (!is.character(address)) {
    stop("Argument 'address' must be character", call. = FALSE)
  }
  
  if (length(address) != 1) {
    stop("Argument 'address' must be character of length 1", call. = FALSE)
  }
  
  
  ## API URL ----
  
  api_url <- "https://nominatim.openstreetmap.org/search"
  
  
  ## Encode search terms ----
  
  address <- paste0(address, ", France")
  address <- utils::URLencode(address)
  
  
  ## Build request ----
  
  full_url <- paste0(api_url, "?q=", address, "&format=json&limit=1")
  
  
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
    
    return(data.frame("lon"  = numeric(0),
                      "lat"  = numeric(0),
                      "name" = character(0)))
    
  } else {
    
    return(data.frame("lon"  = as.numeric(results$"lon"),
                      "lat"  = as.numeric(results$"lat"),
                      "name" = results$"display_name"))
  }
}
