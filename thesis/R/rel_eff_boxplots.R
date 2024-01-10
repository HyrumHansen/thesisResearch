library(ggplot2)
library(ggthemes)
library(tidyr)
library(reshape2)

setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch")
walsh_data <- data.frame(read.csv("walsh_data.csv"))
colnames(walsh_data) <- c("K", "N", "Absolute Efficiency", "Design")

k1n3 <- data.frame(read.csv("borkowski_cases/K=1_N=3.csv"))
k1n3$rel_efficiency <- (300/k1n3['Var2'])/walsh_data$`Absolute Efficiency`[1]*100
k1n4 <- data.frame(read.csv("borkowski_cases/K=1_N=4.csv"))
k1n4$rel_efficiency <- (300/k1n4['Var2'])/walsh_data$`Absolute Efficiency`[2]*100
k1n5 <- data.frame(read.csv("borkowski_cases/K=1_N=5.csv"))
k1n5$rel_efficiency <- (300/k1n5['Var2'])/walsh_data$`Absolute Efficiency`[3]*100
k1n6 <- data.frame(read.csv("borkowski_cases/K=1_N=6.csv"))
k1n6$rel_efficiency <- (300/k1n6['Var2'])/walsh_data$`Absolute Efficiency`[4]*100
k1n7 <- data.frame(read.csv("borkowski_cases/K=1_N=7.csv"))
k1n7$rel_efficiency <- (300/k1n7['Var2'])/walsh_data$`Absolute Efficiency`[5]*100
k1n8 <- data.frame(read.csv("borkowski_cases/K=1_N=8.csv"))
k1n8$rel_efficiency <- (300/k1n8['Var2'])/walsh_data$`Absolute Efficiency`[6]*100
k1n9 <- data.frame(read.csv("borkowski_cases/K=1_N=9.csv"))
k1n9$rel_efficiency <- (300/k1n9['Var2'])/walsh_data$`Absolute Efficiency`[7]*100

k1_efficiencies <- data.frame(c(
  k1n3$rel_efficiency,
  k1n4$rel_efficiency,
  k1n5$rel_efficiency,
  k1n6$rel_efficiency,
  k1n7$rel_efficiency,
  k1n8$rel_efficiency,
  k1n9$rel_efficiency
))

colnames(k1_efficiencies) <- c("N=3", "N=4", "N=5", "N=6", "N=7", "N=8", "N=9")

ggplot(data = melt(k1_efficiencies),
       aes(x=variable, y=value)) +
  geom_boxplot(color = 'blue',
               outlier.color="black",
               alpha = 0.4) +
  ggtitle("Efficiencies relative to G-PSO for 500 runs of Nelder-Mead") +
  theme(legend.position="none") +
  geom_hline(yintercept = 100, color = 'red') +
  xlab("Number of Trials") +
  ylab("Relative Efficiency (%)")

##################################################################
#K=2
##################################################################
k2n6 <- data.frame(read.csv("borkowski_cases/K=2_N=6.csv"))
k2n6$rel_efficiency <- (600/k2n6['Var2'])/walsh_data$`Absolute Efficiency`[8]*100
k2n7 <- data.frame(read.csv("borkowski_cases/K=2_N=7.csv"))
k2n7$rel_efficiency <- (600/k2n7['Var2'])/walsh_data$`Absolute Efficiency`[9]*100
k2n8 <- data.frame(read.csv("borkowski_cases/K=2_N=8.csv"))
k2n8$rel_efficiency <- (600/k2n8['Var2'])/walsh_data$`Absolute Efficiency`[10]*100
k2n9 <- data.frame(read.csv("borkowski_cases/K=2_N=9.csv"))
k2n9$rel_efficiency <- (600/k2n9['Var2'])/walsh_data$`Absolute Efficiency`[11]*100
k2n10 <- data.frame(read.csv("borkowski_cases/K=2_N=10.csv"))
k2n10$rel_efficiency <- (600/k2n10['Var2'])/walsh_data$`Absolute Efficiency`[12]*100
k2n11 <- data.frame(read.csv("borkowski_cases/K=2_N=11.csv"))
k2n11$rel_efficiency <- (600/k2n11['Var2'])/walsh_data$`Absolute Efficiency`[13]*100
k2n12 <- data.frame(read.csv("borkowski_cases/K=2_N=12.csv"))
k2n12$rel_efficiency <- (600/k2n12['Var2'])/walsh_data$`Absolute Efficiency`[14]*100

