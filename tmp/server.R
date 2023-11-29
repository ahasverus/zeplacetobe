## Load packages -----

library("shiny")
library("leaflet")


## Import data ----

check_data()
app_data <- load_data()


## Start server -----

server <- function(input, output, session) {
  
  output$coords <- renderTable({ 
    input$search
    req(input$search)
    isolate(address_to_coords(input$city))

  })
  
  output$map <- renderLeaflet({
    
    input$search
    req(input$search)
    
    xy <- address_to_coords(input$city)
    
    x <- communes[communes$"nom" == input$city, ]
    
    view = sf::st_bbox(x)
    names(view) = NULL
    
    leaflet(x) %>% 
      addTiles() %>% 
      fitBounds(view[1], view[2], view[3], view[4]) %>% 
      addPolygons(weight = 1, color = "red", fillOpacity = 0.1) %>% 
      addCircleMarkers(xy[1, 1], xy[1, 2], weight = 2, color = "red", 
                       fillOpacity = 1, radius = 3)
    
  })
  
}
