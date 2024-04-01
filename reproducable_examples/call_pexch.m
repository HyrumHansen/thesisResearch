function[design, g_score] = call_pexch(design)    

    % Set up and run the point exchange
    delta_G = 10000;  % Large value to enable loop entry
    tol = 0.01;  % Can be modified to increase level of precision

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
        g_score = compute_g(design);
        
    end 
    
end