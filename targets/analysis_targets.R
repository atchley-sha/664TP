tar_plan(
  base_attractions = sum(land_use$trips),
  base_pm_attractions = sum(land_use$pm_trips),
  
  base_counts_coords = assign_movement_coords(base_traffic_counts, intersection_coords),
  base_delay_coords = assign_movement_coords(base_delay, intersection_coords),
  base_los_coords = assign_movement_coords(base_los, intersection_coords),
)