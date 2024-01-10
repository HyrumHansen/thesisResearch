% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[SPV] = gloptipoly_k1_cubic(design, trials, num_var)
    
    % Convert vector to matrix
    X = reshape(design, trials, num_var);
    
    % Set up parameters for this design setting
    mpol x
    var = [1 x x^2 x^3];
    K = [x <= 1, -1 <= x];
    model = [0;
             1;
             2;
             3];
   
    % Evaluate G-score on matrix
    F = x2fx(X, model);

    % Define the polynomial
    f = trials*var*inv(F.'*F)*var.';

    % Search for optimum using gloptipoly
    P = msdp(max(f), K, 5);
    [~, SPV] = msol(P);

end