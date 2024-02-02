
#NOTES: use command A to hihglight all code and then command I to realign everything 

# user interface ----
ui <- navbarPage(
  
  # add in css theme
  # theme = "shiny-fresh-theme.css", #adding updated css from www folder
  
  # updated css with sass rules and applied to css in the global.R
  header = tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "sass-styles.css")
  ),
  
  title = "LTER Animal Data Explorer",
  
  # (Page 1) intro tab panel ----
  tabPanel( title = "About this page",
            
            # intro text fluid row ----
            fluidRow(
              column(1),
              column(12, includeMarkdown("text/about.md")), # need to include library(markdown) in global
              column(1)
              
            ), #end intro text fluid ROW
            
            hr(),
            
            includeMarkdown("text/footer.md")
            
  ), # End (Page 1) intro tabPanel 
  
  #(Page 2) data viz tabPanel ----
  tabPanel(title = "Explore the Data",
           
           # tabsetPanel to contain tavs for data viz ----
           tabsetPanel(
             # trout tabsetPanel ----
             tabPanel(title = "Trout",
                      
                      # trout sidebarLayout
                      sidebarLayout(
                        
                        # trout sidebarPanel ----
                        sidebarPanel(
                          
                          # channel type picker input ----
                          pickerInput(inputId = "channel_type_input",
                                      label = "Select channel type(s):",
                                      choices = unique(clean_trout$channel_type),
                                      selected = c("cascade", "pool"),
                                      # select all or non
                                      options = pickerOptions(actionsBox = TRUE), 
                                      # select multiple at once
                                      multiple = TRUE),
                          
                          # section checkboxGroupButtons ----
                          checkboxGroupButtons(inputId = "section_input",
                                                    label = "Select a sampling section(s):",
                                                    choices = c("clear cut forest", "old growth forest"),
                                                    selected = c("clear cut forest", "old growth forest"),
                                                    individual = FALSE, justified = TRUE, size = "sm", # justified says the width of the button will take up the size of the parent elemnt (side bar)
                                                    checkIcon = list(yes = icon("check"),
                                                                     no = icon("xmark"))) # from font awesome
                          
                        ), # End trout sidebarPanel
                        
                        # trout main panel
                        mainPanel(
                          
                          # trout scatterplot output ----
                          plotOutput(outputId = "trout_scatterplot_output") %>% 
                            shinycssloaders::withSpinner(color = "magenta", type = 1)
                          
                        ) # End trout mainpanel
                        
                      ) # End trout mainLayout
                      
                      
             ), # End trout tabPanel
             
             # penguin tabPanel ----
             tabPanel(title = "Penguins", 
                      
                      # peguin sidebarLayout
                      sidebarLayout(
                        
                        sidebarPanel(
                          
                          # island type picker input ----
                          pickerInput(inputId = "penguin_island_input",
                                      label = "Select Island(s):",
                                      choices = unique(penguins$island),
                                      selected = unique(penguins$island),
                                      options = pickerOptions(actionsBox = TRUE), 
                                      # select multiple at once
                                      multiple = TRUE),
                          
                          # bin number slider input ----
                          sliderInput(inputId = "bin_num_input",
                                      label = "Select # of bins:",
                                      #min, max, an default value range that slider is set to 
                                      min = 1, max = 100, value = 25),
                          
                          
                        ), # End penguins sidebarPanel
                        
                        #penguin mainPanel
                        mainPanel(
                          
                          # histogram output 
                          plotOutput(outputId ="flipperLength_histogram_output") %>% 
                            shinycssloaders::withSpinner(color = "green", type = 4, size = 2)
                          
                        ) # End penguin mainpanel
                        
                      ) # End penguin tabPanel
                      
             ) # End penguin tabPanel
             
           ) # End tabsetPanel
           
  ) # End (Page 2) data viz tabPanel
  
  
) # END navbar page