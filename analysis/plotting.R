# plotting params for all notebooks



phases_no3 <- data.frame(x1 = 77,
                         x2 = 97,
                         x3 = 204,
                         x4 = 250)

phases_rect <- list(
  geom_rect(aes(xmin=phases_no3$x1, xmax=phases_no3$x2, ymin=0, ymax=Inf), 
            fill = "#deebf7", color = "#deebf7"), 
  geom_rect(aes(xmin=phases_no3$x2, xmax=phases_no3$x3, ymin=0, ymax=Inf), 
            fill = "#bdd7ee", color = "#bdd7ee"), 
  geom_rect(aes(xmin=phases_no3$x3, xmax=phases_no3$x4, ymin=0, ymax=Inf), 
            fill = "#9dc3e6", color = "#9dc3e6"), 
  geom_rect(aes(xmin=phases_no3$x4, xmax=283, ymin=0, ymax=Inf), 
            fill = "#5b9bd5", color = "#5b9bd5")
)


phases_lines <- list(
  geom_vline(xintercept = phases_no3$x1), 
  geom_vline(xintercept = phases_no3$x2), 
  geom_vline(xintercept = phases_no3$x3), 
  geom_vline(xintercept = phases_no3$x4)
)



location_cols <- c("#F21B3F", "#FF9914")