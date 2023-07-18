% Compute G score for a candidate design using gloptipoly
% -------------------------------------------------------

function[obj] = compute_g(design)

    % Build x vector and constraints
    if size(design, 2) == 1
        mpol x
        var = [1 x x^2];
        K = [x <= 1, -1 <= x];
    elseif size(design, 2) == 2
        mpol x1 x2
        var = [1 x1 x2 x1*x2 x1^2 x2^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2];
    elseif size(design, 2) == 3
        mpol x1 x2 x3
        var = [1 x1 x2 x3 x1*x2 x1*x3 x2*x3 x1^2 x2^2 x3^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3];
    elseif size(design, 2) == 4
        mpol x1 x2 x3 x4
        var = [1 x1 x2 x3 x4 x1*x2 x1*x3 x1*x4 x2*x3 x2*x4 x3*x4...
               x1^2 x2^2 x3^2 x4^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3,...
             x4 <= 1, -1 <= x4];
    elseif size(design, 2) == 5
        mpol x1 x2 x3 x4 x5
        var = [1 x1 x2 x3 x4 x5 x1*x2 x1*x3 x1*x4 x1*x5 x2*x3 x2*x4 x2*x5...
               x3*x4 x3*x5 x4*x5 x1^2 x2^2 x3^2 x4^2 x5^2];
        K = [x1 <= 1, -1 <= x1, x2 <= 1, -1 <= x2, x3 <= 1, -1 <= x3,...
             x4 <= 1, -1 <= x4, x5 <= 1, -1 <= x5];
    end
    
    % Model matrix creation time
    F = x2fx(design, 'quadratic');

    % Define the polynomial
    f = size(design, 1)*var*inv(F.'*F)*var.';

    % Search for optimum using gloptipoly
    P = msdp(max(f), K, 4);
    [~, obj] = msol(P);

end



