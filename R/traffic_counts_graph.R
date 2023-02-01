# Put traffic counts on site map
plot_traffic_counts <- function(counts, image_file, development_name, scale = 0.965){
  
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

ggsave("images/traffic_counts_base.png")

p
}
