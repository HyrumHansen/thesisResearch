setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")
library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)
library(reshape2)


#k9 <- read.csv("borkowski_cases/K=1_N=5.csv")[,1:2]
#k10 <- read.csv("borkowski_cases/K=1_N=6.csv")[,1:2]

k9 <- read.csv("extension_functions/higher_order_data/gloptipoly_k3n14_quartic.csv")
k10 <- read.csv("extension_functions/higher_order_data/gloptipoly_k3n15_quartic.csv")

k9$abs_efficiency <- 1300/k9['Var2']
k10$abs_efficiency <- 1300/k10['Var2']

colnames(k9) <- c("Trial", "Max SPV", "abs_eff")
colnames(k10) <- c("Trial", "Max SPV", "abs_eff")

efficiencies <- data.frame(c(
  k9$abs_eff,
  k10$abs_eff
))

colnames(efficiencies) <- c("N=14", "N=15")

ggplot(data = melt(efficiencies),
       aes(x=variable, y=value)) +
  geom_boxplot(color = 'blue',
               outlier.color="black",
               alpha = 0.4) +
  ggtitle("Three Factor Quartic Model") +
  theme(legend.position="none") +
  xlab("Number of Trials") +
  ylab("Absolute Efficiency (%)")+
  coord_cartesian(ylim = c(0, 70))

