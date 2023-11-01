% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[SPV] = compute_g_surrogate(design)

    % Convert vector to matrix
    X = reshape(design, 8, 2);

    mpol x1 x2
    var = [1 x1 x2 x1*x2 x1^2 x2^2];
    K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2];
   

    % Evaluate G-score on matrix
    F = x2fx(X, 'quadratic');

     if det(F.'*F) < eps^(1/2)
        SPV = 500;
     else
        % Define the polynomial
        f = 8*var*inv(F.'*F)*var.';
    
        % Search for optimum using gloptipoly
        P = msdp(max(f), K, 5);
        [~, SPV] = msol(P);
     end

end