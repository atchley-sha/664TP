tar_plan(
  base_attractions = sum(land_use$trips),
  base_pm_attractions = sum(land_use$pm_trips),
  
  base_counts_coords = assign_movement_coords(base_traffic_counts, intersection_coords),
  base_delay_coords = assign_movement_coords(base_delay, intersection_coords),
  base_los_coords = assign_movement_coords(base_los, intersection_coords),
  
  crash_ranges = create_ranges(crash_range, intersections_mp, crash_influence_radius),
  sorted_crashes = sort_crashes(crashes, crash_ranges),
  crash_rates = get_crash_rates(sorted_crashes, crash_ranges, UA_AADT),
  crash_severity = get_crash_severity(sorted_crashes, crash_severity_table)
  
  
)