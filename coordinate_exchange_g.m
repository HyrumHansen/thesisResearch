% Apply coord exchange, keep only the most optimal design
% -------------------------------------------------------

% Design Matrix dimensions
N = 10;
K = 2;

% Set up for coordinate exchange
iterations = 100;
best_design = gen_mat(N, K); 
spv_curr = compute_g(best_design);
spvs = double.empty(100, 0);
efficiencies = double.empty(100, 0);

% Set SeDuMi parameters
pars.fid=0;
pars.eps=1e-10;
mset(pars)

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

    while abs(compute_g(X) - compute_g(design)) > 0.01
        
        % Make the designs equal, should be edited in the CEXCH
        design = X;
        
        % Coordinate exchange with Brent's minimization algorithm
        for i = 1:N
            for j = 1:K

                % Formulate the objective
                f = @(x)compute_g_mod(x, X, i, j);

                opt = fminbnd(f, -1, 1);
                
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