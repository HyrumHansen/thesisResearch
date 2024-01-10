% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[SPV] = gloptipoly_k3_quartic(design, trials, num_var)
    
    % Convert vector to matrix
    X = reshape(design, trials, num_var);
    
    % Set up parameters for this design setting
    mpol x1 x2 x3
    var = [1 x1 x2 x3 x1^2 x2^2 x3^2 x1^3 x2^3 x3^3 x1^4 x2^4 x3^4];
    K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3];
    model = [0 0 0;
             1 0 0;
             0 1 0;
             0 0 1;
             2 0 0;
             0 2 0;
             0 0 2;
             3 0 0;
             0 3 0;
             0 0 3;
             4 0 0;
             0 4 0;
             0 0 4];

    % Evaluate G-score on matrix
    F = x2fx(X, model);

    % Define the polynomial
    f = trials*var*inv(F.'*F)*var.';

    % Search for optimum using gloptipoly
    P = msdp(max(f), K, 6);
    [~, SPV] = msol(P);
end