filter_sf <- function(sf, max_time = 25){
  sf %>% 
    filter(Travel_Dis > 0, Travel_Tim > 0) %>%
    filter(Travel_Tim <= max_time)
}

assign_taz_access <- function(taz, dirs){
  taz %>% 
    left_join(dirs, by = c("TAZID" = "ID"))
}

get_site_sf <- function(taz, id = 2025){
  taz %>% 
    filter(TAZID == id)
}

plot_isochrone <- function(taz, site, outfile = "images/output/isochrone.png"){
  p <- ggplot() +
    annotation_map_tile(type = "stamenbw", zoomin = 0, progress = "none") +
    layer_spatial(taz, aes(fill = Travel_Tim), alpha = 0.8) +
    scale_fill_fermenter(breaks = c(10, 15, 20), palette = "YlGn", direction = -1) +
    annotation_spatial(site, fill = "darkblue") +
    theme_void() +
    labs(fill = "Travel Time\n(minutes)")
  
  ggsave(outfile, plot = p)
  
  p
}

plot_taz_access <- function(taz, site, outfile = "images/output/taz_access_dirs.png"){
  p <- ggplot() +
    annotation_map_tile(type = "stamenbw", zoomin = 0, progress = "none") +
    layer_spatial(taz, aes(fill = access_dir), alpha = 0.8) +
    scale_fill_brewer(palette = "Set2", direction = -1) +
    annotation_spatial(site, fill = "darkblue") +
    theme_void() +
    labs(fill = "Access\nDirection")
  
  ggsave(outfile, plot = p)
  
  p
}

calculate_trip_proportions <- function(taz, time){
  access_prop <- taz %>% 
    filter(Travel_Tim <= time) %>% 
    st_drop_geometry() %>% 
    select(TAZID, POP_2015, Travel_Tim, access_dir) %>% 
    mutate(
      ff = 1/(Travel_Tim)^2,
      attr = POP_2015 * ff,
      trip_prop = attr/sum(attr)
    )
  
  access_prop   
}

trip_props <- function(trip_prop){
  summ <- trip_prop %>% 
    group_by(access_dir) %>% 
    summarise(n_taz = n(), trip_prop = sum(trip_prop)) %>% 
    mutate(trip_pct = round(trip_prop*100, 1) %>% paste0("%"))
  
  summ
}
