#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(leaflet)
library(maps)
library(dplyr)
library(sf)

melbourne_suburbs_name <- c(
  "Carlton", "Carlton North", "Docklands", "East Melbourne", 
  "Flemington", "Kensington", "Melbourne", "North Melbourne",
  "Parkville", "Port Melbourne", "Southbank", "South Wharf", 
  "South Yarra", "West Melbourne", "Albert Park", "Balaclava",
  "Elwood", "Middle Park", "Ripponlea", "St Kilda", "St Kilda East",
  "St Kilda West", "South Melbourne", "Abbotsford", "Alphington",
  "Burnley", "Clifton Hill", "Collingwood", "Cremorne", "Fairfield",
  "Fitzroy", "Fitzroy North", "Princes Hill", "Richmond"
)
melbourne_suburbs <- st_read("data/sf/vic_localities.shp")

melbourne_suburbs <- melbourne_suburbs[melbourne_suburbs$LOC_NAME 
                                       %in% melbourne_suburbs_name, ]

patient_data <- read.csv("data/synthetic_data.csv")

agg_data <- patient_data %>%
  group_by(Suburb) %>%
  summarize(
    total_patients = n(),
    male_count = sum(Gender == "Male"),
    female_count = sum(Gender == "Female"),
    ratio = sum(Income.Range == "<30,000") / total_patients,
  )

melbourne_suburbs <- left_join(melbourne_suburbs, agg_data, 
                               by = c("LOC_NAME" = "Suburb"))

bins <- seq(0, 1, by = 0.1)
pal <- colorBin("YlOrRd", domain = melbourne_suburbs$ratio, bins = bins)

function(input, output, session) {
  output$melbourneMap <- renderLeaflet({
    leaflet(data = melbourne_suburbs) %>%
      addProviderTiles("CartoDB.Positron") %>%
      addPolygons(
        layerId = ~LOC_PID,
        fillColor = ~pal(ratio),
        weight = 2,
        opacity = 1,
        color = "white",
        dashArray = "3",
        fillOpacity = 0.7,
        highlight = highlightOptions(
          weight = 5,
          color = "#666",
          dashArray = "",
          fillOpacity = 0.7,
          bringToFront = TRUE
        ),
        label = ~LOC_NAME,
        labelOptions = labelOptions(
          style = list("font-weight" = "normal", padding = "3px 8px"),
          textsize = "15px",
          direction = "auto"
        )
      ) %>%
      addLegend(pal = pal, values = ~ratio, opacity = 0.7, 
                title = "Ratio of low income to total number of patients",
                position = "bottomright")
  })
  
  observe({
    selected_suburb_LOC_PID <- input$melbourneMap_shape_mouseover$id
    output$suburbInfo <- renderUI({
      if (is.null(selected_suburb_LOC_PID)) {
        return(tags$div(""))
      } else {
        selected_suburb <- melbourne_suburbs[melbourne_suburbs$LOC_PID 
                                             == selected_suburb_LOC_PID, ]
        return(tags$div(
          tags$strong(selected_suburb$LOC_NAME),
          tags$div(paste0("Total number of patients: ", 
                          selected_suburb$total_patients)),
          tags$div(paste0("Ratio of low income to total number of patients: ", 
                          round(selected_suburb$ratio, digits = 2))),
          tags$div(paste0("Males: ", selected_suburb$male_count),
                   tags$div(paste0("Females: ", selected_suburb$female_count)
                   )),
        ))
      }
    })
  })
}

