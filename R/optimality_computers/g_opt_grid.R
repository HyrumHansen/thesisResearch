g_opt_one_fact <- function(FX){

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

g_opt_two_fact <- function(FX){

  # Discritize the continuous parameter space to make calculations feasible
  grid <- c(-1, -0.5, 0, 0.5, 1)

  SPVs <- rep(0, length(grid)^2)

  for(x1 in grid){
    for(x2 in grid){
      var <- c(1, x1, x2, x1^2, x2^2, x1*x2)
      spv <- t(var)%*%solve(t(FX)%*%FX)%*%var
      SPVs[which(grid == x1) * which(grid==x2)] <- spv
    }
  }

  return(max(SPVs))
}

x <- c(-1, -0.5, 0, 0.5, 1)
FX <- mmat_onefactor_ord2(x)
g_opt_grid(FX)
