grow_traffic <- function(counts, year, rate = 0.02){
  
  multiplier = (1 + rate)^year
  
  counts %>% 
    mutate(across(c(l, t, r), ~(.x*multiplier) %>% round()))
  
}

#use data with coords
add_site_trips <- function(background, site){
  
  #join by x and y as well: these should match/be redundant, but it's good to make sure of it. If there's a mismatch there should be NAs or an error
  full_join(background, site, by = join_by(intersection, direction, movement, x, y), suffix = c("_b", "_s")) %>%
    mutate(
      intersection,
      direction,
      movement,
      across(c(value_b, value_s), \(x) replace_na(x, 0)),
      value = value_b + value_s,
      x,
      y,
      .keep = "none") %>% 
    filter(direction != "intersection")
  
}
