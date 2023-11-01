% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[SPV] = compute_g_pso(design, trials, num_var)

    % Convert vector to matrix
    X = reshape(design, trials, num_var);

     % Build x vector and constraints
    if num_var == 1
        mpol x
        var = [1 x x^2];
        K = [x <= 1, -1 <= x];
    elseif num_var == 2
        mpol x1 x2
        var = [1 x1 x2 x1*x2 x1^2 x2^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2];
    elseif num_var == 3
        mpol x1 x2 x3
        var = [1 x1 x2 x3 x1*x2 x1*x3 x2*x3 x1^2 x2^2 x3^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3];
    elseif num_var == 4
        mpol x1 x2 x3 x4
        var = [1 x1 x2 x3 x4 x1*x2 x1*x3 x1*x4 x2*x3 x2*x4 x3*x4...
               x1^2 x2^2 x3^2 x4^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3,...
             x4 <= 1, -1 <= x4];
    elseif num_var == 5
        mpol x1 x2 x3 x4 x5
        var = [1 x1 x2 x3 x4 x5 x1*x2 x1*x3 x1*x4 x1*x5 x2*x3 x2*x4 x2*x5...
               x3*x4 x3*x5 x4*x5 x1^2 x2^2 x3^2 x4^2 x5^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3,...
             x4 <= 1, -1 <= x4, x5 <= 1, -1 <= x5];
    end

    % Evaluate G-score on matrix
    F = x2fx(X, 'quadratic');

     if det(F.'*F) < eps^(1/2)
        SPV = 500;
     else
        % Define the polynomial
        f = trials*var*inv(F.'*F)*var.';
    
        % Search for optimum using gloptipoly
        P = msdp(max(f), K, 5);
        [~, SPV] = msol(P);
     end

end