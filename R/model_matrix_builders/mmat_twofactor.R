# Full first order model for one factor
mmat_twofactor_ord2 <- function(x){
  trials <- nrow(x)
  intercept <- rep(1, trials)
  x1_squared <- x[ ,1]^2
  x2_squared <- x[ ,2]^2
  interaction <- x[ ,1]*x[ ,2]


  model_matrix <- cbind(intercept, x, x1_squared, x2_squared, interaction)
  return(model_matrix)
}

