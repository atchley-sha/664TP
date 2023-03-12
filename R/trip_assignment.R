# trips <- tar_read(site_trips)
# traffic <- tar_read(base_traffic_counts) %>% 
#   pivot_longer(-c(intersection, direction))
# access <- tar_read(trip_access) %>% 
#   pivot_longer(-c(intersection, direction))
# 
# int_acc <- traffic  %>% 
#   left_join(access, by = c("intersection", "direction", "name")) %>% 
#   filter(!is.na(value.x), value.y != "none") %>% 
#   `colnames<-`(c("int", "dir", "mvmt", "vol", "type")) %>% 
#   separate(type, into = c("type", "access", "direction")) %>% 
#   arrange(type, direction, access)
# 
# enter <- int_acc %>% 
#   filter(type == "en", direction != "intermediate") %>% 
#   mutate(vol = case_when(
#     int == "UATCD" & dir == "nb" & mvmt == "l" ~ vol / 2,
#     int == "UATCD" & dir == "wb" & mvmt == "t" ~ vol / 2,
#     TRUE ~ vol
#   ),
#   prop_vol = vol / sum(vol),
#   tot_trips = trips["mr_enter"],
#   trips = round(tot_trips*prop_vol))
# 
# int_acc %>% 
#   filter(type == "ex", direction != "split") %>% 
#   mutate(
#   prop_vol = vol / sum(vol),
#   tot_trips = trips["mr_exit"],
#   trips = round(tot_trips*prop_vol))
#   

