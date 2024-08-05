setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")
library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)

k9 <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n9_cubic.csv")
k10 <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n10_cubic.csv")
k11 <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n11_quartic.csv")
k12 <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n12_quartic.csv")
k9_designs <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n9_cubic_designs.csv", header = FALSE)
k10_designs <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n10_cubic_designs.csv", header = FALSE)
k11_designs <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n11_quartic_designs.csv", header = FALSE)
k12_designs <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n12_quartic_designs.csv", header = FALSE)

which.min(k10$Var2) # Index Number 31
min(k9$Var2) # Max SPV of 11.56
unlist(k9_designs[541:558])
k9_opt <- matrix(
  c(-0.89397, -0.99908, 0.90883, -0.99847, 0.99834, 0.098802, -0.99906, 0.88453, -0.40047, 0.9964, 0.69302, -0.52195, 0.11907, 0.48688, 0.87356, 0.99185, -0.79011, -0.24545), 
  ncol = 2,
  nrow = 9,
  byrow = TRUE
)

k10_opt <- matrix(unname(unlist(k10_designs[901:920])),
                         ncol = 2,
                         nrow = 10,
                         byrow = FALSE)

which.min(k12$Var2) # Index Number 48
min(k12$Var2) # Max SPV of 13.84171
unname(unlist(k12_designs[1129:1152]))
k12_opt <- matrix(
  unname(unlist(k12_designs[1129:1152])),
  ncol = 2,
  nrow = 12,
  byrow = FALSE
)

which.min(k11$Var2) # Index Number 22
min(k11$Var2) # Max SPV of 13.84171
unname(unlist(k11_designs[463:484]))
k11_opt <- matrix(
  unname(unlist(k11_designs[463:484])),
  ncol = 2,
  nrow = 11,
  byrow = FALSE
)

k9_pso <- read.csv("pso_data/K=2_N=10.csv")
k9_pso_designs <- read.csv("pso_data/K=2_N=10_designs.csv", header = FALSE)
which.min(k9_pso$Var2)
k9_opt <- matrix(
  unname(unlist(k9_pso_designs[7:8])),
  ncol = 2,
  nrow = 10,
  byrow = FALSE
)

k9_quadratic <- function(x1, x2){
  mm <- matrix(c(rep(1, 9), k9_opt[,1], k9_opt[,2],
                 k9_opt[,1]*k9_opt[,2], k9_opt[,1]^2, k9_opt[,2]^2),
               nrow = 9, ncol = 6, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2)
  return(9*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}



k9_cubic <- function(x1, x2){
  mm <- matrix(c(rep(1, 9), k9_opt[,1], k9_opt[,2],
                 k9_opt[,1]*k9_opt[,2], k9_opt[,1]^2, k9_opt[,2]^2,
                 k9_opt[,1]^3, k9_opt[,2]^3),
               nrow = 9, ncol = 8, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2, x1^3, x2^3)
  return(9*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

k10_cubic <- function(x1, x2){
  mm <- matrix(c(rep(1, 10), k10_opt[,1], k10_opt[,2],
                 k10_opt[,1]*k10_opt[,2], k10_opt[,1]^2, k10_opt[,2]^2,
                 k10_opt[,1]^3, k10_opt[,2]^3),
               nrow = 10, ncol = 8, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2, x1^3, x2^3)
  return(10*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

k11_quartic <- function(x1, x2){
  mm <- matrix(c(rep(1, 11), k11_opt[,1], k11_opt[,2],
                 k11_opt[,1]^2, k11_opt[,2]^2,
                 k11_opt[,1]^3, k11_opt[,2]^3,
                 k11_opt[,1]^4, k11_opt[,2]^4),
               nrow = 11, ncol = 9, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1^2, x2^2, x1^3, x2^3, x1^4, x2^4)
  return(11*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

k12_quartic <- function(x1, x2){
  mm <- matrix(c(rep(1, 12), k12_opt[,1], k12_opt[,2],
                 k12_opt[,1]^2, k12_opt[,2]^2,
                 k12_opt[,1]^3, k12_opt[,2]^3,
                 k12_opt[,1]^4, k12_opt[,2]^4),
               nrow = 12, ncol = 9, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1^2, x2^2, x1^3, x2^3, x1^4, x2^4)
  return(12*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

# Generates the plotting data given any polynomial
data_generator <- function(polynomial, interval){
  sequence <- seq(-1, 1, interval)
  data <- expand.grid(sequence, sequence)
  data$spv <- apply(data, 1, function(row) polynomial(row[1], row[2]))
  return(data)
}

data <- data_generator(k9_cubic, 0.01)

grid_points <- data.frame(x1 = k9_opt[,1],
                           x2 = k9_opt[,2])
grid_points$spv <- rep(3, nrow(grid_points))
#optimal_point <- data.frame('x1' = -1, 'x2'= -1, 'spv' = 3)

#grid_points <- rbind(grid_points, optimal_point)

# Add a new column to indicate the special point
#grid_points$special <- FALSE
#grid_points[which(grid_points$x1 == optimal_point$x1 & grid_points$x2 == optimal_point$x2), "special"] <- TRUE
#grid_points

# Create a ggplot object

ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits = c(2, 7)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "") +
  xlab("Factor 1")+ylab("Factor 2")+
  scale_x_continuous(breaks = seq(-1, 1, by = 0.5)) +
  scale_y_continuous(breaks = seq(-1, 1, by = 0.5)) +
  # Can make a vector outside the original dataset that has some information
  # about points to be plotted...
  geom_point(data = grid_points,
             aes(x = x1, y = x2, color = "x"), size = 2.5, show.legend = FALSE,
             pch=21, stroke = 1.5, fill = "yellow2") +

  #geom_point(data = grid_points[grid_points$special == TRUE,],
  #           aes(x = x1, y = x2, color = special),
  #           show.legend = FALSE,
  #           size=8,
  #           alpha = 1,
  #           pch=4,
  #           stroke=2.5)+

  scale_color_manual(values = c("red", "red"))+
  theme_minimal() +
  theme(
    legend.position="bottom",
    legend.key.width = unit(1.5, "cm"),
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 12),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 20)
  )


#theme(axis.text = element_blank(),
#     axis.title = element_blank(),
#    axis.ticks = element_blank())
