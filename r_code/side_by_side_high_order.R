setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")
library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)
library(reshape2)


k9 <- read.csv("extension_functions/higher_order_data/gloptipoly_k1n5.csv")
k10 <- read.csv("extension_functions/higher_order_data/gloptipoly_k1n6.csv")

k9$abs_efficiency <- 400/k9['Var2']
k10$abs_efficiency <- 400/k10['Var2']

colnames(k9) <- c("Trial", "Max SPV", "abs_eff")
colnames(k10) <- c("Trial", "Max SPV", "abs_eff")

efficiencies <- data.frame(c(
  k9$abs_eff,
  k10$abs_eff
))

colnames(efficiencies) <- c("N=5", "N=6")

ggplot(data = melt(efficiencies),
       aes(x=variable, y=value)) +
  geom_boxplot(color = 'blue',
               outlier.color="black",
               alpha = 0.4) +
  ggtitle("Absolute Efficiencies for One-Factor, Cubic Model") +
  theme(legend.position="none") +
  geom_hline(yintercept = 100, color = 'red') +
  xlab("Number of Trials") +
  ylab("Absolute Efficiency (%)")+
  coord_cartesian(ylim = c(55, 100))
