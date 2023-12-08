library("shiny")
library("shinyWidgets")
library("leaflet")


## Import data ----

check_data()
app_data <- load_data()


## Create front-end interface -----

ui <- fluidPage(
  
  tags$head(includeCSS("css/style.css")),
  
  tags$head(HTML("<title>Find the best place to live in France</title>")),
  
  navbarPage(ui_navbar()),
  
  sidebarLayout(
    
    sidebarPanel(width = 5, style = paste0("background-color: transparent;", 
                                           "border-color: transparent;", 
                                           "border-width: 0;", 
                                           "padding: 0;"), 
                 
      fluidRow(
        
        column(width = 6, ui_searchbox()),
        column(width = 6, ui_infobox())
      ),
                 
      hr(),
                 
      fluidRow(
        
        column(width = 6, ui_adminbox()),
        column(width = 6, ui_landbox())
      ),
      
      fluidRow(

        column(width = 6, ui_curclimatebox()),
        column(width = 6, ui_futclimatebox())
      ),
      
      fluidRow(
        
        column(width = 12, ui_bottomnote()),
      )
    ),
    
    mainPanel(width = 7, 
              
      tags$style(type = "text/css", paste0("#map {height: calc(100vh - 80px)", 
                                           "!important;}")),
      leafletOutput("map")
    )
  )
)


## Setup back-end server -----

server <- function(input, output, session) {
  
  
  ## Catch city value on click ----
  
  city <- eventReactive(input$search, {
    input$city
  }, ignoreNULL = FALSE) # click on load

  
  ## Retrieve city coordinates w/ OSM API ----
  
  coords <- reactive({
    address_to_coords(city())
  })
  
  
  ## Select city spatial polygon ----
  
  layer <- reactive({
    select_layer(app_data, coords())
  })
  
  
  ## Extract and compute values ----
  
  values <- reactive({
    compute_values(app_data, layer())
  })
  
  
  ## Update outputs ----
  
  output$map <- renderLeaflet({
    render_map(layer())
  })
  
  output$adminbox <- renderText({
    render_adminbox(values())
  })
  
  output$landbox <- renderText({
    render_landbox(values())
  })
  
  output$curclimatebox <- renderText({
    render_curclimatebox(values())
  })
  
  output$futclimatebox <- renderText({
    render_futclimatebox(values())
  })
  
  
  ## Click on map ----
  
  observeEvent(input$map_click, {
    
    click <- input$map_click
    
    if (!is.null(click)) {

      popup_msg <- coords_to_address(c(click$lat, click$lng))
      
      # leafletProxy("map") %>%
      #   clearPopups() %>%
      #   addPopups(lng = click$lng, lat = click$lat, popup_msg)
      
      updateTextInput(inputId = "city", value = popup_msg)
    }
  })
}


## Start App -----

shinyApp(ui, server)
