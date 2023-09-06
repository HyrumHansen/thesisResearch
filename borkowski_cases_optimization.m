% Read in the N & K values
dat = readtable("walsh_data.csv");

% This script calls a gradient-free built-in routine to optimize design
% rather than using CEXCH.

% parameters must be set
A = [];
b = [];
Aeq = [];
beq = [];

for scenario = 1:21
    % Loop it and store the data
    iterations = 500;
    
    run = double.empty(iterations, 0);
    spvs = double.empty(iterations, 0);
    designs = repmat({[]}, 1, iterations);
    f_evals = double.empty(iterations, 0);

    % Design Scenario
    N = dat{scenario, 2};
    K = dat{scenario, 1};

    % Constraints
    lb = -ones(N*K, 1);
    ub = ones(N*K, 1);
    
    parpool('local', 18); % Start a local pool of workers

    parfor i = 1:iterations
    
        % Continue drawing X from [-1,1] uniform until F.'F nonsingular
        execute = true;
        while execute
            X = gen_mat(N, K);
            F = x2fx(X, 'quadratic');
            
            % Handles the edge cases
            if size(F, 1) == N
                if rcond(F.'*F) > eps^(1/10)
                execute = false;
                end
    
            % Handles the primary cases
            else 
                if det(F.'*F) > eps^3
                execute = false;
                end
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

    data = table(run(:), spvs(:), f_evals(:));

    str = sprintf('borkowski_cases/K=%d_N=%d.csv', K, N);
    writetable(data, str)
    delete(gcp('nocreate'))
end




