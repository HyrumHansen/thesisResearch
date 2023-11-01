% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[SPV] = compute_g_new(design, trials, setting)

    % Convert vector to matrix
    X = reshape(design, trials, 2);

     % Build x vector and constraints
    if setting == 1
        mpol x1 x2
        var = [1 x1 x2 x1*x2 x1^2 x2^2 x1^3];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2];
        model = [0 0
         1 0
         0 1
         1 1
         2 0
         0 2
         3 0];
    end

    % Evaluate G-score on matrix
    F = x2fx(X, model);

    % Define the polynomial
    f = trials*var*inv(F.'*F)*var.';

    % Search for optimum using gloptipoly
    P = msdp(max(f), K, 5);
    [~, SPV] = msol(P);

end