ui_searchbox <- function () {
  
  panel(status = "info",
    
    textInput(inputId     = "city", 
              label       = HTML("&#9755;&nbsp;Entrez votre commune"), 
              value       = "",
              placeholder = "Entrez votre commune"),
    
    actionButton(inputId = "search", 
                 label   = "Search", 
                 icon    = icon("search"))
  )
}
