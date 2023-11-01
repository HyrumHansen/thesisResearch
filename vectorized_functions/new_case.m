% Loop it and store the data
iterations = 1000;

run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

% This script calls a gradient-free built-in routine to optimize design
% rather than using CEXCH.

% parameters must be set
A = [];
b = [];
Aeq = [];
beq = [];

% Design Scenario
N = 8;
K = 2;
model = [0 0
         1 0
         0 1
         1 1
         2 0
         0 2
         3 0];

% Constraints
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

parpool('local', 18); % Start a local pool of workers

parfor i = 1:iterations

    % Continue drawing X from [-1,1] uniform until F.'F nonsingular
    execute = true;
    while execute
        X = gen_mat(N, K);
        F = x2fx(X, model);

        if det(F.'*F) > eps^3
            execute = false;
        end
    end

    % Initial values
    x0 = reshape(X, [], 1);

    % Optimizer options
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point');
    
    % Try fmincon
    f = @(x)compute_g_new(x, N, 1);
    [x_optimal, fval, exitflag, output] = fmincon(f, x0, A, b, Aeq, beq, lb, ub, [], options);

    % Store my data
    run(i) = i;
    spvs(i) = fval;
    f_evals(i) = output.funcCount; 
    X_current = reshape(x_optimal, N, K);

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