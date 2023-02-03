tar_plan(
  base_attractions = sum(land_use$trips),
  base_pm_attractions = sum(land_use$pm_trips),
  
  los_base = base_los |>
    dplyr::filter(type == "movement"),
  los_int_base = base_los |>
    dplyr::filter(type == "intersection")
)