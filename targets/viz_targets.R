tar_plan(
  # Plotted maps
  base_traffic_counts_map = plot_traffic_counts(base_traffic_counts, site_traffic_base, development_name, "images/output/traffic_counts_base.png"),
  bus_map = plot_map(site_bus_base, development_name, "images/output/bus.png"),
  intersection_map = plot_map(site_intersection_base, development_name, "images/output/intersections.png"),
  
  # base_los_map = plot_los(los_base, los_int_base, site_traffic_base, development_name, "images/output/traffic_los_base.png")
  
  
  # Flextables
  landuse_table = land_use |>
    dplyr::select(pad, landuse, code, sqft) |>
    `colnames<-`(c("Development Pad", "Proposed Land Use", "ITE Land Use Code", "Area (sqft)")) |>
    flextable::flextable() |>
    flextable::autofit()
  
)