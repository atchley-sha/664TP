grow_traffic <- function(counts, year, rate = 0.02){
  
  multiplier = (1 + rate)^year
  
  counts %>% 
    mutate(across(c(l, t, r), ~(.x*multiplier) %>% round()))
  
}
