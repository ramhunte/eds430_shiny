# global packages ----
library(shiny)
library(lterdatasampler)
library(palmerpenguins)
library(tidyverse)
library(shinyWidgets) # extension package for shiny with additional widgets for objects
library(markdown)
library(shinycssloaders)
library(sass) # for writing sass

# compile CSS ----

# need to do this step before running app and including in ui.R because it makes a css file based off of 
sass(
  input = sass_file("www/sass-styles.scss"),
  output = "www/sass-styles.css",
  options = sass_options(output_style = "compressed") #compressing sass rules so it runs faster
)


#............custom ggplot theme (apply to both plots)...........
myCustomTheme <- function() {
  theme_light() +
    theme(axis.text = element_text(size = 12),
          axis.title = element_text(size = 14, face = "bold"),
          legend.title = element_text(size = 14, face = "bold"),
          legend.text = element_text(size = 13),
          legend.position = "bottom",
          panel.border = element_rect(linewidth = 0.7))
}

#.......................wrangle trout data.......................
clean_trout <- and_vertebrates |>
  filter(species == "Cutthroat trout") |>
  select(sampledate, section, species, length_mm = length_1_mm, weight_g, channel_type = unittype) |> 
  mutate(channel_type = case_when(
    channel_type == "C" ~ "cascade",
    channel_type == "I" ~ "riffle",
    channel_type =="IP" ~ "isolated pool",
    channel_type =="P" ~ "pool",
    channel_type =="R" ~ "rapid",
    channel_type =="S" ~ "step (small falls)",
    channel_type =="SC" ~ "side channel"
  )) |> 
  mutate(section = case_when(
    section == "CC" ~ "clear cut forest",
    section == "OG" ~ "old growth forest"
  )) |> 
  drop_na()
#.......................END wrangle trout data.......................






























