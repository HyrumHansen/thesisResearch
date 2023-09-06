% This script calls a gradient-free built-in routine to optimize design
% rather than using CEXCH.

% Random initial vector
N = 6;
K = 2;

% Constraints
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

% Other parameters must be set
A = [];
b = [];
Aeq = [];
beq = [];

% Loop it and store the data
iterations = 100;

run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);


parpool('local', 18); % Start a local pool of workers
tic
parfor i = 1:iterations

    % Continue drawing X from [-1,1] uniform until F.'F nonsingular
    execute = true;
    while execute
        X = gen_mat(N, K);
        F = x2fx(X, 'quadratic');
        if rcond(F.'*F) > eps^(1/10)
            execute = false;
        end
    end

    % Initial values
    x0 = reshape(X, [], 1);

    % Optimizer options
    options = optimoptions('fmincon', 'Display', 'iter', 'Algorithm', 'interior-point');
    
    % Try fmincon
    f = @(x)compute_g_vectorized(x, N, K);
    [x_optimal, fval, exitflag, output] = fmincon(f, x0, A, b, Aeq, beq, lb, ub, [], options);

    % Store my data
    run(i) = i;
    spvs(i) = fval;
    designs{i} = reshape(x_optimal, N, K);
    f_evals(i) = output.funcCount;  

end
toc
data = table(run(:), spvs(:), f_evals(:));
writetable(data, "collected_data/k=2_N=6_nelder_mead.csv")
writecell(designs, "collected_data/k=2_N=6_nelder_mead_designs.csv")




