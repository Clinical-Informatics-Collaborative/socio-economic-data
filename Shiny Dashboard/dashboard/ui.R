#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(leaflet)

fluidPage(
  tags$head(tags$style(
    HTML('
             #suburb_info {background-color: rgba(255,255,255,1); margin: 100;}
         ')
  )),
  titlePanel("Anxiety Disorder Patients by Suburbs"),
  leafletOutput("melbourneMap", height = 600),
  
  absolutePanel(
    id = "suburb_info",
    top = 100, right = 25, width = 250, 
    class = "panel panel-default", draggable = TRUE,
    style = "background-color: white;
            opacity: 1;
            padding: 10px;
            margin: auto;",
    h4("Suburb info"),
    uiOutput("suburbInfo")
  ),
)
