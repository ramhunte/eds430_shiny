#........................dashboardHeader.........................
header <- dashboardHeader(
  
  # title ----
  title = "Fish Creek Watershed Lake Monitoring", 
  titleWidth = 400
  
)

#........................dashboardSidebar........................
sidebar <- dashboardSidebar(
  
  # sidebar ----
  sidebarMenu(
    
    menuItem(text = "Welcome", tabName = "welcome", icon = icon("star")), #fontawesome website
    menuItem(text = "Dashboard", tabName = "dashboard", icon = icon("gauge"))
    
  ) # END sidebarMenu
  
)

#..........................dashboardBody.........................
body <- dashboardBody(
  
  # set theme ----
  fresh::use_theme("dashboard-fresh-theme.css"), #shiny dashboard theme from www
  
  # tabitems ----
  tabItems(
    
    # welcome tabItem ----
    tabItem(tabName = "welcome",
            
            # left hand column
            column(width = 6, 
                   
                   # background info box ----
                   box( width = NULL, #normally need to set box width but we already did in column 
                        
                        title = tagList(icon("water"),
                                        strong("Monitoring Fish Creek Watersshed")), # making a title
                        includeMarkdown("text/intro.md"),
                        tags$img(src = "FishCreekWatershedSiteMap_2020.jpeg",#file path to image stored in www
                                 alt = "A map of Northern AK, showing Fish Creek Watershed, located within Nationale Pretrlium Reserve",
                                 style = "max-width: 100%;"),
                        tags$h6(tags$em("Map Source:", tags$a(href = "http://www.fishcreekwatershed.org/",
                                                              "FCWO")),
                                style = "text-align: center;"  )
                        
                   ) # END background box 
                   
            ), # END column
            
            #right hand column ----
            column(width = 6,
                   
                   # first fluid row ----
                   fluidRow(
                     
                     # citation box ----
                     box(width = NULL,
                         title = tagList(icon("bug"),
                                         strong("Data Source")),
                         includeMarkdown("text/citation.md")
                         
                     ) #END citation box
                     
                   ), # END first fluid row 
                   
                   # second fluid row ----
                   fluidRow(
                     
                     # disclaimer box ----
                     box(width = NULL,
                         
                         title = tagList(icon("triangle-exclamation"),
                                         strong("Disclaimer")),
                         includeMarkdown("text/disclaimer.md")
                         
                     ) # END disclaimer box 
                     
                   ) #END second fluid row
                   
                   
            ) # END right hand column
            
            
    ), # END welcometabItem
    
    # dashboard tabItem 
    
    # dashboard taItem ----
    tabItem(tabName = "dashboard",
            
            fluidRow(
              
              # input box ----
              box(width = 4,
                  
                 title = tags$strong("Adjust lake parameter ranges:"),
                 
                 # sliderInputs ----
                 
                 # elevation slider
                 sliderInput(inputId = "elevation_slider_input",
                             label = "Elevation (meters above SL):",
                             min = min(lake_data$Elevation), 
                             max = max(lake_data$Elevation),
                             value = c(min(lake_data$Elevation),
                                       max(lake_data$Elevation))), 
                 
                 # depth sliderInputs ----
                 sliderInput(inputId = "depth_slider_input",
                             label = "Average depth (meters):",
                             min = min(lake_data$AvgDepth), 
                             max = max(lake_data$AvgDepth),
                             value = c(min(lake_data$AvgDepth),
                                       max(lake_data$AvgDepth))),
                 
                 # depth sliderInputs ----
                 sliderInput(inputId = "temp_slider_input",
                             label = "Average temperature (º):",
                             min = min(lake_data$AvgTemp), 
                             max = max(lake_data$AvgTemp),
                             value = c(min(lake_data$AvgTemp),
                                       max(lake_data$AvgTemp))),
                  
              ), # END input box 
              
              # map box ----
              box(width = 8,
                  
                  title = strong("Monitoring lakes within Fish Creek Watershed:"),
                  
                  # leaflet output ----
                  leafletOutput(outputId = "lake_map_output") %>% 
                    withSpinner(type = 1, color = "blue")
                
                  
              ) # END map box 
              
            ) #END fluidRow
            
    ) # END dashboard tabItem
    
  ) # END tabItems
  
)

#..................combine all in dashboardPage..................
dashboardPage(header, sidebar, body)



















