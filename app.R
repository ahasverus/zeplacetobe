library("shiny")
library("leaflet")


## Import data ----

check_data()
app_data <- load_data()


## Create front-end interface -----

ui <- fluidPage(
  
  tags$head(
    includeCSS("css/style.css")
  ),
  
  fluidRow(
    column(6,
           tags$h2("Ze Place to Be")
    ),
    column(6,
           tags$div(class = 'github', 
                    tags$p(tags$a(href = 'https://github.com/ahasverus/zeplacetobe', 
                                  icon("github"))))
    )
  ),
  
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
           ),
           wellPanel(
             htmlOutput("services")
           )
    ),
    
    column(3,
           wellPanel(
             htmlOutput("land_cover")
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
    )
  )
)


## Setup back-end server -----

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
  
  output$services <- renderText({
    render_services(app_data, layer())
  })
  
  output$land_cover <- renderText({
    render_land_cover(app_data, layer())
  })
  
  output$current_climate <- renderText({
    render_current_climate(values())
  })
  
  output$future_climate <- renderText({
    render_future_climate(values())
  })
}


## Start App -----

shinyApp(ui, server)
