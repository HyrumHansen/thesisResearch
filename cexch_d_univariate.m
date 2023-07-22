% Apply coord exchange, keep only the most optimal design
% -------------------------------------------------------

% Design Matrix dimensions
N = 5;
K = 1;

% Set up for coordinate exchange
iterations = 100;
best_design = gen_mat(N, K); 
efficiencies = [];

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

    while ~abs(compute_d(X) - compute_d(design)) < 0.01
    % while ~isequal(X, design) <- runs forever

        % Make the designs equal, should be edited in the CEXCH
        design = X;
        
        % Coordinate exchange with the ol' grid approx
        for i = 1:N

                % Formulate the objective
                f = @(x)-compute_d_mod_uni(x, X, i);

                %options = optimset('TolX', 1e-8);

                opt = fminbnd(f, -1, 1);
                
                % Update the matrix with optimal value
                X(i) = opt;
        end
    end
   

    % One full pass is complete. 
    if compute_d(design) > compute_d(best_design)
        best_design = design;
    end

    D_X = 100*compute_d(design)^(1/3)/N/45.9888*100;
    efficiencies = [efficiencies, D_X];
end
