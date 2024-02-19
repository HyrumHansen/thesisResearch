% This script applies a modified point exchange algorithm to determine
% how A-Optimal, D-Optimal, and random designs morph into G-optimal
% designs.

% Script for N=2, K=8

% This is a D-Optimal design reported by Borkowski (2003)
%{
design = [1 1;
     1 -1;
     -1 1;
     -1 -1;
     0 1;
     1 0.082078;
     -1 0.082078;
     0 -0.215160];
%}

% Validate D-criteria value (returns 45.6158 as presented in the
% publication). At present, its G-efficiency is 66.5008, max SPV = 9.0224.
% D = 100*det(F.'*F)^(1/6)/8;
% G = compute_g(X);

iterations = 1000;
designs = repmat({[]}, 1, iterations);
fvals = double.empty(iterations, 0);
run = double.empty(iterations, 0);

parpool('local')
tic
parfor i = 1:iterations

    design = gen_mat(12, 3);
    
    % Expand to Model Matrix
    F = x2fx(design, 'quadratic');
    
    % Now set up and run the point exchange
    
    iteration = 1;
    delta_G = 10000;  % Large value to enable loop entry
    tol = 0.01;  % Change based on desired precision
    design_spvs = cell(0,1); % To store the spvs of updated designs
    
    try
        while delta_G > tol
        
            % Get max SPV for previous iteration
            [g_curr, optimizer] = compute_g_pexch_k3(design);
            
    
            % This is the optimzer
            x_new = double(optimizer);
    
        
            % Append the optimizer to the matrix
            design_new = [design; x_new.'];
            
            % To store the max SPVS in the resultant matrices
            spvs = zeros(1,9);
        
            % Iteratively delete and re-score the matrix
            for j = 1:size(design_new, 1)
        
                % Remove a row from the new design matrix
                A = design_new;
                A(j, :) = [];
                
                % Compute the new g-efficiency
                spvs(j) = compute_g(A);
            end
            
            % Find the minimum max SPV
            min_spv = min(spvs);
            min_index = find(spvs == min_spv, 1);
        
            % Update the new design to be the best from the previous list
            design_new(min_index, :) = [];
            
            % Calculate the difference in old vs. new design
            delta_G = abs(compute_g(design_new) - compute_g(design));
            
            % Update all necessary variables
            design = design_new;
            design_spvs{iteration} = compute_g(design);
            iteration = iteration + 1;
            
        end 
    catch
        continue;
    end
    
    % Store the data
    designs{i} = design;
    fvals(i) = compute_g(design);
    run(i) = i;
end
toc

data = table(run(:), fvals(:));
csvwrite("data/k3n12_pexch_designs.csv", designs)
writetable(data, 'data/k3n12_pexch_efficiencies.csv');









