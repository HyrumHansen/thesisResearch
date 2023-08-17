% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[d_crit] = compute_d(X)
    
    F = x2fx(X, 'quadratic');
    d_crit = det(F.'*F);

end



