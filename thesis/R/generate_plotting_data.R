############################
## Generate Plotting Data ##
############################

# Generate the model vector
f_x_2 <- function(x1, x2){
  return(c(1, x1, x2, x1*x2, x1^2, x2^2))
}

# Expand the design matrix to a model matrix
expand_quadratic <- function(design){
  return(matrix(
    data = c(
      c(rep(1, nrow(design))), # Intercept term
      c(design[,1]), #x1 variable
      c(design[,2]), #x2 variable
      c(design[,1]*design[,2]), # Interaction term
      c(design[,1]^2), # Second order, first variable
      c(design[,2]^2) # Second order, second variable
    ),
    ncol = 6,
    byrow = FALSE
  ))
}

# Compute the SPV given a design
compute_spv <- function(design, model_vec, model_mat){
  N <- nrow(design)
  spv <- N*model_vec%*%solve(t(model_mat)%*%model_mat)*model_vec
  return(spv)
}

# Generate all the data for the plot using only
# the design as input
gen_data <- function(design){

  sequence <- seq(-1, 1, 0.01)
  inputs <- expand.grid(sequence, sequence)
  spvs <- rep(0, nrow(inputs))

  for(row in 1:nrow(inputs)){
    model_vector <- f_x_2(inputs[row, 1], inputs[row, 2])
    model_matrix <- expand_quadratic(design)
    spvs[row] <- compute_spv(design, model_vector, model_matrix)
  }

  return(spvs)
}

designs <- read.csv("thesis/data/designs/K=2_N=9_designs.csv", header=FALSE)
data <- read.csv("thesis/data/K=2_N=9.csv")

which.min(data$Var2)
design <- designs[,175:176]
design <- matrix(
  data = c(
    c(design[,1]),
    c(design[,2])
  ),
  ncol = 2,
  byrow = FALSE
)
plotting_data <- gen_data(design)




# Generate the data for this case
k2n9_data <- data_generator(newdata, 0.01)
grid_points <- expand.grid(x1 = c(-1, -0.5, 0, 0.5, 1),
                           x2 = c(-1, -0.5, 0, 0.5, 1))
grid_points$spv <- rep(3, 25)
optimal_point <- data.frame('x1' = -1, 'x2'= -0.1772, 'spv' = 3)

grid_points <- rbind(grid_points, optimal_point)

# Add a new column to indicate the special point
grid_points$special <- FALSE
grid_points[which(grid_points$x1 == optimal_point$x1 & grid_points$x2 == optimal_point$x2), "special"] <- TRUE

# Create a ggplot object

ggplot(data = k2n9_data, aes(x = Var1, y = Var2, fill = spv)) +
  geom_tile() +
  scale_fill_viridis(option="G") +  # Color gradient

  ### Put the legend for this plot on the bottom!
  labs(title = "") +
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
             size=5,
             alpha = 1,
             pch=4,
             stroke=2.5)+

  scale_color_manual(values = c("red", "red"))+
  theme(axis.text = element_blank(),
        axis.title = element_blank(),
        axis.ticks = element_blank())
