% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[d_crit] = compute_d_mod_uni(x, X_c, ind)
    
    X_c(ind) = x;
    F = x2fx(X_c, 'quadratic');
    d_crit = det(F.'*F);

    % If we've arrived to a singular matrix penalize
    if det(F'*F) < eps^4
        d_crit = -100000;
    end

end



