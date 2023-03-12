assign_movement_coords <- function(data, coords){
  
  long_data <- data %>% 
    pivot_longer(
      -c(intersection, direction),
      names_to = "movement") %>% 
    filter(!is.na(value))
 
  long_coords <- coords %>% 
    pivot_longer(
      -c(intersection, direction),
      names_to = c("movement", "coord"),
      names_sep = 1) %>% 
    filter(!is.na(value)) %>% 
    pivot_wider(names_from = coord)
  
  assigned <- long_data %>% 
    left_join(long_coords, by = c("intersection", "direction", "movement"))
  
  assigned
}

assign_distribution_coords <- function(data, coords){
  
  assigned <- left_join(
    data, coords, by = "direction"
  )
  
}
