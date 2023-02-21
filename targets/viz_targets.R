tar_plan(
  # Plotted maps
  base_traffic_counts_map = plot_on_intersection_map(base_counts_coords, site_traffic_base, development_name, "images/output/traffic_counts_base.png"),
  base_los_map = plot_on_intersection_map(base_los_coords, site_traffic_base, development_name, "images/output/traffic_los_base.png"),
  bus_map = plot_map(site_bus_base, development_name, "images/output/bus.png"),
  intersection_map = plot_map(site_intersection_base, development_name, "images/output/intersections.png"),
  lane_config_map = plot_map(lane_config_base, development_name, "images/output/lane_diagram.png")
)