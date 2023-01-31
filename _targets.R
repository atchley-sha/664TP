library(targets)
library(tarchetypes)
library(here)


package_list <- c("tidyverse", "cowplot")
tar_option_set(packages = package_list)

# Source all files in `R` directory
r_files <- list.files("R", full.names = TRUE)
lapply(r_files, source)


########## List targets ########################################################

data_targets <- tar_plan(
  tar_target(traffic_counts_file, "data/traffic_counts_long.csv", format = "file"),
  
  base_traffic_counts = read_csv(traffic_counts_file),
  
  tar_target(site_map_base, "images/site_traffic_base.png", format = "file")
)


analysis_targets <- tar_plan(
  
)


viz_targets <- tar_plan(
  base_traffic_counts_map = 
    graph_traffic_counts(base_traffic_counts, site_map_base)
  
  
)


render_targets <- tar_plan(
  
)


########## Run all targets #####################################################

tar_plan(
  data_targets,
  analysis_targets,
  viz_targets,
  # render_targets
)