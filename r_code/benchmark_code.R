k1n5_cubic <- c(188.8790, 147.5994, 139.7373, 147.7794, 138.1128)/60
k1n6_cubic <- c(246.7068, 245.0563, 247.1699, 246.9465, 246.0952)/60
k2n9_HO <- c(1550.4, 1516.5, 1503.2, 1503.4, 1545.7)/60
k2n10_HO <- c(1507.7, 1426.9, 1426.7, 1431.5, 1460.8)/60
k2n9_cubic <- c(1676.7, 1674.3, 1645.2, 1622.5, 1664.3)/60
k2n10_cubic <- c(1718.3, 1739.7, 1719.2, 1720.4, 1735.4)/60
k2n11_quartic <- c(1321.7, 1289.2, 1306, 1306, 1309.8)/60
k2n12_quartic <- c(1489.3, 1472.2, 1473.6, 1490.6, 1472.4)/60
k3n14_HO <- c(11681, 11676, 11631, 11665, 11575)/60
k3n15_HO <- c(11633, 11648, 11616, 11681, 11563)/60

# Store vectors in a list for easier manipulation
vectors <- list(
  k1n5_cubic = k1n5_cubic,
  k1n6_cubic = k1n6_cubic,
  k2n9_HO = k2n9_HO,
  k2n10_HO = k2n10_HO,
  k2n9_cubic = k2n9_cubic,
  k2n10_cubic = k2n10_cubic,
  k2n11_quartic = k2n11_quartic,
  k2n12_quartic = k2n12_quartic,
  k3n14_HO = k3n14_HO,
  k3n15_HO = k3n15_HO
)

# Function to calculate min, median, and max for a vector
calculate_stats <- function(v) {
  c(Min = min(v), Median = median(v), Max = max(v))
}

# Apply the function to each vector in the list and store the results
results <- lapply(vectors, calculate_stats)

# Print the results
print(results)
