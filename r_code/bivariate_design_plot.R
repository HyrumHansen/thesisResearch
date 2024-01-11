setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")
library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)

k9 <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n9_cubic.csv")
k12 <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n12_quartic.csv")
k9_designs <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n9_cubic_designs.csv", header = FALSE)
k12_designs <- read.csv("extension_functions/higher_order_data/gloptipoly_k2n12_quartic_designs.csv", header = FALSE)

which.min(k9$Var2) # Index Number 31
min(k9$Var2) # Max SPV of 11.56
unlist(k9_designs[541:558])
k9_opt <- matrix(
  c(
    c(-0.893970,  0.908830,  0.998340, -0.999060, -0.400470,  0.693020,  0.119070, 0.873560, -0.790110),
    c(-0.999080, -0.998470,  0.098802,  0.884530,  0.996400, -0.521950,  0.486880, 0.991850, -0.245450)),
  ncol = 2,
  nrow = 9,
  byrow = FALSE
)

which.min(k12$Var2) # Index Number 48
min(k12$Var2) # Max SPV of 13.84171
unname(unlist(k12_designs[1129:1152]))
k12_opt <- matrix(
  unname(unlist(k12_designs[1129:1152])),
  ncol = 2,
  nrow = 12,
  byrow = FALSE
)


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

data <- data_generator(k12_quartic, 0.01)

grid_points <- expand.grid(x1 = c(-1, -0.5, 0, 0.5, 1),
                           x2 = c(-1, -0.5, 0, 0.5, 1))
grid_points$spv <- rep(3, 25)
optimal_point <- data.frame('x1' = -1, 'x2'= -1, 'spv' = 3)

grid_points <- rbind(grid_points, optimal_point)

# Add a new column to indicate the special point
grid_points$special <- FALSE
grid_points[which(grid_points$x1 == optimal_point$x1 & grid_points$x2 == optimal_point$x2), "special"] <- TRUE
grid_points

# Create a ggplot object

ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits = c(3, 18)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "Quartic RSM Model, K=2, N=12") +
  xlab("Factor 1")+ylab("Factor 2")+
  scale_x_continuous(breaks = seq(-1, 1, by = 0.5)) +
  scale_y_continuous(breaks = seq(-1, 1, by = 0.5)) +
  # Can make a vector outside the original dataset that has some information
  # about points to be plotted...
  geom_point(data = grid_points[grid_points$special == FALSE,],
             aes(x = x1, y = x2, color = special), size = 2.5, show.legend = FALSE,
             pch=21, stroke = 1.5, fill = "yellow2") +

  geom_point(data = grid_points[grid_points$special == TRUE,],
             aes(x = x1, y = x2, color = special),
             show.legend = FALSE,
             size=8,
             alpha = 1,
             pch=4,
             stroke=2.5)+

  scale_color_manual(values = c("red", "red"))+
  theme(legend.position="bottom", legend.key.width = unit(1.5, "cm"))

#theme(axis.text = element_blank(),
#     axis.title = element_blank(),
#    axis.ticks = element_blank())
