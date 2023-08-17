% Apply coord exchange, keep only the most optimal design
% -------------------------------------------------------

% Design Matrix dimensions
N = 8;
K = 2;

% Set up for coordinate exchange
iterations = 300;
spvs = double.empty(iterations, 0);
efficiencies = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

% Set SeDuMi parameters
pars.fid=0;
pars.eps=1e-10;
mset(pars)

% Set Parameters for fmincon (L-BFGS-B minimization)
A = [];
b = [];
Aeq = [];
beq = [];

% Parrallellizationing parameters
parpool('local', maxNumCompThreads); % Start a local pool of workers

tic
parfor p = 1:iterations
    
    % Continue drawing X from [-1,1] uniform until F.'F nonsingular
    execute = true;
    while execute
        X = gen_mat(N, K);
        F = x2fx(X, 'quadratic');
        if det(F.'*F) > eps^3
            execute = false;
        end
    end

    % Get entered into the loop
    design = 2*X;
    function_evaluations = 0;

    while abs(compute_g(X) - compute_g(design)) > 0.001

        
        % Make the designs equal, should be edited in the CEXCH
        design = X;
        
        % Coordinate exchange with L-BFGS-B minimization algorithm
        for i = 1:N
            for j = 1:K

                % Formulate the objective
                f = @(x)compute_g_mod(x, X, i, j);

                [opt, spv_n] = fmincon(f, X(i, j), A, b, Aeq, beq, -1, 1);
                
                % Update the entry at the optimal value
                X(i, j) = opt;

            end
        end
    end 

    spvs(p) = spv_n;
    efficiencies(p) = 100*6/spv_n;
    designs{p} = X;
    
end
toc