% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[SPV] = compute_g_mod(x, X_c, row, col)

    % Build x vector and constraints
    if size(X_c, 2) == 1
        mpol x1
        var = [1 x1 x1^2];
        K = [x1 <= 1, -1 <= x1];
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
    if size(X_c, 2) == 1
        X_c(row) = x;
    elseif size(X_c, 2) > 1
        X_c(row, col) = x;
    end

    F = x2fx(X_c, 'quadratic');

    % Define the polynomial
    f = size(X_c, 1)*var*inv(F.'*F)*var.';

    % Search for optimum using gloptipoly
    P = msdp(max(f), K, 5);
    [~, SPV] = msol(P);

end



