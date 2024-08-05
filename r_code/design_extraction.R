setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch/borkowski_cases")
library(ggplot2)
library(ggforce)
library(tidyverse)
library(viridis)
library(raster)
library(R.matlab)

k1n3 <- read.csv("K=1_N=3.csv")
k1n4 <- read.csv("K=1_N=4.csv")
k1n5 <- read.csv("K=1_N=5.csv")
k1n6 <- read.csv("K=1_N=6.csv")
k1n7 <- read.csv("K=1_N=7.csv")
k1n8 <- read.csv("K=1_N=8.csv")
k1n9 <- read.csv("K=1_N=9.csv")
k2n6 <- read.csv("K=2_N=6.csv")
k2n7 <- read.csv("K=2_N=7.csv")
k2n8 <- read.csv("K=2_N=8.csv")
k2n9 <- read.csv("K=2_N=9.csv")
k2n10 <- read.csv("K=2_N=10.csv")
k2n11 <- read.csv("K=2_N=11.csv")
k2n12 <- read.csv("K=2_N=12.csv")
k3n10 <- read.csv("K=3_N=10.csv")
k3n11 <- read.csv("K=3_N=11.csv")
k3n12 <- read.csv("K=3_N=12.csv")
k3n13 <- read.csv("K=3_N=13.csv")
k3n14 <- read.csv("K=3_N=14.csv")
k3n15 <- read.csv("K=3_N=15.csv")
k3n16 <- read.csv("K=3_N=16.csv")

k1n3_des <- read.csv("designs/K=1_N=3_designs.csv", header = FALSE)
k1n4_des <- read.csv("designs/K=1_N=4_designs.csv", header = FALSE)
k1n5_des <- read.csv("designs/K=1_N=5_designs.csv", header = FALSE)
k1n6_des <- read.csv("designs/K=1_N=6_designs.csv", header = FALSE)
k1n7_des <- read.csv("designs/K=1_N=7_designs.csv", header = FALSE)
k1n8_des <- read.csv("designs/K=1_N=8_designs.csv", header = FALSE)
k1n9_des <- read.csv("designs/K=1_N=9_designs.csv", header = FALSE)
k2n6_des <- read.csv("designs/K=2_N=6_designs.csv", header = FALSE)
k2n7_des <- read.csv("designs/K=2_N=7_designs.csv", header = FALSE)
k2n8_des <- read.csv("designs/K=2_N=8_designs.csv", header = FALSE)
k2n9_des <- read.csv("designs/K=2_N=9_designs.csv", header = FALSE)
k2n10_des <- read.csv("designs/K=2_N=10_designs.csv", header = FALSE)
k2n11_des <- read.csv("designs/K=2_N=11_designs.csv", header = FALSE)
k2n12_des <- read.csv("designs/K=2_N=12_designs.csv", header = FALSE)
k3n10_des <- read.csv("designs/K=3_N=10_designs.csv", header = FALSE)
k3n11_des <- read.csv("designs/K=3_N=11_designs.csv", header = FALSE)
k3n12_des <- read.csv("designs/K=3_N=12_designs.csv", header = FALSE)
k3n13_des <- read.csv("designs/K=3_N=13_designs.csv", header = FALSE)
k3n14_des <- read.csv("designs/K=3_N=14_designs.csv", header = FALSE)
k3n15_des <- read.csv("designs/K=3_N=15_designs.csv", header = FALSE)
k3n16_des <- read.csv("designs/K=3_N=16_designs.csv", header = FALSE)

k1n3_ind <- which.min(k1n3$Var2)
k1n4_ind <- which.min(k1n4$Var2)
k1n5_ind <- which.min(k1n5$Var2)
k1n6_ind <- which.min(k1n6$Var2)
k1n7_ind <- which.min(k1n7$Var2)
k1n8_ind <- which.min(k1n8$Var2)
k1n9_ind <- which.min(k1n9$Var2)

100*3/min(k1n3$Var2)
100*3/min(k1n4$Var2)
100*3/min(k1n5$Var2)
100*3/min(k1n6$Var2)
100*3/min(k1n7$Var2)
100*3/min(k1n8$Var2)
100*3/min(k1n9$Var2)

