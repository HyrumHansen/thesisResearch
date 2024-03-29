library(plotly)
library(orca)

setwd("C:/Users/Hyrum Hansen/Documents/thesis/thesisResearch/borkowski_cases/")
designs <- read.csv("designs/K=2_N=12_designs.csv", header = FALSE)
design <- matrix(unname(unlist(designs[32:33])), byrow = FALSE, ncol=2)
n = 12

# Function to output SPV
generate_data <- function(x1, x2){
  mm <- matrix(c(rep(1, n), design[,1], design[,2],
                 design[,1]*design[,2],
                 design[,1]^2, design[,2]^2),
               nrow = n, ncol = 6, byrow = FALSE)
  x_vec <- c(1, x1, x2, x1*x2, x1^2, x2^2)
  return(n*x_vec%*%solve(t(mm)%*%mm)%*%x_vec)
}

# Generate x and y
sequence <- seq(-1, 1, 0.1)
var1 <- sequence
var2 <- sequence

# Generate z values
spv <- matrix(NA, nrow = length(x), ncol = length(y))
for (i in 1:length(var1)) {
  for (j in 1:length(var2)) {
    spv[i, j] <- generate_data(var1[i], var2[j])
  }
}

# Create 3D surface plot using plot_ly
plot_ly(x = var1, y = var2, z = spv, type = "surface") %>%
  layout(scene = list(
    xaxis = list(title = "",
                 showgrid = FALSE, showticklabels = FALSE, zeroline=FALSE),
    yaxis = list(title = "",
                 showgrid = FALSE, showticklabels = FALSE, zeroline=FALSE),
    zaxis = list(title = "",
                 showgrid = FALSE, showticklabels = FALSE, zeroline=FALSE)
  )
)

# Use orca to export the image
orca(p, file = "surface_plot.png")


