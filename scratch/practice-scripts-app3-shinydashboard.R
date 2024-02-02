library("tidyverse")
library("leaflet")

# read in data ----
lake_data <- read_csv(here::here("shinydashboard", "data", "lake_data_processed.csv"))


# practicing filtering ----
filtered_lakes <- lake_data %>% 
  filter(Elevation >= 8 & Elevation <= 20) %>% 
  filter(AvgDepth >= 2 & AvgDepth <= 3) %>% 
  filter(AvgTemp >= 4 & AvgTemp <= 6)

# build leaflet ----
leaflet() %>% 
  #types of base tiles you can use 
  addProviderTiles(providers$Esri.WorldImagery) %>% 
  setView(lng = -152.05, lat = 70.25, zoom = 6) %>% 
  addMiniMap(toggleDisplay = TRUE, minimized = FALSE) %>% 
  addMarkers(data = filtered_lakes,
             lng = filtered_lakes$Longitude,
             lat = filtered_lakes$Latitude,
             popup = paste0(
               "Site Name: ", filtered_lakes$Site, "<br>",
               "Elevation: ", filtered_lakes$Elevation, " meters (above SL)",
               "Avg Depth: ", filtered_lakes$AvgDepth, " meters", "<br>",
               "Avg Lake Bed Temperature: ", filtered_lakes$AvgTemp, "º" # option 0 to get degrees
             ))
