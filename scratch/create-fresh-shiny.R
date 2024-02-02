library(fresh)


create_theme( # lets you start with a premade theme and fiddle with elements from there
  
  theme = "default", # starting with default theme 
  
  bs_vars_global( #global variables
    
    body_bg = "maroon",
    text_color = "white",
    link_color = "seagreen"
  ),
  
  bs_vars_navbar( #navigation bar
    
    default_bg = "blue",
    default_color = "gray", 
    
  ),
  
  bs_vars_tabs( # tab color
    
    border_color = "darkorange"
    
  ),
  
  output_file = "two-file-app/www/shiny-fresh-theme.css"
  
)

