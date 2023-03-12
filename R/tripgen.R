tripgen_reductions <- function(trips){
  trips %>% mutate(pb_rate = c(0.43, 0, 0.26),
                   pb_enter = round(mu_enter*pb_rate),
                   pb_exit = round(mu_exit*pb_rate), 
                   pb_tot = pb_enter + pb_exit,
                   new_enter = mu_enter - pb_enter,
                   new_exit = mu_exit - pb_exit,
                   new_tot = new_enter + new_exit,
                   mr_rate = 0.01,
                   mr_enter = round(new_enter*(1-mr_rate)),
                   mr_exit = round(new_exit*(1-mr_rate)),
                   mr_tot = mr_enter + mr_exit
  )
}

tripgen_sums <- function(trips){
  trips %>% 
    select(where(is.numeric), -code, -xval, -matches("rate")) %>%
    colSums()
}
