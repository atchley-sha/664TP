tar_plan(
  # Plotted maps
  base_traffic_counts_map = plot_on_intersection_map(base_counts_coords, site_traffic_base, development_name, "images/output/traffic_counts_base.png"),
  
  base_los_map = plot_on_intersection_map(base_los_coords, site_traffic_base, development_name, "images/output/traffic_los_base.png"),
  
  base_delay_map = plot_on_intersection_map(base_delay_coords, site_traffic_base, development_name, "images/output/traffic_delay_base.png"),
  
  yr5_counts_map = plot_on_intersection_map(yr5_coords, site_traffic_base, development_name, "images/output/traffic_counts_yr5.png"),
  
  yrop_counts_map = plot_on_intersection_map(yrop_coords, site_traffic_base, development_name, "images/output/traffic_counts_yrop.png"),
  
  bus_map = plot_map(site_bus_base, development_name, "images/output/bus.png"),
  
  intersection_map = plot_map(site_intersection_base, development_name, "images/output/intersections.png"),
  
  lane_config_map = plot_map(lane_config_base, development_name, "images/output/lane_diagram.png"),
  
  analogy_dist_map = plot_on_intersection_map(analogy_dist_coords, site_distribution_base, development_name, "images/output/analogy_dist.png", label_text_size = 5),

  
  #### taz maps ####
  
  isochrone_map = plot_isochrone(access, site_sf),
  taz_access_map = plot_taz_access(access, site_sf)
)