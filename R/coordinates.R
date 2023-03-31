assign_movement_coords <- function(data, coords, long = FALSE){
  
  if(long){
    long_data <- data
  } else{
  long_data <- data %>% 
    pivot_longer(
      -c(intersection, direction),
      names_to = "movement") %>% 
    filter(!is.na(value))
  }
  
  long_coords <- coords %>% 
    pivot_longer(
      -c(intersection, direction),
      names_to = c("movement", "coord"),
      names_sep = 1) %>% 
    filter(!is.na(value)) %>% 
    pivot_wider(names_from = coord)
  
  assigned <- long_data %>% 
    full_join(long_coords, by = c("intersection", "direction", "movement"))
  
  assigned
}

assign_distribution_coords <- function(data, coords){
  
  assigned <- full_join(
    data, coords, by = "direction"
  )
  
  assigned
}
