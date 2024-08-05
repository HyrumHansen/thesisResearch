setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch/extension_functions")
library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)


### K9 Cubic Plot ###

k9_cubic <- read.csv("higher_order_data/gloptipoly_k2n9_cubic.csv")
k9_cubic_designs <- read.csv("higher_order_data/gloptipoly_k2n9_cubic_designs.csv", header = FALSE)
ind <- which.min(k9_cubic$Var2)
k9_opt <- matrix(
  unname(unlist(k9_cubic_designs[(ind*18-18+1):(ind*18)])),
  ncol = 2,
  nrow = 9,
  byrow = FALSE
)


cubic <- function(x1, x2, k, design){
  mm <- matrix(c(rep(1, k), design[,1], design[,2],
                 design[,1]*design[,2], design[,1]^2, design[,2]^2,
                 design[,1]^3, design[,2]^3),
               nrow = k, ncol = 8, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2, x1^3, x2^3)
  return(k*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}


# Generates the plotting data given any polynomial
data_generator <- function(polynomial, interval, k, design){
  sequence <- seq(-1, 1, interval)
  data <- expand.grid(sequence, sequence)
  data$spv <- apply(data, 1, function(row) polynomial(row[1], row[2], k, design))
  return(data)
}

data <- data_generator(cubic, 0.01, 9, k9_opt)
grid_points <- data.frame(x1 = k9_opt[,1],
                          x2 = k9_opt[,2])
grid_points$spv <- rep(3, nrow(grid_points))


# Create a ggplot object
ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits = c(4, 12)) +  # Color gradient
  
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

### K10 Cubic Plot ###

k10_cubic <- read.csv("higher_order_data/gloptipoly_k2n10_cubic.csv")
k10_cubic_designs <- read.csv("higher_order_data/gloptipoly_k2n10_cubic_designs.csv", header = FALSE)
ind <- which.min(k10_cubic$Var2)
k10_opt <- matrix(
  unname(unlist(k10_cubic_designs[(ind*20-20+1):(ind*20)])),
  ncol = 2,
  nrow = 10,
  byrow = FALSE
)

data <- data_generator(cubic, 0.01, 10, k10_opt)
grid_points <- data.frame(x1 = k10_opt[,1],
                          x2 = k10_opt[,2])
grid_points$spv <- rep(3, nrow(grid_points))


# Create a ggplot object
ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits = c(5, 11)) +  # Color gradient
  
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


### K9 Interactions Plot ###

k9_int <- read.csv("higher_order_interaction_data/gloptipoly_k2n9.csv")
k9_int_designs <- read.csv("higher_order_interaction_data/gloptipoly_k2n9_designs.csv", header = FALSE)
ind <- which.min(k9_int$Var2)
k9_opt <- matrix(
  unname(unlist(k10_cubic_designs[(ind*18-18+1):(ind*18)])),
  ncol = 2,
  nrow = 9,
  byrow = FALSE
)

second_interaction <- function(x1, x2, k, design){
  mm <- matrix(c(rep(1, k), design[,1], design[,2],
                 design[,1]*design[,2], design[,1]^2, design[,2]^2,
                 design[,1]^2*design[,2], design[,1]*design[,2]^2),
               nrow = k, ncol = 8, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2, x1^2*x2, x1*x2^2)
  return(k*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

data <- data_generator(second_interaction, 0.01, 9, k9_opt)
grid_points <- data.frame(x1 = k10_opt[,1],
                          x2 = k10_opt[,2])
grid_points$spv <- rep(3, nrow(grid_points))


# Create a ggplot object
ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits = c(3, 9)) +  # Color gradient
  
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

### K10 Interactions Plot ###

k10_int <- read.csv("higher_order_interaction_data/gloptipoly_k2n10.csv")
k10_int_designs <- read.csv("higher_order_interaction_data/gloptipoly_k2n10_designs.csv", header = FALSE)
ind <- which.min(k10_int$Var2)
k10_opt <- matrix(
  unname(unlist(k10_int_designs[(ind*20-20+1):(ind*20)])),
  ncol = 2,
  nrow = 10,
  byrow = FALSE
)

data <- data_generator(second_interaction, 0.01, 10, k10_opt)
grid_points <- data.frame(x1 = k10_opt[,1],
                          x2 = k10_opt[,2])
grid_points$spv <- rep(3, nrow(grid_points))


# Create a ggplot object
ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits = c(3, 10)) +  # Color gradient
  
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
