library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)

setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")
data <- read.csv("borkowski_cases/K=2_N=8.csv")
designs <- read.csv("borkowski_cases/designs/K=2_N=8_designs.csv", header=FALSE)
data <- read.csv("point_exchange/data/k2n8_pexch_mod_efficiencies.csv")
designs <- read.csv("point_exchange/data/k2n8_pexch_mod_designs.csv", header = FALSE)

#designs <- read.csv("error_quantification_data/k2n10_trial36.csv", header = FALSE)

spvs <- data$Var2[data$Var2 != 0]
location = which.min(spvs) #270
spvs[location]
design <- designs[(location*2-1):(location*2)]

n=8
num_entries <- n*2

#design <- designs[((location-1)*num_entries+1) : (location*num_entries)]
#design <- as.numeric(designs[33,1 : 20])
design <- matrix(unname(unlist(design)), byrow = FALSE, ncol=2)

k2_quadratic <- function(x1, x2){
  mm <- matrix(c(rep(1, n), design[,1], design[,2],
                 design[,1]*design[,2],
                 design[,1]^2, design[,2]^2),
               nrow = n, ncol = 6, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2)
  return(n*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

k2_cubic <- function(x1, x2){
  mm <- matrix(c(rep(1, n), design[,1], design[,2],
                 design[,1]*design[,2],
                 design[,1]^2, design[,2]^2,
                 design[,1]^3, design[,2]^3),
               nrow = n, ncol = 8, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2, x1^3, x2^3)
  return(n*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

k2_quartic <- function(x1, x2){
  mm <- matrix(c(rep(1, n), design[,1], design[,2],
                 design[,1]^2, design[,2]^2,
                 design[,1]^3, design[,2]^3,
                 design[,1]^4, design[,2]^4),
               nrow = n, ncol = 9, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1^2, x2^2, x1^3, x2^3, x1^4, x2^4)
  return(n*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

# Generates the plotting data given any polynomial
data_generator <- function(polynomial, interval){
  sequence <- seq(-1, 1, interval)
  data <- expand.grid(sequence, sequence)
  data$spv <- apply(data, 1, function(row) polynomial(row[1], row[2]))
  return(data)
}

# Generate the data for this case
data <- data_generator(k2_quadratic, 0.01)
design_points <- data.frame(x1 = design[,1],
                            x2 = design[,2])
design_points$spv <- rep(3, n)


ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits=c(2, 7)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "") +
  xlab("Factor 1 Level")+ylab("Factor 2 Level")+
  scale_x_continuous(breaks = seq(-1, 1, by = 0.5)) +
  scale_y_continuous(breaks = seq(-1, 1, by = 0.5)) +
  # Can make a vector outside the original dataset that has some information
  # about points to be plotted...
  geom_point(data = design_points,
             aes(x = x1, y = x2, color="red"), size = 3.5, show.legend = FALSE,
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

