# LOAD LIBRARIES ----
library(shiny)
library(shinydashboard)
library(tidyverse)
library(leaflet)
library(shinycssloaders) # laoding icons 
library(markdown)

# read in data
lake_data <- read_csv("data/lake_data_processed.csv") #avoid using here() when inside apps 

