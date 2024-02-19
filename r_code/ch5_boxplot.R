##################################
## This script to boxplot stuff ##
##################################

pexch <- read.csv("point_exchange/data/k3n12_pexch_efficiencies.csv")
mod_pexch <- read.csv("point_exchange/data/k3n12_pexch_mod_efficiencies.csv")
nm <- read.csv("borkowski_cases/K=3_N=12.csv")

pexch <- 11.99/as.numeric(unname(unlist(pexch$Var2[pexch$Var2 != 0])))*100
mod_pexch <- 11.99/as.numeric(unname(unlist(mod_pexch$Var2[mod_pexch$Var2 != 0])))*100
nm <- 11.99/unname(unlist(nm$Var2))*100

# Combine the vectors into a data frame
df <- data.frame(
  Group = rep(c("PEXCH", "Mod PEXCH", "Nelder-Mead"),
              times = c(length(pexch), length(mod_pexch), length(nm))),
  Values = c(pexch, mod_pexch, nm)
)

# Create side-by-side boxplot using ggplot2
ggplot(df, aes(x = Group, y = Values, fill = Group)) +
  geom_boxplot() +
  scale_fill_manual(values = c("skyblue", "lightgreen", "lightcoral")) +
  labs(title = "Candidate Optimal Design Distribution by Algorithm",
       x = "Algorithm",
       y = "Relative Efficiency") +
  theme_minimal()


