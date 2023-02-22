tar_plan(
  # Data files
  tar_target(traffic_counts_file, "data/traffic_counts.csv", format = "file"),
  base_traffic_counts = read_csv(traffic_counts_file),
  
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
  
  tar_target(crash_file, "data/reference/2011-2013 Crashes (University Ave).xlsx", format = "file"),
  crashes = readxl::read_excel(crash_file),
  
  tar_target(trips_file, "data/tripgen.csv", format = "file"),
  tripgen = read_csv(trips_file),
  
  
  
  # Base images
  tar_target(site_traffic_base, "images/reference/site_traffic_base.png", format = "file"),
  tar_target(site_bus_base, "images/reference/site_bus.png", format = "file"),
  tar_target(site_intersection_base, "images/reference/site_intersections.png", format = "file"),
  tar_target(lane_config_base, "images/reference/lane_diagram.png", format = "file"),
  tar_target(crash_diagram, "images/reference/crash_diagram.png", format = "file"),
  
  crash_severity_table = tribble(
    ~level, ~type,
    5, "Fatal",
    4, "Incapacitating Injury",
    3, "Non-incapacitating Injury",
    2, "Possible Injury",
    1, "Property Damage Only"
  )
)
