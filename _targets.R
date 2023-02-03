library(targets)
library(tarchetypes)
library(readr)

package_list <- c("tidyverse", "magick")
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