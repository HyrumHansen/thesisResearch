% Apply coord exchange, keep only the most optimal design
% -------------------------------------------------------

% Design Matrix dimensions
N = 8;
K = 2;

% Set up for coordinate exchange
iterations = 200;
best_design = gen_mat(N, K); 
spv_curr = compute_g(best_design);
spvs = [];

for p = 1:iterations
    
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
    iters = 0;

    while ~isequal(X, design)
        
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

        % One full pass is complete. 
        if compute_g(X) < compute_g(best_design)
            best_design = X;
            spvs = [spvs, compute_g(X)];
        end
        
        % Up iteration count
        iters = iters + 1;

        % Extra stopping criteria
        if iters > 8
            break
        end

    end  
end

compute_g(best_design)
spvs 