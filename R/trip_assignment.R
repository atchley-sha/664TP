select_access_intersections <- function(xn, access){
  
  xn_long <- xn %>%
    pivot_longer(-c(intersection, direction), names_to = "movement", values_to = "type") %>% 
    filter(!is.na(type))
  
  access_long <- access %>% 
    pivot_longer(-c(intersection, direction), names_to = "movement") %>% 
    separate(value, c("xn", "ex_dir")) %>% 
    filter(!is.na(ex_dir)) %>% 
    mutate(ex_dir = str_to_lower(ex_dir)) %>% 
    select(-xn)
  
  left_join(xn_long, access_long)
}

assign_trips <- function(access, distribution, UA_Lpct, TCD_Tpct, site_trips){
  
  dist <- distribution %>% 
    select(direction, pct)
  pb_dist <- dist %>% 
    filter(direction %in% c("nb", "sb"))
  new_trips <- tribble(
    ~NX, ~new_trips_total,
    "N", site_trips["mr_enter"],
    "X", site_trips["mr_exit"])
  pb_trips <- tribble(
    ~NX, ~pb_trips_total,
    "N", site_trips["pb_enter"],
    "X", site_trips["pb_exit"])
  
  prelim_pcts <- access %>% 
    separate(type, c("NX", "type")) %>% 
    left_join(dist, by = c("ex_dir" = "direction")) %>% 
    left_join(new_trips) %>% 
    left_join(pb_trips) %>% 
    mutate(split_pct = case_when(
      type == "sum" ~ NA,
      intersection == "UATCD" ~ case_when(
        direction == "nb" & movement == "l" ~ UA_Lpct,
        direction == "nb" & movement == "t" ~ 1 - UA_Lpct,
        direction == "wb" & movement == "t" ~ TCD_Tpct,
        direction == "wb" & movement == "r" ~ 1 - TCD_Tpct,
        TRUE ~ 1),
      TRUE ~ 1),
      new_pct = pct*split_pct,
      NAME = paste0(intersection, direction, movement),
      new_trips = round(new_trips_total*new_pct)
    )
  
  # In order to figure out the # of trips on the remaining movements, we have to hard-code what each movement is a sum of. It's done iteratively since some movements are sums of movements that are themselves sums.
  
  sum_trips <- prelim_pcts %>% 
      filter(!is.na(new_trips)) %>% 
    select(NAME, new_trips) %>% 
    deframe() %>% 
      vctrs::vec_c(
        "UATCDsbr" = .["TCBTCDwbl"],
        "UASITEsbr" = .["UA1200sbt"],
        "UA1200ebu" = .["TCB1200wbr"],
        "TCBTCDwbr" = .["UATCDnbl"] + .["UATCDwbt"],
        "UASITEnbl" = .["UATCDnbt"] + .["UATCDwbr"],
        #"split" is the total that will be split between the two SB University Ave exiting routes
        "split" = .["TCBTCDwbl"] + .["UATCDsbt"] + .["UATCDsbl"],
        .name_spec = "{outer}") %>% 
      vctrs::vec_c(
        "UASITEebr" = .["split"]*2/3,
        "UA1200ebr" = .["split"]*1/3,
        "TCB1200nbr" = .["TCBTCDwbr"] + .["TCBTCDnbt"],
        .name_spec = "{outer}") %>% 
      vctrs::vec_c(
        "1200SITEnbr" = .["UA1200ebu"] + .["UA1200ebl"] + .["UA1200ebr"],
        "1200SITEebr" = .["TCB1200nbr"] + .["TCB1200sbl"],
        "UASITEsbt" = .["UA1200ebr"],
        .name_spec = "{outer}"
      ) %>% 
      enframe("NAME", "new_trips_all") %>% 
    filter(NAME != "split")
  
  # Old version of above, much less clean:
  #
  # trips1 <- prelim_pcts$new_trips %>% 
  #   `names<-`(prelim_pcts$NAME)
  # 
  # sum_trips1 <- tribble(
  #   ~NAME, ~sum_trips,
  #   "UATCDsbr", trips1["TCBTCDwbl"],
  #   "UASITEsbr", trips1["UA1200sbt"],
  #   "UA1200ebu", trips1["TCB1200wbr"],
  #   "TCBTCDwbr", sum(trips1["UATCDnbl"], trips1["UATCDwbt"]),
  #   "UASITEnbl", sum(trips1["UATCDnbt"], trips1["UATCDwbr"]),
  #   #"split" is the total that will be split between the two SB University Ave exiting routes
  #   "split", sum(trips1["TCBTCDwbl"], trips1["UATCDsbt"], trips1["UATCDsbl"]))
  #   
  #   trips2 <- c(
  #     trips1[!names(trips1) %in% sum_trips1$NAME],
  #     sum_trips1$sum_trips %>% `names<-`(sum_trips1$NAME))
  #   
  #   sum_trips2 <- tribble(
  #     ~NAME, ~sum_trips,
  #     "UASITEebr", trips2["split"]*2/3,
  #     "UA1200ebr", trips2["split"]*1/3,
  #     "TCB1200nbr", sum(trips2["TCBTCDwbr"], trips2["TCBTCDnbt"]))
  #   
  #   trips3 <- c(
  #     trips2[!names(trips2) %in% sum_trips2$NAME],
  #     sum_trips2$sum_trips %>% `names<-`(sum_trips2$NAME))
  #   
  #   sum_trips3 <- tribble(
  #     ~NAME, ~sum_trips,
  #     "1200SITEnbr", sum(trips3["UA1200ebu"], trips3["UA1200ebl"], trips3["UA1200ebr"]),
  #     "1200SITEebr", sum(trips3["TCB1200nbr"], trips3["TCB1200sbl"]),
  #     "UASITEsbt", trips3["UA1200ebr"]
  #   )
  #   
  #   sum_trips <- bind_rows(sum_trips1, sum_trips2, sum_trips3) %>% 
  #     filter(NAME != "split")
    
    # Pass-by trips are difficult since they come from the background traffic. They need to be added to the driveways, but the *difference* between exiting and entering trips needs to be added to the downstream intersections. For simplicity's sake these differences are all going on the through movements. This will follow a somewhat similar process to assigning and summing the "new" trips.
    
    #calculate pb driveway trips
    # calculate_pb_trips <- full_join(prelim_pcts, sum_trips, by = "NAME") %>% 
      # Not needed due to updated code above
      #
      # mutate(new_trips_all = case_when(
      #   !is.na(sum_trips) ~ sum_trips,
      #   !is.na(new_trips) ~ new_trips
      # )) %>% 
      
      pb_trips <- prelim_pcts %>% 
      mutate(pb_bound = if_else(
        intersection == "UASITE",
        case_when(
          direction == "nb" & movement == "l" ~ "nb",
          direction == "eb" & movement == "l" ~ "nb",
          direction == "eb" & movement == "r" ~ "sb",
          direction == "sb" & movement == "r" ~ "sb"
        ),
        NA)) %>% 
      left_join(pb_dist, by = c("pb_bound" = "direction"), suffix = c("_new", "_pb")) %>% 
      mutate(pb_trips = round(pct_pb*pb_trips_total)) %>% 
      filter(!is.na(pb_trips)) %>%
      select(NAME, pb_trips) %>% 
      deframe() %>% 
      vctrs::vec_c(
        UA1200nbt = .["UASITEebl"] - .["UASITEnbl"],
        UATCDsbt = .["UASITEebr"] - .["UASITEsbr"],
        .name_spec = "{outer}") %>%
      enframe("NAME", "pb_trips")
    
    add_trips <- full_join(prelim_pcts, sum_trips, by = "NAME") %>% 
      full_join(pb_trips, by = "NAME") %>% 
      select(intersection, NAME, direction, movement, new_trips_all, pb_trips) %>% 
      mutate(across(.cols = everything(), .fns = ~(replace_na(.x,0)))) %>% 
      mutate(total_count = new_trips_all + pb_trips,
             value = total_count)
    
    add_trips
}