parpool('local')
iterations = 140;

% Empty Slates
run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

for i = 1:iterations

    % Design Scenario
    N = 9;
    K = 2;
    model = 'quadratic';
    
    % Constraints (|x| < 1 for all x)
    lb = -ones(N*K, 1);
    ub = ones(N*K, 1);
    
    % Set the objective function
    f = @(x)compute_g_pso(x, N, K);
    options = optimoptions('particleswarm','SwarmSize', 150,'UseParallel',true);
    
    [x, fval] = particleswarm(f, N*K, lb, ub, options);

    % Store my data
    run(i) = i;
    spvs(i) = fval;
    f_evals(i) = output.funcCount; 
    X_current = reshape(x_optimal, N, K);

end

data = table(run(:), spvs(:), f_evals(:));
str_data = sprintf('pso_data/K=%d_N=%d.csv', K, N);
str_designs = sprintf('pso_data/K=%d_N=%d_designs.csv', K, N);
writetable(data, str_data)
csvwrite(str_designs, designs)
delete(gcp('nocreate'))



