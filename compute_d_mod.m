% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[d_crit] = compute_d_mod(x, X_c, row, col)
    
    X_c(row, col) = x;
    F = x2fx(X_c, 'quadratic');
    d_crit = det(F.'*F);

end



