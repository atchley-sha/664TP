tar_plan(
  
  # Info
  development_name = "Dream Town",
  map_name_x = 975,
  map_name_y = 950,
  
  # Data files
  tar_target(traffic_counts_file, "data/traffic_counts_long.csv", format = "file"),
  base_traffic_counts = read_csv(traffic_counts_file),
  
  # tar_target(traffic_los_base_file, "data/traffic_los_long.csv", format = "file"),
  # base_los = read_csv(traffic_los_base_file),
  
  tar_target(land_use_file, "data/land_use.csv", format = "file"),
  land_use = read_csv(land_use_file),
  
  
  # Base images
  tar_target(site_traffic_base, "images/reference/site_traffic_base.png", format = "file"),
  tar_target(site_bus_base, "images/reference/site_bus.png", format = "file"),
  tar_target(site_intersection_base, "images/reference/site_intersections.png", format = "file"),
  

  # Static images
  tar_target(sitemap_file, "images/site_map.png", format = "file"),
  sitemap = knitr::include_graphics(sitemap_file),
  
  tar_target(siteplan_file, "images/site_plan_prelim.png", format = "file"),
  siteplan = image_read(siteplan_file)
)