cat(paste(unname(unlist(k1n3_des[k1n3_ind])), collapse = "; "))
cat(paste(unname(unlist(k1n4_des[k1n4_ind])), collapse = "; "))
cat(paste(unname(unlist(k1n5_des[k1n5_ind])), collapse = "; "))
cat(paste(unname(unlist(k1n6_des[k1n6_ind])), collapse = "; "))
cat(paste(unname(unlist(k1n7_des[k1n7_ind])), collapse = "; "))
cat(paste(unname(unlist(k1n8_des[k1n8_ind])), collapse = "; "))
cat(paste(unname(unlist(k1n9_des[k1n9_ind])), collapse = "; "))


k2n6_ind <- which.min(k2n6$Var2)
k2n7_ind <- which.min(k2n7$Var2)
k2n8_ind <- which.min(k2n8$Var2)
k2n9_ind <- which.min(k2n9$Var2)
k2n10_ind <- which.min(k2n10$Var2)
k2n11_ind <- which.min(k2n11$Var2)
k2n12_ind <- which.min(k2n12$Var2)

100*6/min(k2n6$Var2)
100*6/min(k2n7$Var2)
100*6/min(k2n8$Var2)
100*6/min(k2n9$Var2)
100*6/min(k2n10$Var2)
100*6/min(k2n11$Var2)
100*6/min(k2n12$Var2)

