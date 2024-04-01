function[design, g_score] = call_nm(X)    
    % Set up the constraints
    A = [];
    b = [];
    Aeq = [];
    beq = [];
    lb = -ones(16, 1);
    ub = ones(16, 1);
    
    % Now set up the optimization process
    x0 = reshape(X, [], 1);
    f = @(x)compute_g_vectorized(x, 8, 2);
    [design, g_score] = fmincon(f, x0, A, b, Aeq, beq, lb, ub);
end