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
# This function to

# To store the matrices:


test <- read.csv("k2n10_trial1.csv")

for (i in 1:nrow(test)){

}
nrow(test)





