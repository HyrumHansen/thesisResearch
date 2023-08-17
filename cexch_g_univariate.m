% Apply coord exchange, keep only the most optimal design
% -------------------------------------------------------

% Design Matrix dimensions
N = 9;
K = 1;

% Set up for coordinate exchange
iterations = 36;
spvs = double.empty(iterations, 0);
efficiencies = double.empty(iterations, 0);
designs = repmat({[]}, 1, iterations);
f_evals = double.empty(iterations, 0);

% Set SeDuMi parameters
pars.fid=0;
pars.eps=1e-10;
mset(pars)

% Parameters for the optimizer
A = [];
b = [];
Aeq = [];
beq = [];

parpool('local', 18); % Start a local pool of workers

tic
parfor p = 1:iterations

    % Need to do this to make parrallelizable
    spv_n = 100;
    
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
        
        % Coordinate exchange with Brent's minimization algorithm
        for i = 1:N

            % Formulate the objective
            f = @(x)compute_g_mod(x, X, i);

            [opt, spv_n] = fmincon(f, X(i), A, b, Aeq, beq, -1, 1);

            X(i) = opt;

        end
    end 

    spvs(p) = spv_n;
    efficiencies(p) = 100*3/spv_n;
    designs{p} = X;

    
end
toc