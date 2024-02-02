library(fresh) #for shiny dashboard but can be used for apps too i think

# making a css for dashboard 

create_theme(
  
  adminlte_color(
    
    light_blue = "darkblue" #dont know why the argument name is light_blue but doesnt mean it has ot be light blue
    
  ),
  
  adminlte_global(
    
    content_bg = "pink" #body of dashboard
    
  ),
  
  adminlte_sidebar(
    
    width = "400px", 
    dark_bg = "lightblue",
    dark_hover_bg = "magenta",
    dark_color = "red"
    
  ),
  
  output_file = "shinydashboard/www/dashboard-fresh-theme.css"
  
)
