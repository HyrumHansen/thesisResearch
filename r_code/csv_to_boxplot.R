setwd("C:/Program Files/MATLAB/Thesis")
library(ggplot2)
library(ggthemes)
library(tidyr)

trial <- read.csv("trial_run_csvs/k_1_n_8.csv", header = FALSE)
efficiencies <- rep(0, length(trial))

for(i in 1:length(trial)){
  efficiencies[i] = trial[[i]]
}


abs_efficiency <- 100*3/efficiencies
rel_efficiency <- 100*abs_efficiency/89.12588

data = data.frame("Absolute Efficiency" = abs_efficiency,
                  "Relative Efficiency" = rel_efficiency)
colnames(data) <- c("Absolute Efficiency", "Relative Efficiency")

data_long <- tidyr::gather(data, key = "Group", value = "Value")

# Create side-by-side boxplots using ggplot2
ggplot(data_long, aes(x = Group, y = Value, fill = Group)) +
  geom_boxplot() +
  labs(title = "Absolute and Relative Efficiencies", x = "Group", y = "Percent",
       labels = c("Absolute Efficiency", "Relative Efficiency")) +
  scale_fill_manual(values = c("blue", "green")) +
  theme_classic()
