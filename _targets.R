library(targets)
library(tarchetypes)
library(readr)

package_list <- c("tidyverse", "magick", "sf", "ggspatial")
tar_option_set(packages = package_list)

# Source all files in `R` directory
r_files <- list.files("R", full.names = TRUE)
lapply(r_files, source)

########## List targets ########################################################

info_targets <- tar_plan(
  # Info
  development_name = "Dream Town",
  map_name_x = 975,
  map_name_y = 950,
  
  crash_range = c(min = 0.5, max = 1.0),
  intersections_mp = c("Towne Center Blvd." = 0.66, "1200 South" = 0.82),
  crash_influence_radius = 0.05,
  UA_AADT = 30550
)

data_targets <- source("targets/data_targets.R")

analysis_targets <- source("targets/analysis_targets.R")

viz_targets <- source("targets/viz_targets.R")

# render_targets <- tar_plan(
#   tar_quarto(quarto)
# )

########## Run all targets #####################################################

tar_plan(
  info_targets,
  data_targets,
  analysis_targets,
  viz_targets,
  # render_targets
)