k2_efficiencies <- data.frame(c(
  k2n6$rel_efficiency,
  k2n7$rel_efficiency,
  k2n8$rel_efficiency,
  k2n9$rel_efficiency,
  k2n10$rel_efficiency,
  k2n11$rel_efficiency,
  k2n12$rel_efficiency
))

colnames(k2_efficiencies) <- c("N=6", "N=7", "N=8", "N=9", "N=10", "N=11","N=12")

ggplot(data = melt(k2_efficiencies),
       aes(x=variable, y=value)) +
  geom_boxplot(color = 'blue',
               outlier.color="black",
               alpha = 0.4) +
  ggtitle("Efficiencies relative to G-PSO for 500 runs of Nelder-Mead") +
  theme(legend.position="none") +
  geom_hline(yintercept = 100, color = 'red')+
  xlab("Number of Trials") +
  ylab("Relative Efficiency (%)")

##################################################################
#K=3
##################################################################
k3n10 <- data.frame(read.csv("borkowski_cases/K=3_N=10.csv"))
k3n10$rel_efficiency <- (1000/k3n10['Var2'])/walsh_data$`Absolute Efficiency`[15]*100
k3n11 <- data.frame(read.csv("borkowski_cases/K=3_N=11.csv"))
k3n11$rel_efficiency <- (1000/k3n11['Var2'])/walsh_data$`Absolute Efficiency`[16]*100
k3n12 <- data.frame(read.csv("borkowski_cases/K=3_N=12.csv"))
k3n12$rel_efficiency <- (1000/k3n12['Var2'])/walsh_data$`Absolute Efficiency`[17]*100
k3n13 <- data.frame(read.csv("borkowski_cases/K=3_N=13.csv"))
k3n13$rel_efficiency <- (1000/k3n13['Var2'])/walsh_data$`Absolute Efficiency`[18]*100
k3n14 <- data.frame(read.csv("borkowski_cases/K=3_N=14.csv"))
k3n14$rel_efficiency <- (1000/k3n14['Var2'])/walsh_data$`Absolute Efficiency`[19]*100
k3n15 <- data.frame(read.csv("borkowski_cases/K=3_N=15.csv"))
k3n15$rel_efficiency <- (1000/k3n15['Var2'])/walsh_data$`Absolute Efficiency`[20]*100
k3n16 <- data.frame(read.csv("borkowski_cases/K=3_N=16.csv"))
k3n16$rel_efficiency <- (1000/k3n16['Var2'])/walsh_data$`Absolute Efficiency`[21]*100

k3_efficiencies <- data.frame(c(
  k3n10$rel_efficiency,
  k3n11$rel_efficiency,
  k3n12$rel_efficiency,
  k3n13$rel_efficiency,
  k3n14$rel_efficiency,
  k3n15$rel_efficiency,
  k3n16$rel_efficiency
))

colnames(k3_efficiencies) <- c("N=10", "N=11", "N=12", "N=13", "N=14", "N=15","N=16")

ggplot(data = melt(k3_efficiencies),
       aes(x=variable, y=value)) +
  geom_boxplot(color = 'blue',
               outlier.color="black",
               alpha = 0.4) +
  ggtitle("Efficiencies relative to G-PSO for 500 runs of Nelder-Mead") +
  theme(legend.position="none") +
  geom_hline(yintercept = 100, color = 'red')+
  xlab("Number of Trials") +
  ylab("Relative Efficiency (%)")
