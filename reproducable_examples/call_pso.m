function[design, g_score] = call_pso()    
    % Set up the constraints
    lb = -ones(16, 1);
    ub = ones(16, 1);
    
    % Set the objective function
    f = @(x)compute_g_pso(x, 8, 2);
    options = optimoptions('particleswarm','SwarmSize', 150,'UseParallel',true);
    [design, g_score] = particleswarm(f, 16, lb, ub, options);
end