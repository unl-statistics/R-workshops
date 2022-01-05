library(shiny)
library(tidyverse)
library(readr)

nyc <- read.csv("nyc_emergency.csv")
new_nyc <- nyc %>% separate(Creation.Date, into = c("Creation.Date", "Creation.Time"), sep="  ") %>% 
  separate(Creation.Date, into = c("Creation.Month", "Creation.Day", "Creation.Year")) %>% 
  mutate(Creation.Month = parse_number(Creation.Month),
         Creation.Day = parse_number(Creation.Day),
         Creation.Year = parse_number(Creation.Year)) %>%
  mutate(Borough = toupper(Borough))

nyc_state <- map_data("county","New York")

shinyServer(function(input, output) {

    nyc_subset <- reactive({
      years <- as.numeric(input$years)
        new_nyc %>%
            filter(Incident.Type == input$incident_type) %>%
            filter(Creation.Year %in% years)
    })

    output$crime <- renderPlot({
        ggplot(data = nyc_subset(), aes(x = Borough, fill = Borough)) +
            geom_bar(stat = "count") +
            theme_bw() +
            ggtitle(paste("Number of", input$incident_type, "Reports by Borough"))
    })

    output$location <- renderPlot({
      ggplot(data = nyc_state) +
        geom_point(data = nyc_subset(), aes(x = Longitude, y = Latitude, colour = Borough)) +
        geom_polygon(aes(x = long, y = lat, group = group), fill = NA, color = "black") +
        coord_map() +
        theme_test() +
        ggtitle("Locations of incidents") + xlim(-74.2, -73.5) + ylim(40.5,41)
    })
})
