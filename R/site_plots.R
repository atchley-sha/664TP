plot_on_intersection_map <- function(data, image_file, development_name, out_file, dev_x = 975, dev_y = 950, intersection_text_size = 5, label_text_size = 3, include_site = FALSE){
  
  intersections <- data %>% 
    filter(direction == "intersection")

  if(include_site){
  other <- data %>% 
    filter(direction != "intersection")
  } else if("intersection" %in% colnames(data)){
    other <- data %>% 
      filter(direction != "intersection", !str_detect(intersection, "SITE"))
  } else{
    other <- data %>% 
      filter(direction != "intersection")
  }
  
  p <- image_file %>% 
    image_read() %>% 
    image_ggplot(interpolate = TRUE) +
    geom_text(aes(x = dev_x, y = dev_y, label = development_name), size = 3) +
    geom_label(
      data = intersections,
      size = intersection_text_size,
      mapping = aes(x = x, y = y, label = value),
      fill = "black",
      color = "white") +
    geom_text(
      data = other,
      size = label_text_size,
      mapping = aes(x = x, y = y, label = value))
  
  ggsave(out_file, plot = p, width = 6, units = "in")
  
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
