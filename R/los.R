fill_int_col <- function(df){
  df %>% 
    filter(!is.na(i)) %>% 
    select(intersection, i) %>% 
    full_join(df, by = "intersection", suffix = c("", "_old")) %>% 
    select(-i_old) %>% 
    relocate(i, .after = last_col())
}

#' make table with delay values and los letters side by side
make_delay_and_los_table <- function(delay, los){
  
  delay_int <- fill_int_col(delay)
  los_int <- fill_int_col(los)
  
  combined <- full_join(delay_int, los_int,
                        by = c("intersection", "direction"),
                        suffix = c("_delay", "_los"))
  table <- combined %>% 
    filter(direction != "intersection") %>% 
    mutate(intersection = case_when(
      intersection == "TCB1200" ~ "Towne Centre Blvd. /\n1200 South",
      intersection == "TCBTCD" ~ "Towne Centre Blvd. /\nTowne Centre Dr.",
      intersection == "UA1200" ~ "University Ave. /\n1200 South",
      intersection == "UATCD" ~ "University Ave. /\nTowne Centre Dr.",
      intersection == "UASITE" ~ "University Ave.\nAccess",
      intersection == "1200SITE" ~ "1200 South\nAccess"
    ),
    direction = str_to_upper(direction))
  
  table
}
