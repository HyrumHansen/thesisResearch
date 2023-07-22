% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[SPV] = compute_g_mod(x, X_c, row, col)

    % Build x vector and constraints
    if size(X_c, 2) == 1
        mpol x
        var = [1 x x^2];
        K = [x <= 1, -1 <= x];
    elseif size(X_c, 2) == 2
        mpol x1 x2
        var = [1 x1 x2 x1*x2 x1^2 x2^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2];
    elseif size(X_c, 2) == 3
        mpol x1 x2 x3
        var = [1 x1 x2 x3 x1*x2 x1*x3 x2*x3 x1^2 x2^2 x3^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3];
    elseif size(X_c, 2) == 4
        mpol x1 x2 x3 x4
        var = [1 x1 x2 x3 x4 x1*x2 x1*x3 x1*x4 x2*x3 x2*x4 x3*x4...
               x1^2 x2^2 x3^2 x4^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3,...
             x4 <= 1, -1 <= x4];
    elseif size(X_c, 2) == 5
        mpol x1 x2 x3 x4 x5
        var = [1 x1 x2 x3 x4 x5 x1*x2 x1*x3 x1*x4 x1*x5 x2*x3 x2*x4 x2*x5...
               x3*x4 x3*x5 x4*x5 x1^2 x2^2 x3^2 x4^2 x5^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3,...
             x4 <= 1, -1 <= x4, x5 <= 1, -1 <= x5];
    end

    % Pass in the latest value returned from univariate optimizer
    X_c(row, col) = x;
    F = x2fx(X_c, 'quadratic');

    % Define the polynomial
    f = size(X_c, 1)*var*inv(F.'*F)*var.';

    % If we've arrived to a singular matrix penalize
    if det(F'*F) < eps^3.8
        SPV = 100000;
    else
        % Search for optimum using gloptipoly
        P = msdp(max(f), K, 4);
        [~, SPV] = msol(P);
    end
end



