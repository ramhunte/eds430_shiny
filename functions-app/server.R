server <- function(input, output) {
  
  
  # render the scatterplot output from the build_penguin-scatterplot.R function file ----
  output$penguin_scatterplot_output <- build_penguin_scatterplot(input)
  
  # render the histogram output from the build_penguin_histogram.R function file ----
  output$penguin_histogram_output <- build_penguin_histogram(input)
    
} # END server