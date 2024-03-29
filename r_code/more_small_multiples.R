library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)
library(patchwork)

k2_quadratic <- function(x1, x2){
  mm <- matrix(c(rep(1, n), design[,1], design[,2],
                 design[,1]*design[,2],
                 design[,1]^2, design[,2]^2),
               nrow = n, ncol = 6, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2)
  return(n*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")


#Nelder-Mead
n=9
num_entries <- n*2
data <- read.csv("borkowski_cases/K=2_N=9.csv")
designs <- read.csv("borkowski_cases/designs/K=2_N=9_designs.csv", header=FALSE)
spvs <- data$Var2[data$Var2 != 0]
location = which.min(spvs) #270
spvs[location]
design <- designs[(location*2-1):(location*2)]
design <- matrix(unname(unlist(design)), byrow = FALSE, ncol=2)

# Generate the data for this case
data <- data_generator(k2_quadratic, 0.01)
design_points <- data.frame(x1 = design[,1],
                            x2 = design[,2])
design_points$spv <- rep(3, n)


nm9 <- ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits=c(2, 7.2)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "Nelder-Mead, 9-Trials") +
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
    legend.position = "none",
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 12),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 14)
  )

#Nelder-Mead
n=10
num_entries <- n*2
data <- read.csv("borkowski_cases/K=2_N=10.csv")
designs <- read.csv("borkowski_cases/designs/K=2_N=10_designs.csv", header=FALSE)
spvs <- data$Var2[data$Var2 != 0]
location = which.min(spvs) #270
spvs[location]
design <- designs[(location*2-1):(location*2)]
design <- matrix(unname(unlist(design)), byrow = FALSE, ncol=2)

# Generate the data for this case
data <- data_generator(k2_quadratic, 0.01)
design_points <- data.frame(x1 = design[,1],
                            x2 = design[,2])
design_points$spv <- rep(3, n)


nm10 <- ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits=c(2, 7.2)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "Nelder-Mead, 10-Trials") +
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
    legend.position = "none",
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 12),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 14)
  )
nm10


#Nelder-Mead
n=11
num_entries <- n*2
data <- read.csv("borkowski_cases/K=2_N=11.csv")
designs <- read.csv("borkowski_cases/designs/K=2_N=11_designs.csv", header=FALSE)
spvs <- data$Var2[data$Var2 != 0]
location = which.min(spvs) #270
spvs[location]
design <- designs[(location*2-1):(location*2)]
design <- matrix(unname(unlist(design)), byrow = FALSE, ncol=2)

# Generate the data for this case
data <- data_generator(k2_quadratic, 0.01)
design_points <- data.frame(x1 = design[,1],
                            x2 = design[,2])
design_points$spv <- rep(3, n)


nm11 <- ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits=c(2, 7.2)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "Nelder-Mead, 11-Trials") +
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
    legend.position = "none",
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 12),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 14)
  )
nm11



#PSO
data <- read.csv("pso_data/K=2_N=9.csv")
designs <- read.csv("pso_data/K=2_N=9_designs.csv", header=FALSE)
n=9
num_entries <- n*2
spvs <- data$Var2[data$Var2 != 0]
location = which.min(spvs) #270
spvs[location]
design <- designs[(location*2-1):(location*2)]
design <- designs[(location*2-1):(location*2)]
design <- matrix(unname(unlist(design)), byrow = FALSE, ncol=2)

# Generate the data for this case
data <- data_generator(k2_quadratic, 0.01)
design_points <- data.frame(x1 = design[,1],
                            x2 = design[,2])
design_points$spv <- rep(3, n)


pso9 <- ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits=c(2, 7)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "PSO") +
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
    legend.position = "none",
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 12),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 14)
  )
pso9

#PSO10
data <- read.csv("pso_data/K=2_N=10.csv")
designs <- read.csv("pso_data/K=2_N=10_designs.csv", header=FALSE)
n=10
num_entries <- n*2
spvs <- data$Var2[data$Var2 != 0]
location = which.min(spvs) #270
spvs[location]
design <- designs[(location*2-1):(location*2)]
design <- designs[(location*2-1):(location*2)]
design <- matrix(unname(unlist(design)), byrow = FALSE, ncol=2)

# Generate the data for this case
data <- data_generator(k2_quadratic, 0.01)
design_points <- data.frame(x1 = design[,1],
                            x2 = design[,2])
design_points$spv <- rep(3, n)


pso10 <- ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits=c(2, 7)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "PSO") +
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
    legend.position = "none",
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 12),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 14)
  )
pso10


data <- read.csv("pso_data/K=2_N=11.csv")
designs <- read.csv("pso_data/K=2_N=11_designs.csv", header=FALSE)
n=11
num_entries <- n*2
spvs <- data$Var2[data$Var2 != 0]
location = which.min(spvs) #270
spvs[location]
design <- designs[(location*2-1):(location*2)]
design <- designs[(location*2-1):(location*2)]
design <- matrix(unname(unlist(design)), byrow = FALSE, ncol=2)

# Generate the data for this case
data <- data_generator(k2_quadratic, 0.01)
design_points <- data.frame(x1 = design[,1],
                            x2 = design[,2])
design_points$spv <- rep(3, n)


pso11 <- ggplot(data = data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits=c(2, 7)) +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "PSO") +
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
    legend.position = "none",
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 12),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 14)
  )
pso11


# Remove y-axis labels from the right column plots
pso9 <- pso9 + theme(axis.title.y = element_blank())
pso10 <- pso10 + theme(axis.title.y = element_blank())
pso11 <- pso11 + theme(axis.title.y = element_blank())

# Remove x-axis labels from the top and middle row plots
nm9 <- nm9 + theme(axis.title.x = element_blank())
pso9 <- pso9 + theme(axis.title.x = element_blank())
nm10 <- nm10 + theme(axis.title.x = element_blank())
pso10 <- pso10 + theme(axis.title.x = element_blank())





grid <- (nm9 / nm10 / nm11) |
  (pso9 / pso10 / pso11) +
  plot_layout(axis_titles = "collect",
              guides = "collect") +
  theme(legend.position = "right",
        legend.key.size = unit(2, "lines"))

# Print the grid
print(grid)



