% Apply coord exchange, keep only the most optimal design
% -------------------------------------------------------

% Design Matrix dimensions
N = 8;
K = 2;

% Set up for coordinate exchange
iterations = 300;
best_design = gen_mat(N, K); 
spv_curr = compute_g(best_design);
spvs = double.empty(iterations, 0);
efficiencies = double.empty(iterations, 0);

% Set SeDuMi parameters
pars.fid=0;
pars.eps=1e-10;
mset(pars)

% Set Parameters for fmincon (L-BFGS-B minimization)
A = [];
b = [];
Aeq = [];
beq = [];
lb = -1;
ub = 1;


for p = 1:iterations
    
    % Continue drawing X from [-1,1] uniform until F.'F nonsingular
    execute = true;
    while execute
        X = gen_mat(N, K);
        F = x2fx(X, 'quadratic');
        if det(F.'*F) > eps^4
            execute = false;
        end
    end

    % Get entered into the loop
    design = 2*X;
    spv_n = 0;

    while abs(compute_g(X) - compute_g(design)) > 0.005

        
        % Make the designs equal, should be edited in the CEXCH
        design = X;
        
        % Coordinate exchange with L-BFGS-B minimization algorithm
        for i = 1:N
            for j = 1:K

                % Formulate the objective
                f = @(x)compute_g_mod(x, X, i, j);

                opt = fmincon(f, X(i, j), A, b, Aeq, beq, lb, ub);
                
                % Update the entry at the optimal value
                X(i, j) = opt;

            end
        end
    end 

    spv_n = compute_g(X);

    % One full pass is complete. 
    if spv_n < compute_g(best_design)
        best_design = X;
    end

    spvs(p) = spv_n;
    efficiencies(p) = 100*6/spv_n;
    
end