g_opt_grid <- function(FX){

  # Discritize the continuous parameter space to make calculations feasible
  grid <- c(-1, -0.5, 0, 0.5, 1)

  SPVs <- rep(0, length(grid))

  for(x in grid){
    var <- c(1, x, x^2)
    spv <- t(var)%*%solve(t(FX)%*%FX)%*%var
    SPVs[which(grid == x)] <- spv
  }

  return(max(SPVs))
}

x <- c(1,2,3)
FX <- mmat_onefactor_ord2(x)
g_opt_grid(FX)
