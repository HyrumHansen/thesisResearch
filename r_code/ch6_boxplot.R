library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)

setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")

# List of results for all that sweet sweet PSO goodness
n10_pso <- 1000/read.csv("pso_data/K=3_N=10.csv")$Var2/70.38*100
n11_pso <- 1000/read.csv("pso_data/K=3_N=11.csv")$Var2/79.54*100
n12_pso <- 1000/read.csv("pso_data/K=3_N=12.csv")$Var2/83.12*100
n13_pso <- 1000/read.csv("pso_data/K=3_N=13.csv")$Var2/85.81*100
n14_pso <- 1000/read.csv("pso_data/K=3_N=14.csv")$Var2/89.09*100
n15_pso <- 1000/read.csv("pso_data/K=3_N=15.csv")$Var2/85.77*100
n16_pso <- 1000/read.csv("pso_data/K=3_N=16.csv")$Var2/85.39*100

# Some tender Nelder-Mead trials
n10_nm <- 1000/read.csv("borkowski_cases/K=3_N=10.csv")$Var2/70.38*100
n11_nm <- 1000/read.csv("borkowski_cases/K=3_N=11.csv")$Var2/79.54*100
n12_nm <- 1000/read.csv("borkowski_cases/K=3_N=12.csv")$Var2/83.12*100
n13_nm <- 1000/read.csv("borkowski_cases/K=3_N=13.csv")$Var2/85.81*100
n14_nm <- 1000/read.csv("borkowski_cases/K=3_N=14.csv")$Var2/89.09*100
n15_nm <- 1000/read.csv("borkowski_cases/K=3_N=15.csv")$Var2/85.77*100
n16_nm <- 1000/read.csv("borkowski_cases/K=3_N=16.csv")$Var2/85.39*100

# Combine the lists into data frames
pso_data <- data.frame(
  N = rep(c(10, 11, 12, 13, 14, 15, 16), times = c(15, 15, 15, 15, 15, 20, 15)),
  Value = unlist(list(n10_pso, n11_pso, n12_pso, n13_pso, n14_pso, n15_pso, n16_pso)),
  Type = rep("PSO", each = 110)
)

nm_data <- data.frame(
  N = rep(c(10, 11, 12, 13, 14, 15, 16), each = 500),
  Value = c(n10_nm, n11_nm, n12_nm, n13_nm, n14_nm, n15_nm, n16_nm),
  Type = rep("Nelder-Mead", each = 500)
)

# Combine both data frames
all_data <- rbind(pso_data, nm_data)

# Create the paired boxplot with ggplot2
ggplot(all_data, aes(x = as.factor(N), y = Value, color = Type)) +
  geom_boxplot(position = position_dodge(width = 0.8),
               width = 0.7,
               fill = alpha("white", 0.7),
               outlier.shape = 16,
               outlier.color = "black",
               outlier.alpha = 0.6
               )+
  geom_hline(yintercept = 100,
             linetype = "dashed",
             color = "red") +
  labs(
    x = "Number of Observations (N)",
    y = "Relative EFficiencies",
    title = "Nelder-Mead vs. PSO, K=3") +
  ylim(c(50, 103)) +
  scale_color_manual(values = c("PSO" = "blue", "Nelder-Mead" = "red"))+
  guides(color=guide_legend(title="Algorithm"))
