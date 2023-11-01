parpool('local')
iterations = 15;

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
    X_current = reshape(x, N, K);
    
        % Needed to store the designs
        X_store = [];
        for col = 1:K
            my_col = [];
            for row = 1:N
                my_col = [my_col X_current(row, col)];
            end
            X_store = [X_store; my_col];
        end
        
    % Finally to store the designs
    designs{i} = X_store.';

end

data = table(run(:), spvs(:));
str_data = sprintf('pso_data/K=%d_N=%d.csv', K, N);
str_designs = sprintf('pso_data/K=%d_N=%d_designs.csv', K, N);
writetable(data, str_data)
csvwrite(str_designs, designs)
delete(gcp('nocreate'))



