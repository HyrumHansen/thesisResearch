% Design Scenario
N = 10;
K = 2;
model = [0 0;
         1 0;
         0 1;
         1 1
         2 0;
         0 2];

% parameters must be set
A = [];
b = [];
Aeq = [];
beq = [];
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

for i = 1:100
    % Initial values
    X = gen_mat(N, K);
    x0 = reshape(X, [], 1);
    
    % Initialize designs as a global variable
    global designs;
    designs = [];
    
    % Optimizer options
    options = optimoptions('fmincon', 'Display', 'iter', ...
        'Algorithm', 'interior-point', 'OutputFcn', @saveOptimizer);
    
    % Try fmincon with dynamic array
    f = @(x)compute_g_vectorized(x, N, K);
    
    [x_optimal, fval, exitflag, output] = fmincon(f, x0, A, b, Aeq, beq, lb, ub, [], options);

    % Store the designs
    designsTable = struct2table(designs);
    writetable(designsTable, sprintf("error_quantification_data/k2n10_trial%d.csv", i));

end

% Custom output function to save optimizer
function stop = saveOptimizer(x, optimValues, state)
    % Access global designs variable
    global designs;
    
    % Save the current optimizer at each iteration
    designs(end+1).optimizer = x;
    designs(end).fval = optimValues.fval;
    
    stop = false;
end
