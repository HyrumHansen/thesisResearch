% Apply coord exchange, keep only the most optimal design
% -------------------------------------------------------

% Design Matrix dimensions
N = 8;
K = 2;

% Set up for coordinate exchange
iterations = 15;
best_design = gen_mat(N, K); 
spv_curr = compute_g(best_design);
spvs = [];

for p = 1:iterations
    
    % Continue drawing X from [-1,1] uniform until F.'F nonsingular
    execute = true;
    while execute
        X = gen_mat(N, K);
        F = x2fx(X, 'quadratic');
        if det(F.'*F) > eps
            execute = false;
        end
    end

    % Get entered into the loop
    design = 2*X;

    while ~isequal(X, design)
        
        % Make the designs equal, should be edited in the CEXCH
        design = X;
        
        % Coordinate exchange with the ol' grid approx
        for i = 1:N
            for j = 1:K

                % Formulate the objective
                f = @(x)compute_g_mod(x, X, i, j);

                opt = fminbnd(f, -1, 1);
                
                % Form a new matrix with updated value
                X_n = design;
                X_n(i,j) = opt;
                spv_n = compute_g(X_n);

                % If we've arrived to a singular matrix penalize
                F = x2fx(X_n, 'quadratic');
                if det(F'*F) < eps^3
                    spv_n = 100000;
                end

                % If new spv is better than old set new matrix
                if spv_n < spv_curr
                    design = X_n;
                    spv_curr = spv_n;
                    spvs = [spvs, spv_curr];
                end
            end
        end

        % One full pass is complete. 
        if compute_g(design) < compute_g(best_design)
            best_design = design;
        end

    end  
end

compute_g(best_design)
spvs