k2n6 <- rbind(k2n6_des[,k2n6_ind*2-1], k2n6_des[,k2n6_ind*2])
cat("[", paste(apply(k2n6, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k2n7 <- rbind(k2n7_des[,k2n7_ind*2-1], k2n7_des[,k2n7_ind*2])
cat("[", paste(apply(k2n7, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k2n8 <- rbind(k2n8_des[,k2n8_ind*2-1], k2n8_des[,k2n8_ind*2])
cat("[", paste(apply(k2n8, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k2n9 <- rbind(k2n9_des[,k2n9_ind*2-1], k2n9_des[,k2n9_ind*2])
cat("[", paste(apply(k2n9, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k2n10 <- rbind(k2n10_des[,k2n10_ind*2-1], k2n10_des[,k2n10_ind*2])
cat("[", paste(apply(k2n10, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k2n11 <- rbind(k2n11_des[,k2n11_ind*2-1], k2n11_des[,k2n11_ind*2])
cat("[", paste(apply(k2n11, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k2n12 <- rbind(k2n12_des[,k2n12_ind*2-1], k2n12_des[,k2n12_ind*2])
cat("[", paste(apply(k2n12, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")







k3n10_ind <- which.min(k3n10$Var2)
k3n11_ind <- which.min(k3n11$Var2)
k3n12_ind <- which.min(k3n12$Var2)
k3n13_ind <- which.min(k3n13$Var2)
k3n14_ind <- which.min(k3n14$Var2)
k3n15_ind <- which.min(k3n15$Var2)
k3n16_ind <- which.min(k3n16$Var2)

100*10/min(k3n10$Var2)
100*10/min(k3n11$Var2)
100*10/min(k3n12$Var2)
100*10/min(k3n13$Var2)
100*10/min(k3n14$Var2)
100*10/min(k3n15$Var2)
100*10/min(k3n16$Var2)

k3n10 <- rbind(k3n10_des[,k3n10_ind*3-2], k3n10_des[,k3n10_ind*3-1], k3n10_des[,k3n10_ind*3])
cat("[", paste(apply(k3n10, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k3n11 <- rbind(k3n11_des[,k3n11_ind*3-2], k3n11_des[,k3n11_ind*3-1], k3n11_des[,k3n11_ind*3])
cat("[", paste(apply(k3n11, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k3n12 <- rbind(k3n12_des[,k3n12_ind*3-2], k3n12_des[,k3n12_ind*3-1], k3n12_des[,k3n12_ind*3])
cat("[", paste(apply(k3n12, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k3n13 <- rbind(k3n13_des[,k3n13_ind*3-2], k3n13_des[,k3n13_ind*3-1], k3n13_des[,k3n13_ind*3])
cat("[", paste(apply(k3n13, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k3n14 <- rbind(k3n14_des[,k3n14_ind*3-2], k3n14_des[,k3n14_ind*3-1], k3n14_des[,k3n14_ind*3])
cat("[", paste(apply(k3n14, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k3n15 <- rbind(k3n15_des[,k3n15_ind*3-2], k3n15_des[,k3n15_ind*3-1], k3n15_des[,k3n15_ind*3])
cat("[", paste(apply(k3n15, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")

k3n16 <- rbind(k3n16_des[,k3n16_ind*3-2], k3n16_des[,k3n16_ind*3-1], k3n16_des[,k3n16_ind*3])
cat("[", paste(apply(k3n16, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")


### CUBIC & QUARTIC TIME ###
setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch/extension_functions/higher_order_data")
k1n5_cubic <- read.csv("gloptipoly_k1n5.csv")
k1n6_cubic <- read.csv("gloptipoly_k1n6.csv")
k2n9_cubic <- read.csv("gloptipoly_k2n9_cubic.csv")
k2n10_cubic <- read.csv("gloptipoly_k2n10_cubic.csv")
k2n11_quartic <- read.csv("gloptipoly_k2n11_quartic.csv")
k2n12_quartic <- read.csv("gloptipoly_k2n12_quartic.csv")

k1n5_cubic_des <- read.csv("gloptipoly_k1n5_designs.csv", header = FALSE)
k1n6_cubic_des <- read.csv("gloptipoly_k1n6_designs.csv", header = FALSE)
k2n9_cubic_des <- read.csv("gloptipoly_k2n9_cubic_designs.csv", header = FALSE)
k2n10_cubic_des <- read.csv("gloptipoly_k2n10_cubic_designs.csv", header = FALSE)
k2n11_quartic_des <- read.csv("gloptipoly_k2n11_quartic_designs.csv", header = FALSE)
k2n12_quartic_des <- read.csv("gloptipoly_k2n12_quartic_designs.csv", header = FALSE)

k1n5_cubic_ind <- which.min(k1n5_cubic$Var2)
k1n6_cubic_ind <- which.min(k1n6_cubic$Var2)
k2n9_cubic_ind <- which.min(k2n9_cubic$Var2)
k2n10_cubic_ind <- which.min(k2n10_cubic$Var2)
k2n11_quartic_ind <- which.min(k2n11_quartic$Var2)
k2n12_quartic_ind <- which.min(k2n12_quartic$Var2)

k1n5_cub <- k1n5_cubic_des[(k1n5_cubic_ind*5-5+1):(k1n5_cubic_ind*5)]
k1n6_cub <- k1n6_cubic_des[(k1n6_cubic_ind*6-6+1):(k1n6_cubic_ind*6)]
k2n9_cub <- matrix(
  k2n9_cubic_des[(k2n9_cubic_ind*18-18+1):(k2n9_cubic_ind*18)],
  nrow = 2,
  ncol = 9,
  byrow = TRUE
)
k2n10_cub <- matrix(
  k2n10_cubic_des[(k2n10_cubic_ind*20-20+1):(k2n10_cubic_ind*20)],
  nrow = 2,
  ncol = 10,
  byrow = TRUE
)

k2n11_quart <- matrix(
  k2n11_quartic_des[(k2n11_quartic_ind*22-22+1):(k2n11_quartic_ind*22)],
  nrow = 2,
  ncol = 11,
  byrow = TRUE
)
k2n12_quart <- matrix(
  k2n12_quartic_des[(k2n12_quartic_ind*24-24+1):(k2n12_quartic_ind*24)],
  nrow = 2,
  ncol = 12,
  byrow = TRUE
)

100*4/min(k1n5_cubic$Var2)
100*4/min(k1n6_cubic$Var2)
100*8/min(k2n9_cubic$Var2)
100*8/min(k2n10_cubic$Var2)
100*9/min(k2n11_quartic$Var2)
100*9/min(k2n12_quartic$Var2)

cat("[", paste(apply(k1n5_cub, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")
cat("[", paste(apply(k1n6_cub, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")
cat("[", paste(apply(k2n9_cub, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")
cat("[", paste(apply(k2n10_cub, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")
cat("[", paste(apply(k2n11_quart, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")
cat("[", paste(apply(k2n12_quart, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")



### HIGHER ORDER INTERACTIONS ###
setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch/extension_functions/higher_order_interaction_data")

k2n9_ho <- read.csv("gloptipoly_k2n9.csv")
k2n10_ho <- read.csv("gloptipoly_k2n10.csv")
k3n14_ho <- read.csv("gloptipoly_k3n14.csv")
k3n15_ho <- read.csv("gloptipoly_k3n15.csv")

k2n9_ho_des <- read.csv("gloptipoly_k2n9_designs.csv", header = FALSE)
k2n10_ho_des <- read.csv("gloptipoly_k2n10_designs.csv", header = FALSE)
k3n14_ho_des <- read.csv("gloptipoly_k3n14_designs.csv", header = FALSE)
k3n15_ho_des <- read.csv("gloptipoly_k3n15_designs.csv", header = FALSE)

k2n9_ho_ind <- which.min(k2n9_ho$Var2)
k2n10_ho_ind <- which.min(k2n10_ho$Var2)
k3n14_ho_ind <- which.min(k3n14_ho$Var2)
k3n15_ho_ind <- which.min(k3n15_ho$Var2)

100*8/min(k2n9_ho$Var2)
100*8/min(k2n10_ho$Var2)
100*13/min(k3n14_ho$Var2)
100*13/min(k3n15_ho$Var2)

k2n9_ho <- matrix(
  k2n9_ho_des[(k2n9_ho_ind*18-18+1):(k2n9_ho_ind*18)],
  nrow = 2,
  ncol = 9,
  byrow = TRUE
)
k2n10_ho <- matrix(
  k2n10_ho_des[(k2n10_ho_ind*20-20+1):(k2n10_ho_ind*20)],
  nrow = 2,
  ncol = 10,
  byrow = TRUE
)
k3n14_ho <- matrix(
  k3n14_ho_des[(k3n14_ho_ind*42-42+1):(k3n14_ho_ind*42)],
  nrow = 3,
  ncol = 14,
  byrow = TRUE
)
k3n15_ho <- matrix(
  k3n15_ho_des[(k3n15_ho_ind*45-45+1):(k3n15_ho_ind*45)],
  nrow = 3,
  ncol = 15,
  byrow = TRUE
)

cat("[", paste(apply(k2n9_ho, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")
cat("[", paste(apply(k2n10_ho, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")
cat("[", paste(apply(k3n14_ho, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")
cat("[", paste(apply(k3n15_ho, 2, function(x) paste(x, collapse = " ")), collapse = "; "), "]")





















k9_opt <- t(k3n10)

tester <- function(x1, x2, x3){
  mm <- matrix(c(rep(1, 10), k9_opt[,1], k9_opt[,2], k9_opt[,3],
                 k9_opt[,1]*k9_opt[,2], k9_opt[,1]*k9_opt[,3], k9_opt[,2]*k9_opt[,3], 
                 k9_opt[,1]^2, k9_opt[,2]^2, k9_opt[,3]^2),
               nrow = 10, ncol = 10, byrow = FALSE)
  x_vec <- c(1, x1, x2, x3, x1*x2, x1*x3, x2*x3, x1^2, x2^2, x3^2)
  return(10*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

data_generator <- function(polynomial, interval){
  sequence <- seq(-1, 1, interval)
  data <- expand.grid(sequence, sequence, sequence)
  data$spv <- apply(data, 1, function(row) polynomial(row[1], row[2], row[3]))
  return(data)
}

data <- data_generator(tester, 0.01)

grid_points <- data.frame(x1 = k9_opt[,1],
                          x2 = k9_opt[,2],
                          x3 = k9_opt[,3])
grid_points$spv <- rep(3, nrow(grid_points))
