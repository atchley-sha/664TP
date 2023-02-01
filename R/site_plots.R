# Put traffic counts on site map
plot_traffic_counts <- function(counts, image_file, development_name, out_file, scale = 0.965){
  
p <- counts %>% 
  ggplot() +
  geom_blank() +
  geom_text(aes(x = x, y = y, label = volume), size = 3) +
  geom_text(aes(x = 50, y = 50, label = development_name), size = 3) +
  coord_fixed() +
  lims(x = c(0,100), y = c(0,80)) +
  theme_void()

ggdraw() +
  draw_image(image_file, scale = scale) +
  draw_plot(p)

ggsave(out_file)

p
}


# Put traffic LOS on site map
plot_los <- function(LOS, LOS_int, image_file, development_name, out_file, scale = 0.965){
  
  p <- LOS %>% 
    ggplot() +
    geom_blank() +
    geom_text(aes(x = x, y = y, label = los), size = 3) +
    geom_label(data = LOS_int, size = 5, mapping = aes(
      x = x, y = y, labes = los, fill = "black", color = "white")) +
    geom_text(aes(x = 50, y = 50, label = development_name), size = 3) +
    coord_fixed() +
    lims(x = c(0,100), y = c(0,80)) +
    theme_void()
  
  ggdraw() +
    draw_image(image_file, scale = scale) +
    draw_plot(p)
  
  ggsave(out_file)
  
  p
}


# Put development name on site map
plot_map <- function(image_file, development_name, out_file, scale = 0.965){
  
  p <- ggplot() +
    geom_blank() +
    geom_text(aes(x = 50, y = 50, label = development_name), size = 3) +
    coord_fixed() +
    lims(x = c(0,100), y = c(0,80)) +
    theme_void()
  
  ggdraw() +
    draw_image(image_file, scale = scale) +
    draw_plot(p)
  
  ggsave(out_file)
  
  p
}