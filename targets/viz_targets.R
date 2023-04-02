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
  
  access_directions_map = plot_on_intersection_map(access_fig_coords, site_traffic_base, development_name, "images/output/analogy_access_directions.png"),
  
  site_trips_map_new = plot_on_intersection_map(assigned_coords, site_traffic_access_base, development_name, "images/output/site_trips_new.png", include_site = TRUE, value = new_trips_all, zero_rm = TRUE),
  site_trips_map_pb = plot_on_intersection_map(assigned_coords, site_traffic_access_base, development_name, "images/output/site_trips_pb.png", include_site = TRUE, value = pb_trips, zero_rm = TRUE),
  site_trips_map_tot = plot_on_intersection_map(assigned_coords, site_traffic_access_base, development_name, "images/output/site_trips_tot.png", include_site = TRUE, value = total_count),
  all_trips_yrop_map = plot_on_intersection_map(all_trips_yrop_coords, site_traffic_access_base, development_name, "images/output/all_trips_yrop.png", include_site = TRUE),
  all_trips_yr5_map = plot_on_intersection_map(all_trips_yr5_coords, site_traffic_access_base, development_name, "images/output/all_trips_yr5.png", include_site = TRUE),

  
  #### taz maps ####
  
  isochrone_map = plot_isochrone(access, site_sf),
  taz_access_map = plot_taz_access(access, site_sf)
)