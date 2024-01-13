% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[obj, M] = compute_g_pexch_k2(design)

    % Build x vector and constraints
    mpol x1 x2
    var = [1 x1 x2 x1*x2 x1^2 x2^2];
    K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2];
   
    
    % Model matrix creation time
    F = x2fx(design, 'quadratic');

    % Define the polynomial
    f = size(design, 1)*var*inv(F.'*F)*var.';

    % Search for optimum using gloptipoly
    P = msdp(max(f), K, 5);
    [~, obj, M] = msol(P);

end



