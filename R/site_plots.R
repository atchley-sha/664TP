# Put traffic counts on site map
plot_traffic_counts <- function(counts, image_file, development_name, out_file, dev_x = 975, dev_y = 950){
  
  p <- image_file %>% 
    image_read() %>% 
    image_ggplot(interpolate = TRUE) +
    geom_text(aes(x = dev_x, y = dev_y, label = development_name), size = 3) +
    geom_text(data = counts, aes(x = x, y = y, label = volume), size = 3)
  
  ggsave(out_file, plot = p)
  
  p
}

plot_los <- function(LOS, LOS_int, image_file, development_name, out_file, dev_x = 975, dev_y = 950){
  
  p <- image_file %>% 
    image_read() %>% 
    image_ggplot(interpolate = TRUE) +
    geom_text(aes(x = dev_x, y = dev_y, label = development_name), size = 3) +
    geom_text(data = LOS, aes(x = x, y = y, label = los), size = 3) +
    geom_label(data = LOS_int, size = 5, mapping = aes(
      x = x, y = y, label = los), fill = "black", color = "white")
  
  ggsave(out_file, plot = p)
  
  p
}

# Put development name on site map
plot_map <- function(image_file, development_name, out_file, dev_x = 975, dev_y = 950){
  
  p <- image_file %>% 
    image_read() %>% 
    image_ggplot(interpolate = TRUE) +
    geom_text(aes(x = dev_x, y = dev_y, label = development_name), size = 3)
  
  ggsave(out_file, plot = p)
  
  p
}