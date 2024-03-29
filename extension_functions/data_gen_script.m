% Set up parallelization
parpool('local')
iterations = 100;

% Design Scenario
N = 10;
K = 2;
model = [0 0;
         1 0;
         0 1;
         1 1;
         2 0;
         0 2;
         3 0;
         0 3];

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
    f = @(x)gloptipoly_k2_cubic(x, N, K);
    [x_optimal, fval, exitflag, output] = fmincon(f, x0, A, b, Aeq, beq, lb, ub, [], options);
end
delete(gcp('nocreate'))

