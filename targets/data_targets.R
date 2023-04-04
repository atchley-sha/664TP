tar_plan(
  # Data files
  tar_target(traffic_counts_file, "data/traffic_counts.xlsx", format = "file"),
  base_traffic_counts = readxl::read_excel(traffic_counts_file),
  
  tar_target(traffic_los_base_file, "data/traffic_los.csv", format = "file"),
  base_los = read_csv(traffic_los_base_file),
  
  tar_target(traffic_delay_base_file, "data/traffic_delay.csv", format = "file"),
  base_delay = read_csv(traffic_delay_base_file),
  
  tar_target(land_use_file, "data/land_use.csv", format = "file"),
  land_use = read_csv(land_use_file),
  
  tar_target(street_config_file, "data/street_config.csv", format = "file"),
  street_config = read_csv(street_config_file),
  
  tar_target(los_criteria_file, "data/los_criteria.csv", format = "file"),
  los_criteria = read_csv(los_criteria_file),
  
  tar_target(intersection_coords_file, "data/intersection_coords.csv", format = "file"),
  intersection_coords = read_csv(intersection_coords_file),
  
  tar_target(distribution_coords_file, "data/distribution_coords.csv", format = "file"),
  distribution_coords = read_csv(distribution_coords_file),
  
  tar_target(crash_file, "data/reference/2011-2013 Crashes (University Ave).xlsx", format = "file"),
  crashes = readxl::read_excel(crash_file),
  
  tar_target(trips_file, "data/tripgen.csv", format = "file"),
  tripgen_base = read_csv(trips_file),
  tar_target(tripgen_daily_file, "data/tripgen_daily.csv", format = "file"),
  tripgen_daily = read_csv(tripgen_daily_file),
  
  tar_target(access_XN_file, "data/access_XN.csv", format = "file"),
  access_XN = read_csv(access_XN_file),
  
  tar_target(access_directions_file, "data/access_directions.csv", format = "file"),
  access_directions = read_csv(access_directions_file),
  access_directions_fig = prune_access_directions(access_directions),
  
  taz_sf = sf::read_sf("data/GIS/TAZ_DATA.shp"),
  tar_target(taz_access_dirs_file, "data/TAZ_access_dirs.csv", format = "file"),
  taz_access_dirs = read_csv(taz_access_dirs_file),
  
  tar_target(ite_parkgen_file, "data/ite_parkgen.csv", format = "file"),
  ite_parkgen = read_csv(ite_parkgen_file),
  
  tar_target(yrop_nobuild_los_file, "data/reference/future_los/yrop_nobuild_los.csv", format = "file"),
  tar_target(yrop_build_los_file, "data/reference/future_los/yrop_build_los.csv", format = "file"),
  tar_target(yr5_nobuild_los_file, "data/reference/future_los/yr5_nobuild_los.csv", format = "file"),
  tar_target(yr5_build_los_file, "data/reference/future_los/yr5_build_los.csv", format = "file"),
  
  yrop_nobuild_los = list(delay = select(read_csv(yrop_nobuild_los_file, name_repair = "minimal"), 1:6), los = select(read_csv(yrop_nobuild_los_file, name_repair = "minimal"), 7:12)),
  yrop_build_los = list(delay = select(read_csv(yrop_build_los_file, name_repair = "minimal"), 1:6), los = select(read_csv(yrop_build_los_file, name_repair = "minimal"), 7:12)),
  yr5_nobuild_los = list(delay = select(read_csv(yr5_nobuild_los_file, name_repair = "minimal"), 1:6), los = select(read_csv(yr5_nobuild_los_file, name_repair = "minimal"), 7:12)),
  yr5_build_los = list(delay = select(read_csv(yr5_build_los_file, name_repair = "minimal"), 1:6), los = select(read_csv(yr5_build_los_file, name_repair = "minimal"), 7:12)),
  
  ## Base images
  tar_target(site_traffic_base, "images/reference/site_traffic_base.png", format = "file"),
  tar_target(site_bus_base, "images/reference/site_bus.png", format = "file"),
  tar_target(site_intersection_base, "images/reference/site_intersections.png", format = "file"),
  tar_target(site_distribution_base, "images/reference/site_distribution.png", format = "file"),
  tar_target(lane_config_base, "images/reference/lane_diagram.png", format = "file"),
  tar_target(site_traffic_access_base, "images/reference/site_traffic_access.png", format = "file"),
  tar_target(crash_diagram, "images/reference/crash_diagram.png", format = "file"),
  
  crash_severity_table = tribble(
    ~level, ~type,
    5, "Fatal",
    4, "Incapacitating Injury",
    3, "Non-incapacitating Injury",
    2, "Possible Injury",
    1, "Property Damage Only"
  ),
  
  ## trip assignment pcts
  UA_left = base_traffic_counts[15,'l'],
  UA_thru = base_traffic_counts[15,'t'],
  UA_Lpct = unlist((UA_left / 2) / (UA_left / 2 + UA_thru)),
  TCD_thru = base_traffic_counts[14, 't'],
  TCD_right = base_traffic_counts[14, 'r'],
  TCD_Tpct = unlist((TCD_thru / 2) / (TCD_thru / 2 + TCD_right))
)
