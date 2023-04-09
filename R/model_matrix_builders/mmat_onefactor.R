# Full first order model for one factor
mmat_onefactor_ord2 <- function(x){
  trials <- length(x)
  intercept <- rep(1, trials)

  model_matrix <- cbind(intercept, x)
  return(model_matrix)
}

# Full second order model for one factor
mmat_onefactor_ord2 <- function(x){
  trials <- length(x)
  intercept <- rep(1, trials)
  squared <- x^2

  model_matrix <- cbind(intercept, x, squared)
  return(model_matrix)
}
