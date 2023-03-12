tar_plan(
  base_attractions = sum(land_use$trips),
  base_pm_attractions = sum(land_use$pm_trips),
  
  base_counts_coords = assign_movement_coords(base_traffic_counts, intersection_coords),
  base_delay_coords = assign_movement_coords(base_delay, intersection_coords),
  base_los_coords = assign_movement_coords(base_los, intersection_coords),
  
  yrop_counts = grow_traffic(base_traffic_counts, year = 1), #opening is 1 year out
  yrop_coords = assign_movement_coords(yrop_counts, intersection_coords),  
  
  yr5_counts = grow_traffic(base_traffic_counts, year = 6), #5 years after opening is 6 after base
  yr5_coords = assign_movement_coords(yr5_counts, intersection_coords),
  
  crash_ranges = create_ranges(crash_range, intersections_mp, crash_influence_radius),
  sorted_crashes = sort_crashes(crashes, crash_ranges),
  crash_rates = get_crash_rates(sorted_crashes, crash_ranges, UA_AADT),
  crash_severity = get_crash_severity(sorted_crashes, crash_severity_table),
  
  tripgen = tripgen_reductions(tripgen_base),
  site_trips = tripgen_sums(tripgen),
  
  trip_dirs = assign_trip_directions(base_traffic_counts, access_directions),
  full_analogy = summarise_trip_directions(trip_dirs),
  raw_passby = full_analogy$passby_raw,
  analogy_trip_dist = full_analogy$distribution,
  analogy_dist_coords = assign_distribution_coords(analogy_trip_dist, distribution_coords),
  
  taz = filter_sf(taz_sf, max_time = 25),
  access = assign_taz_access(taz, taz_access_dirs),
  site_sf = get_site_sf(taz, id = 2025),
  time_threshold = 20,
  taz_time = calculate_trip_proportions(access, time = time_threshold),
  grav_time = trip_props(taz_time)
)
