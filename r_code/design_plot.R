walsh_data <- read.csv("C:/Users/Hyrum Hansen/Documents/thesisResearch/walsh_data.csv")
designs <- read.csv("C:/Users/Hyrum Hansen/Downloads/k2n7_pso.csv", header=FALSE)

which.min(data$Var2)
#design <- designs[,25:26]
design <- matrix(c(0.9999999993089373, -0.6125262285631338, 0.9999560209028107,
                   0.9248716818163063, 0.02579112530493838, 0.7724882023644585, 
                   -1.0, 1.0, -0.7738216286478816, -0.03485346832916485,
                   -0.9523909201350965, -1.0, 0.5943031952945398, -0.9999999754292527),
                   byrow = TRUE, ncol=2)



# Walsh K2 N9 design
k2n9_walsh <- function(x1, x2){
  output <- 7.4777-0.12438*x1-0.035237*x2-7.7536*x1^2+1.1467*x1*x2-8.0111*x2^2+0.12439*x1^3-0.033192*x1^2*x2+0.20596*x1*x2^2+0.035238*x2^3+7.7536*x1^4-0.71322*x1^3*x2-0.26839*x1^2*x2^2-0.46276*x1*x2^3+8.0111*x2^4
  return(output)
}

k2n9_generator <- function(x1, x2){
  output <- 7.5724+0.44843*x1-0.25712*x2-7.5147*x1^2-1.0301*x1*x2-8.5573*x2^2+0.12176*x1^3+1.0204*x1^2*x2-0.56776*x1*x2^2-0.76574*x2^3+6.9499*x1^4+0.6059*x1^3*x2+1.4986*x1^2*x2^2+0.51859*x1*x2^3+7.5381*x2^4
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
k2n9_data <- data_generator(k2n9_walsh, 0.01)
design_points <- data.frame(x1 = design[,1],
                            x2 = design[,2])
design_points$spv <- rep(3, 7)


ggplot(data = k2n9_data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G", limits=c(2.9, 8)) +  # Color gradient
  
  ### Put the legend for this plot on the bottom!
  labs(title = "SPV Surface and Experimental Design Points for\nWalsh (2022) Proposed Design, K=2, N=7") +
  xlab("Factor 1 Level")+ylab("Factor 2 Level")+
  scale_x_continuous(breaks = seq(-1, 1, by = 0.5)) +
  scale_y_continuous(breaks = seq(-1, 1, by = 0.5)) +
  # Can make a vector outside the original dataset that has some information
  # about points to be plotted...
  geom_point(data = design_points, 
             aes(x = x1, y = x2, color="red"), size = 3.5, show.legend = FALSE,
             pch=21, stroke = 1.5, fill = "yellow2") +
  scale_color_manual(values = c("red", "red")) +
  theme(legend.position="bottom")

