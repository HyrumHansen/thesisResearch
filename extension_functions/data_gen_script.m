% Set up parallelization
parpool('local')
iterations = 100;

tic
% Empty Slates
designs = repmat({[]}, 1, iterations);
fvals = double.empty(iterations, 0);
run = double.empty(iterations, 0);

% Design Scenario
N = 12;
K = 2;
model = [0 0;
         1 0;
         0 1;
         2 0;
         0 2;
         3 0;
         0 3;
         4 0;
         0 4];

% parameters must be set
A = [];
b = [];
Aeq = [];
beq = [];
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

% Generate all the designs n stuff
parfor i=1:iterations

    % Initial values
    X = gen_mat(N, K);
    x0 = reshape(X, [], 1);
    
    % Optimizer options
    options = optimoptions('fmincon', 'Display', 'iter', ...
        'Algorithm', 'interior-point','OutputFcn', @outputFcn_global);
    
    % Try fmincon
    f = @(x)gloptipoly_k2_quartic(x, N, K);
    [x_optimal, fval, exitflag, output] = fmincon(f, x0, A, b, Aeq, beq, lb, ub, [], options);
    
    % Finally to store the designs
    designs{i} = x_optimal.';
    fvals(i) = fval;
    run(i) = i;
end
toc

% Write the table to a CSV file
data = table(run(:), fvals(:));
csvwrite("higher_order_data/gloptipoly_k2n11_quartic_designs.csv", designs)
writetable(data, 'higher_order_data/gloptipoly_k2n11_quartic.csv');
