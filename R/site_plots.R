plot_on_intersection_map <- function(data, image_file, development_name, out_file, dev_x = 975, dev_y = 950){
  
  intersections <- data %>% 
    filter(direction == "intersection")
  movements <- data %>% 
    filter(direction != "intersection")
  
  p <- image_file %>% 
    image_read() %>% 
    image_ggplot(interpolate = TRUE) +
    geom_text(aes(x = dev_x, y = dev_y, label = development_name), size = 3) +
    geom_label(
      data = intersections,
      size = 5,
      mapping = aes(x = x, y = y, label = value),
      fill = "black",
      color = "white") +
    geom_text(
      data = movements,
      size = 3,
      mapping = aes(x = x, y = y, label = value))
  
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