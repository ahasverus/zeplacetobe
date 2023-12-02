library("shiny")
library("leaflet")


## Import data ----

check_data()
app_data <- load_data()


## Start App -----

ui <- fluidPage(
  
  tags$head(
    includeCSS("css/style.css")
  ),
  
  titlePanel("Ze Place to Be"),
  
  fluidRow(
    
    column(3, 
           wellPanel(
             textInput("city", "Entrez votre commune", ""),
             actionButton("search", "Search", icon = icon("search"))
           ),
           
           wellPanel(
             htmlOutput("wikipedia")
           )
    ),
    
    column(9,
           wellPanel(
             tags$p(tags$b("Localisation")),
             leafletOutput("map")
           )
    )
  ),
  
  fluidRow(
    
    column(3,
           wellPanel(
             htmlOutput("elevation")
           )
    ),
    
    column(3,
           wellPanel(
             htmlOutput("current_climate")
           )
    ),
    
    column(3,
           wellPanel(
             htmlOutput("future_climate")
           )
    ),
    
    column(3,
           wellPanel(
             htmlOutput("other")
           )
    )
  )
)


server <- function(input, output, session) {
  
  city <- eventReactive(input$search, {
    input$city
  })
  
  coords <- reactive({
    address_to_coords(city())
  })
  
  layer <- reactive({
    select_layer(app_data, coords())
  })
  
  values <- reactive({
    extract_values(app_data, layer())
  })
  
  output$map <- renderLeaflet({
    leaflet_map(layer())
  })
  
  output$wikipedia <- renderText({
    scrap_wikipedia(layer())
  })
  
  output$elevation <- renderText({
    render_elevation(values())
  })
  
  output$current_climate <- renderText({
    render_current_climate(values())
  })
}

shinyApp(ui, server)
