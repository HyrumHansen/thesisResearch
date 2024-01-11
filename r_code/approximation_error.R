library(ggplot2)

## Script to do the approximation error study ##
setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch/error_quantification_data")

# Each trial will be one substructure in this list
k2n10 <- list()
for (i in 1:100){
  filename <- sprintf("k2n10_trial%d.csv", i)
  dat <- read.csv(filename)
  k2n10[[paste0("trial_", i)]] <- dat$fval
}

# Get a list of the number of iterations it takes to converge
convergence_data <- rep(0, 100)
for (i in 1:100){
  datname <- sprintf("trial_%d", i)
  dataset <- k2n10[[datname]]
  convergence_data[i] <- length(dataset)
}

# Plot the distribution of iterations to convergence
# for all the runs of Nelder-Mead
ggplot(data.frame(y = convergence_data), aes(y = y)) +
  geom_boxplot(color = "blue", alpha = 0.7, width = 0.15) +
  labs(title = "Convergence Distribution for 100 Runs of Nelder Mead",
       x = "K=2, N=10",
       y = "Iterations to Converge")+
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())

# Now we need to re-score the designs and compute approximation error

# Helper function to compute SPV
compute_spv <- function(x1, x2, mm){
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2)
  return(10*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

# This function to approximate G-efficiency
approximate_g <- function(my_design){

  # Build the model matrix
  mm <- matrix(c(rep(1, 10), my_design[,1], my_design[,2],
                 my_design[,1]*my_design[,2], my_design[,1]^2, my_design[,2]^2),
               nrow = 10, ncol = 6, byrow = FALSE)
  sequence <- seq(-1, 1, 0.5)
  evaluation_data <- expand.grid(sequence, sequence)
  spvs <- apply(evaluation_data, 1, function(row) compute_spv(row[1], row[2], mm))
  return(max(spvs))
}

# To store the data we are about to gather:
data = list()
for (j in 1:100){
  filename <- sprintf("k2n10_trial%d.csv", j)
  curr_data <- read.csv(filename)

  curr_approx <- rep(0, nrow(curr_data))
  curr_glopt <- unname(unlist(curr_data[21]))

  for (i in 1:nrow(curr_data)){
    values <- unname(unlist(curr_data[i,]))[1:20]
    current_design <- matrix(values, ncol = 2, nrow = 10, byrow = FALSE)
    curr_approx[i] <- approximate_g(current_design)
  }

  error <- abs(curr_approx - curr_glopt)

  data[[j]] <- data.frame('approximation' = curr_approx,
                          'gloptipoly' = curr_glopt,
                          'absolute error' = error)
}

# To store the average error across all time steps
avg_error <- rep(0, 100)
for (i in 1:100){
  avg_error[i] <- mean(unname(unlist(data[[i]]['absolute.error'])))
}

# Average error boxplot
# Create a boxplot using ggplot2 for the third column (Column3)
# Create a boxplot using ggplot2
ggplot() +
  geom_boxplot(aes(y = avg_error), color = "blue") +
  labs(title = "Boxplot of Average Approximation Error",
       y = "Absolute Error") +
  theme(axis.text.x = element_blank(),
        axis.ticks.x = element_blank())




