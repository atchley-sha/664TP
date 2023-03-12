assign_trip_directions <- function(trips, directions){
  
  directions_typed <- directions %>% 
    pivot_longer(-c(intersection, direction),
                 names_to = "movement", values_to = "value") %>% 
    separate(value, c("type", "external_dir")) %>% 
    filter(!is.na(type)) %>% 
    arrange(type, external_dir)
  
  long_trips <- trips %>% 
    pivot_longer(-c(intersection, direction),
                 names_to = "movement", values_to = "volume")
  
  joined <- left_join(directions_typed, long_trips,
            by = c("intersection", "direction", "movement"))

  joined
}



summarise_trip_directions_primary <- function(trips){
  
  trips %>% 
    filter(!type %in% c("internal", "none")) %>% 
    group_by(external_dir) %>% 
    summarise(vol = sum(volume)) %>%
    add_row(external_dir = "ne", vol = 0) %>% 
    mutate(pct = vol / sum(vol),
           pct_char = (100*pct) %>% 
             round() %>% 
             paste0("%"))
  
}

summarise_trip_directions_passby <- function(trips){
  
  classified <- trips %>% 
    filter(str_detect(intersection, "UA")) %>% 
    transmute(intersection, direction, movement, volume,
              value = case_when(
                str_detect(intersection, "1200") ~ case_when(
                  direction == "sb" & movement == "t" ~ "en_n",
                  direction == "eb" & movement == "r" ~ "en_n",
                  direction == "wb" & movement == "l" ~ "en_n",
                  direction == "nb" ~ "ex_n"
                ),
                str_detect(intersection, "TCD") ~ case_when(
                  direction == "nb" & movement == "t" ~ "en_s",
                  direction == "eb" & movement == "l" ~ "en_s",
                  direction == "wb" & movement == "r" ~ "en_s",
                  direction == "sb" ~ "ex_s"
                )
              )) %>% 
    filter(!is.na(value)) %>% 
    separate(value, c("type", "dir")) %>% 
    group_by(type, dir) %>% 
    summarise(vol = sum(volume))
  
  dist <- classified %>% 
    mutate(bound = case_when(
      type == "en" & dir == "s" ~ "nb",
      type == "ex" & dir == "n" ~ "nb",
      type == "en" & dir == "n" ~ "sb",
      type == "ex" & dir == "s" ~ "sb"
    )) %>% 
    group_by(bound) %>% 
    summarise(mean_vol = mean(vol)) %>% 
    mutate(pct = mean_vol / sum(mean_vol),
           pct_char = (100*pct) %>% 
             round() %>% 
             paste0("%"))
  
  dist
}