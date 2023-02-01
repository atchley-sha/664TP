library(targets)
library(tarchetypes)
library(here)


package_list <- c("tidyverse", "cowplot", "quarto")
tar_option_set(packages = package_list)

# Source all files in `R` directory
r_files <- list.files("R", full.names = TRUE)
lapply(r_files, source)


########## List targets ########################################################

data_targets <- tar_plan(
  development_name = "Dream Town",
  
  tar_target(traffic_counts_file, "data/traffic_counts_long.csv", format = "file"),
  tar_target(land_use_file, "data/land_use/land_use.csv", format = "file"),
  
  base_traffic_counts = read_csv(traffic_counts_file),
  land_use = read_csv(land_use_file),
  
  tar_target(site_map_base, "images/site_traffic_base.png", format = "file")
)


analysis_targets <- tar_plan(
  base_attractions = sum(land_use$trips),
  base_pm_attractions = sum(land_use$pm_trips)
)


viz_targets <- tar_plan(
  base_traffic_counts_map = 
    plot_traffic_counts(base_traffic_counts, site_map_base, development_name)
  
  
)


render_targets <- tar_plan(
  tar_quarto(quarto, "index.qmd")
)


########## Run all targets #####################################################

tar_plan(
  data_targets,
  analysis_targets,
  viz_targets,
  # render_targets
)