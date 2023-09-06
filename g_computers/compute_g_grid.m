% Compute G score using a grid approximation
% ------------------------------------------

function[g_score] = compute_g_grid(F, num_var)

    grid = -1:.01:1;

    % Expand the grid
    C = cell(num_var, 1);
    [C{:}] = ndgrid(grid);
    y = cellfun(@(x){x(:)}, C);
    y = [y{:}];

    % List to hold the scores
    grid_scores = double.empty(size(y, 1),0);
    
    % Calculate for each set of values in the grid
    for i = 1:size(y, 1)
        
        % Convert the y vector to be passed into function
        inputs = num2cell(y(i, 1:end));
        
        if num_var == 1
            g = one_var_g(F, inputs{:});
        elseif num_var == 2 
            g = two_var_g(F, inputs{:});
        elseif num_var == 3
            g = three_var_g(F, inputs{:});
        elseif num_var == 4
            g = four_var_g(F, inputs{:});
        elseif num_var == 5
            g = five_var_g(F, inputs{:});
        end

        % Append the g score for the current iteration to the list
        grid_scores(i) = g;
    end

    % Return the G efficiency of the design
    g_score = max(grid_scores);

end
