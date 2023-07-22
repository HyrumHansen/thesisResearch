% Design Matrix dimensions
N = 8;
K = 2;

% Set up for coordinate exchange
iterations = 1;
spvs = [];
X = best_design;

for p = 1:20
    
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

    best_design = X;
    spvs = [spvs, compute_g(X)];
end  

compute_g(best_design)
spvs 