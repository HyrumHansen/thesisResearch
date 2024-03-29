##################################
## This script to boxplot stuff ##
##################################

pexch <- read.csv("point_exchange/data/k2n8_pexch_efficiencies.csv")
mod_pexch <- read.csv("point_exchange/data/k2n8_pexch_mod_efficiencies.csv")
nm <- read.csv("borkowski_cases/K=2_N=8.csv")

pexch <- 6.822/as.numeric(unname(unlist(pexch$Var2[pexch$Var2 != 0])))*100
mod_pexch <- 6.822/as.numeric(unname(unlist(mod_pexch$Var2[mod_pexch$Var2 != 0])))*100
nm <- 6.822/unname(unlist(nm$Var2))*100

# Combine the vectors into a data frame
df <- data.frame(
  Group = rep(c("PEXCH", "Mod PEXCH", "Nelder-Mead"),
              times = c(length(pexch), length(mod_pexch), length(nm))),
  Values = c(pexch, mod_pexch, nm)
)

# Create side-by-side boxplot using ggplot2
ggplot(df, aes(x = Group, y = Values)) +
  geom_boxplot() +
  labs(title = "Candidate Optimal Design Distribution by Algorithm",
       x = "Algorithm",
       y = "Relative Efficiency") +
  theme(
    axis.title.x = element_text(size = 16),
    axis.text.x = element_text(size = 12),
    axis.title.y = element_text(size = 16),
    plot.title = element_text(size = 20)
  )


