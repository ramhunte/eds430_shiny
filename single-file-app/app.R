# load packages ----
library(shiny)
library(palmerpenguins)
library(tidyverse)
library(DT)
library(bslib) #only works for shiny app not shiny dashboard

thematic::thematic_shiny() # making sure that plot theme match assigned theme

# user interface ----
ui <- fluidPage(
  
  theme = bs_theme( #only works for shinyapp not shiny dashboard
    
    bg = "#a36f6f", #background
    fg = "#FDF7f7", #foreground
    primary = "#483132", #primary
    base_font = font_google("Pacifico") # google fonts
    
  ),
  
  
  # app title ----
  # tags$ specifies the strucutre; can also just spay h1, but tags$ specifies
  tags$h1("My App Title"),
  
  # app subtitle ----
  # strong() makes things bold 
  h4(strong("Exploring Antarctic  Penguin Data")),
  
  # body mass slider input ----
  sliderInput(inputId = "body_mass_input",
              label = "Select a range of body masses (g):",
              #min, max, an default value range that slider is set to 
              min = 2700, max = 6300, value = c(3000, 4000)),
  
  # body mass plot output ----
  plotOutput(outputId = "body_mass_scatterplot_output"),
  
  # year input ----
  checkboxGroupInput(inputId = "year_input",
                     label = "Select year(s)",
                     choices  = unique(penguins$year),
                     selected = c("2007", "2008")),
  
  #DT output ----
  DT::dataTableOutput(outputId = "penguin_DT_output")
  
)

# server ----
server <- function(input, output) {
  
  #filter body masses ----
  body_mass_df <- reactive({
    
    penguins %>% 
      filter(body_mass_g %in% c(input$body_mass_input[1]:input$body_mass_input[2]))
    
  })
  
  #render penguin scatter plot ----
  output$body_mass_scatterplot_output <- renderPlot({
    
    # add ggplot code here
    #create scatterplot ----
    ggplot(na.omit(body_mass_df()),
           aes(x = flipper_length_mm, y = bill_length_mm, 
               color = species, shape = species)) +
      geom_point() +
      scale_color_manual(values = c("Adelie" = "darkorange", 
                                    "Chinstrap" = "purple", 
                                    "Gentoo" = "cyan4")) +
      scale_shape_manual(values = c("Adelie"= 19, 
                                    "Chinstrap" = 17, 
                                    "Gentoo" =15)) +
      labs(x = "Flipper Length (mm)", y = "Bill Length (mm)",
           color = "Penguin Species", shape = "Penguin Species") +
      theme_minimal() + 
      theme(legend.position = c(0.85, 0.2),
            legend.background = element_rect(color = "white"))
    
  })
  
  
  #filter for years ----
  years_df <- reactive({
    
    penguins %>% 
      filter(year %in% c(input$year_input))
    
  }) 
  
  
  #render penguin year DT table ---- 
  output$penguin_DT_output <- DT::renderDataTable({
    
    DT::datatable(years_df())
    
  })
  
  
  
  
}

# combine UI and server into app ----
shinyApp(ui = ui, server = server)




















