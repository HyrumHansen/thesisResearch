setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")
library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)

walsh_data <- read.csv("C:/Users/Hyrum Hansen/Documents/thesisResearch/walsh_data.csv")

data <- read.csv("extension_functions/higher_order_interaction_data/gloptipoly_k2n9.csv")

which.min(data$Var2)
designs[,175:176]

newdata <- function(x1, x2){
  # output <- 7.176-0.00090306*x1-0.0036827*x2-4.8143*x1^2-0.0021569*x1*x2-7.0279*x2^2+0.0008749*x1^3-0.11978*x1^2*x2-0.00089081*x1*x2^2+0.62264*x2^3+5.4149*x1^4-0.0033561*x1^3*x2-5.1694*x1^2*x2^2+0.0083398*x1*x2^3+5.8129*x2^4+0.0022603*x1^3*x2^2-0.49339*x1^2*x2^3-0.0041706*x1*x2^4+6.3789*x1^2*x2^4
  output <- 5.2634+0.2179*x1+0.025425*x2+22.0355*x1^2+0.29951*x1*x2-6.2893*x2^2-1.3326*x1^3-0.1943*x1^2*x2+0.038514*x1*x2^2-0.0078837*x2^3-51.3549*x1^4-0.36778*x1^3*x2-0.43146*x1^2*x2^2-0.18331*x1*x2^3+6.4569*x2^4+1.1157*x1^5+0.38724*x1^4*x2+0.15668*x1^3*x2^2+32.2236*x1^6
  return(output)
  }

# Walsh K2 N9 design
k2n9_walsh <- function(x1, x2){
  output <- 6.0602-0.00013556*x1-5.2163e-05*x2-5.7282*x1^2+3.0425e-07*x1*x2-5.7282*x2^2+5.6317e-05*x1^3+8.4063e-06*x1^2*x2+7.9174e-05*x1*x2^2+4.3809e-05*x2^3+6.5937*x1^4+2.418*x1^3*x2-0.86544*x1^2*x2^2-2.418*x1*x2^3+6.5937*x2^4
  return(output)
}

# Gloptipoly worst design spv polynomials
k2n8_worst_candidate <- function(x1, x2){
  output <- 3.3162+0.035034*x1+0.49775*x2-3.6463*x1^2+0.74947*x1*x2-2.1451*x2^2+0.060101*x1^3+0.69889*x1^2*x2+0.98466*x1*x2^2-0.14828*x2^3+8.2948*x1^4-1.1279*x1^3*x2-5.4265*x1^2*x2^2-0.74874*x1*x2^3+6.5334*x2^4
  return(output)
}


# Gloptipoly optimal design spv polynomials
k2n8_generator <- function(x1, x2){
  output <- 5.1542-0.044881*x1+0.28866*x2-5.136*x1^2+0.038628*x1*x2-5.1639*x2^2-0.072588*x1^3+0.34401*x1^2*x2+0.11723*x1*x2^2-0.6329*x2^3+4.379*x1^4-0.27834*x1^3*x2+1.2822*x1^2*x2^2+0.23921*x1*x2^3+4.6423*x2^4
  return(output)
}

k2n9_generator <- function(x1, x2){
  # This is the Walsh 2022 Design
  output <- 6.0602-0.00013556*x1-5.2163e-05*x2-5.7282*x1^2+3.0425e-07*x1*x2-5.7282*x2^2+9.6108e-05*x1^3+3.6791e-05*x1^2*x2+3.9384e-05*x1*x2^2+1.5424e-05*x2^3+6.5937*x1^4-2.418*x1^3*x2-0.86544*x1^2*x2^2+2.418*x1*x2^3+6.5937*x2^4
  return(output)
}

k2n9_random <- function(x1, x2){
  output <- 4.2881+13.1077*x1-11.8626*x2+0.38899*x1^2+1.3686*x1*x2+13.026*x2^2-115.2076*x1^3+272.7876*x1^2*x2-224.5485*x1*x2^2+175.1024*x2^3+129.7147*x1^4-455.7936*x1^3*x2+635.567*x1^2*x2^2-384.8339*x1*x2^3+218.0369*x2^4
  return(output)
}

k2_n8_random <- function(x1, x2){
  #output <- 14.5205+17.7508*x1+1.2548*x2-21.0577*x1^2+2.4469*x1*x2-40.0605*x2^2-10.5113*x1^3+2.0172*x1^2*x2-36.7294*x1*x2^2-0.088564*x2^3+30.3567*x1^4+14.6732*x1^3*x2+30.2462*x1^2*x2^2-17.1491*x1*x2^3+47.4628*x2^4
  #output <- 3.6135+1.3976*x1-2.4961*x2+1.594*x1^2+5.3961*x1*x2+2.8867*x2^2+1.8708*x1^3+53.4317*x1^2*x2+16.4792*x1*x2^2-0.65625*x2^3+26.0377*x1^4+11.9708*x1^3*x2+19.4627*x1^2*x2^2+6.7666*x1*x2^3+7.4691*x2^4
  output <- 2.8602+17.3137*x1+6.4421*x2+81.559*x1^2+47.3534*x1*x2+11.4916*x2^2+99.7287*x1^3+53.7175*x1^2*x2-37.8471*x1*x2^2+46.9807*x1^4+12.8947*x1^3*x2-348.5411*x1^2*x2^2-116.0812*x1*x2^3-252.8298*x1^3*x2^2-42.5948*x1^2*x2^3+429.0452*x1^2*x2^4
  return(output)
}

# Generates the plotting data given any polynomial
data_generator <- function(polynomial, interval){
  sequence <- seq(-1, 1, interval)
  data <- expand.grid(sequence, sequence)
  data$spv <- polynomial(data[,1], data[,2])
  return(data)
}

# Generate the data for this case
k2n9_data <- data_generator(k2n9_generator, 0.01)
grid_points <- expand.grid(x1 = c(-1, -0.5, 0, 0.5, 1),
                      x2 = c(-1, -0.5, 0, 0.5, 1))
grid_points$spv <- rep(3, 25)
optimal_point <- data.frame('x1' = -.1772, 'x2'= -1, 'spv' = 3)

grid_points <- rbind(grid_points, optimal_point)

# Add a new column to indicate the special point
grid_points$special <- FALSE
grid_points[which(grid_points$x1 == optimal_point$x1 & grid_points$x2 == optimal_point$x2), "special"] <- TRUE

# Create a ggplot object

ggplot(data = k2n9_data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G") +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "G-Optimal Design of Walsh & Borkowski (2022), K=2, N=9") +
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

