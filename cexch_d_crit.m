% Apply coord exchange, keep only the most optimal design
% -------------------------------------------------------

% Design Matrix dimensions
N = 8;
K = 2;

% Set up for coordinate exchange
iterations = 100;
best_design = gen_mat(N, K); 
og_design = best_design
d_crit_curr = compute_d(best_design);

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
                f = @(x)-compute_d_mod(x, X, i, j);

                opt = fminbnd(f, -1, 1);
                
                % Form a new matrix with updated value
                X_n = design;
                X_n(i,j) = opt;
                d_crit_n = compute_d(X_n);

                % If we've arrived to a singular matrix penalize
                F = x2fx(X_n, 'quadratic');
                if det(F'*F) < eps^3
                    d_crit_n = -100000;
                end

                % If new spv is better than old set new matrix
                if d_crit_n > d_crit_curr
                    design = X_n;
                    d_crit_curr = d_crit_n;
                end
            end
        end

        % One full pass is complete. 
        if compute_d(design) > compute_d(best_design)
            best_design = design;
            fprintf("\nUpdated_score: %i", compute_d(best_design))
        end
    end  
end

compute_d(best_design)