## Load packages -----

library("shiny")


## Create interface -----

ui <- fluidPage(
 
  titlePanel("Ze Place to Be"),
  
  fluidRow(
    
    column(3, 
           wellPanel(
             textInput("city", "Entrez votre commune", ""),
             actionButton("search", "Search", icon = icon("search")))),
    
    column(9,
           wellPanel(
             tags$p(tags$b("Localisation")),
             leafletOutput("map")),
           
           wellPanel(
             tags$p(tags$b("Extracted values")),
             tableOutput("coords")))
))
