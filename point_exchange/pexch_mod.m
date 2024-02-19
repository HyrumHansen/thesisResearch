iterations = 1000;
designs = repmat({[]}, 1, iterations);
fvals = double.empty(iterations, 0);
run = double.empty(iterations, 0);

parpool('local')
tic
parfor i = 1:iterations

    % Generate a random design as a starting point
    design = gen_mat(8, 2);
    
    proposed_design = design; % This is the design we will be modifying
    delta_G = 10000;  % Large value to enable loop entry
    tol = 0.01;  % Change based on desired precision
    
    try
        while delta_G > tol
        
            % Store last iteration's design
            old_design = design;
        
            % Iteratively delete and re-score the matrix
            for j = 1:size(design, 1)
            
                % Get max SPV for previous iteration
                [spv_curr, optimizer] = compute_g_pexch_k2(design);
            
                % This is the optimzer
                x_new = double(optimizer);
            
                % Replace row j in the design matrix
                proposed_design(j, :) = x_new;
            
                % Compute max SPV of resultant design
                spv_new = compute_g(proposed_design);
                
                if spv_new < spv_curr
                    % If resultant design is better, keep it!
                    design = proposed_design;
                else
                    % Reset the proposed design if it's not better
                    proposed_design = design;
                end
            end
            
            % Re-calculate delta_G to determine termination
            delta_G = abs(compute_g(old_design) - compute_g(design));
        end
    catch
        continue;
    end


     % Store the data
    designs{i} = design;
    fvals(i) = spv_curr;
    run(i) = i;
end
toc

data = table(run(:), fvals(:));
csvwrite("data/k2n8_pexch_mod_designs.csv", designs)
writetable(data, 'data/k2n8_pexch_mod_efficiencies.csv');


