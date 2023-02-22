#' @param range two-element named numeric vector with min and max milepost
#' @param intersections named vector with mileposts of intersections
create_ranges <- function(range, intersections, radius){
  
  int_ranges <- tibble(
    name = names(intersections),
    mp = intersections,
    min = mp - radius,
    max = mp + radius
  ) %>%
    arrange(mp)  %>%
    mutate(overlap = case_when(max > lead(min) ~ "yes",
                               max == lead(min) ~ "touch",
                               TRUE ~ "no"))
  
  if("yes" %in% int_ranges$overlap) stop("Intersection ranges (radii) overlap for crash analysis.")
  if("touch" %in% int_ranges$overlap) warning("Intersection ranges (radii) touch; continuing calculations.")
  
  if(nrow(int_ranges) > 1){
    for(i in 1:(nrow(int_ranges)-1)){
      inter_ranges <- int_ranges %>% 
        add_row(
          name = paste0(.$name[i], "--", .$name[i+1]),
          min = .$max[i],
          max = .$min[i+1]
        )
    }
    inter_ranges <- inter_ranges %>% arrange(min)
  }
  
  full_ranges <- inter_ranges %>% 
    add_row(
      name = paste0("--", .$name[1]),
      min = range["min"],
      max = .$min[1],
      .before = 1
    ) %>% 
    add_row(
      name = paste0(.$name[nrow(.)], "--"),
      min = .$max[nrow(.)],
      max = range["max"]
    ) %>% 
    arrange(min) %>% 
    transmute(name, mp, min, max,
              length = ifelse(is.na(mp), max - min, NA),
              type = ifelse(is.na(mp), "segment", "intersection"))
  
  full_ranges
}

#' @param ranges tibble of ranges
sort_crashes <- function(crashes, ranges){
  
  crashes_sorted <- crashes %>%
    filter(between(MILEPOINT, min(ranges$min), max(ranges$max))) %>% 
    mutate(
      bin = findInterval(MILEPOINT, ranges$min, rightmost.closed = TRUE),
      location = ranges$name[bin]
    )
  
  crashes_sorted
}

get_crash_rates <- function(crashes, ranges, AADT, years = 3){
  ranges %>% 
    left_join(
      count(crashes, location),
      by = c("name" = "location")
    ) %>% 
    mutate(
      AADT = AADT,
      rate = ifelse(
        type == "intersection",
        1000000*n/365.25/years/AADT,
        1000000*n/365.25/years/AADT/length
      )
    )
}

get_crash_severity <- function(crashes, severity){
  severity %>% 
    left_join(
      count(crashes, CRASH_SEVERITY_ID),
      by = c("level" = "CRASH_SEVERITY_ID")) %>% 
    mutate(n = ifelse(is.na(n), 0, n),
           pct = n / sum(n))
}