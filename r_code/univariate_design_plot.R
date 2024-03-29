setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")
library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)
library(reshape2)


k5 <- read.csv("extension_functions/higher_order_data/gloptipoly_k1n5.csv")
k6 <- read.csv("extension_functions/higher_order_data/gloptipoly_k1n6.csv")
k5_designs <- read.csv("extension_functions/higher_order_data/gloptipoly_k1n5_designs.csv", header = FALSE)
k6_designs <- read.csv("extension_functions/higher_order_data/gloptipoly_k1n6_designs.csv", header = FALSE)

which.min(k5$Var2) # Index Number 89
min(k5$Var2) # Max SPV of 4.68
k5_designs[446:450]
k5_opt <- c(-0.69078, 1, -0.000219, 0.69109, -1)


which.min(k6$Var2) # Index Number 29
min(k6$Var2) # Max SPV of 4.77
k6_designs[175:180]
k6_opt <- c(1, -1, 0.3679, 0.82966, -0.82952, -0.36745)

# This function is used to generate data for the SPV polynomial resulting from
# our proposed optimal design for a cubic RSM model in one variable
k5_cubic <- function(x){
  mm <- matrix(c(rep(1, 5), k5_opt, k5_opt^2, k5_opt^3),
                         nrow = 5, ncol = 4, byrow = FALSE)
  x_vec <- c(1, x, x^2, x^3)
  return(5*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

k6_cubic <- function(x){
  mm <- matrix(c(rep(1, 6), k6_opt, k6_opt^2, k6_opt^3),
               nrow = 6, ncol = 4, byrow = FALSE)
  x_vec <- c(1, x, x^2, x^3)
  return(6*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

# Generates the plotting data given any polynomial
data_generator <- function(polynomial, gap){
  inputs<- seq(-1, 1, gap)
  spv <- lapply(inputs, polynomial)
  data <- data.frame(inputs, unlist(spv))
  colnames(data) <- c("x", "SPV")
  return(data)
}

k5_data <- data_generator(k6_cubic, 0.01)
grid_points <- c(-1, -0.5, 0, 0.5, 1)


ggplot(k5_data, aes(x = x, y = SPV)) +
  geom_line(color = "blue", size = 1.25) +
  geom_point(data = data.frame(x = grid_points, y = unlist(lapply(grid_points, k6_cubic))),
             aes(x = x, y = y, color="red"), size = 3.5, show.legend = FALSE,
             pch=21, stroke = 1.5, fill = "yellow2") +
  scale_color_manual(values = c("red", "red")) +
  # Add any additional styling or customization as needed
  labs(title = "",
       x = "X",
       y = "SPV")+
  theme(
    axis.title.x = element_text(size = 20),
    axis.title.y = element_text(size = 20),
    axis.text.x = element_text(size = 16),
    axis.text.y = element_text(size = 16),
    plot.title = element_text(size = 20)
  )






