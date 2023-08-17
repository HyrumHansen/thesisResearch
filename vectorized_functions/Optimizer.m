% This script calls a gradient-free built-in routine to optimize design
% rather than using CEXCH.

% Random initial vector
N = 8;
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
iterations = 200;
run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);


parpool('local', 18); % Start a local pool of workers
parfor i = 1:iterations

    % Initial values
    x0 = reshape(gen_mat(N, K), [], 1);

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

data = table(run(:), spvs(:), f_evals(:));
writetable(data, "collected_data/k=2_N=8_nelder_mead.csv")
writetable(designs, "collected_data/k=2_N=8_nelder_mead_designs.csv")


% Random initial vector
N = 9;
K = 2;

% Constraints
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

% Loop it and store the data
run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

parfor i = 1:iterations

    % Initial values
    x0 = reshape(gen_mat(N, K), [], 1);

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

data = table(run(:), spvs(:), f_evals(:));
writetable(data, "collected_data/k=2_N=9_nelder_mead.csv")
writetable(designs, "collected_data/k=2_N=9_nelder_mead_designs.csv")


% Random initial vector
N = 10;
K = 2;

% Constraints
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

% Loop it and store the data
run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

parfor i = 1:iterations

    % Initial values
    x0 = reshape(gen_mat(N, K), [], 1);

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

data = table(run(:), spvs(:), f_evals(:));
writetable(data, "collected_data/k=2_N=10_nelder_mead.csv")
writetable(designs, "collected_data/k=2_N=10_nelder_mead_designs.csv")

% Random initial vector
N = 11;
K = 2;

% Constraints
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

% Loop it and store the data
run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

parfor i = 1:iterations

    % Initial values
    x0 = reshape(gen_mat(N, K), [], 1);

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

data = table(run(:), spvs(:), f_evals(:));
writetable(data, "collected_data/k=2_N=11_nelder_mead.csv")
writetable(designs, "collected_data/k=2_N=11_nelder_mead_designs.csv")

% Random initial vector
N = 12;
K = 2;

% Constraints
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

% Loop it and store the data
run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

parfor i = 1:iterations

    % Initial values
    x0 = reshape(gen_mat(N, K), [], 1);

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

data = table(run(:), spvs(:), f_evals(:));
writetable(data, "collected_data/k=2_N=12_nelder_mead.csv")
writetable(designs, "collected_data/k=2_N=12_nelder_mead_designs.csv")


% Random initial vector
N = 13;
K = 2;

% Constraints
lb = -ones(N*K, 1);
ub = ones(N*K, 1);

% Loop it and store the data
run = double.empty(iterations, 0);
spvs = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

parfor i = 1:iterations

    % Initial values
    x0 = reshape(gen_mat(N, K), [], 1);

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

data = table(run(:), spvs(:), f_evals(:));
writetable(data, "collected_data/k=2_N=13_nelder_mead.csv")
writetable(designs, "collected_data/k=2_N=13_nelder_mead_designs.csv")


