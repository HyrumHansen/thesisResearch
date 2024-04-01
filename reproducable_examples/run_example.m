%% REPRODUCABLE EXAMPLE %%

function[design, max_spv] = run_example(algorithm)

    %  STEP 1: Draw a random starting matrix. This matrix must produce a
    %  model matrix that has a numerically stable inverse in order to
    %  proceed.
    % -------------------------------------------------------------------
    execute = true;
    while execute
        X = gen_mat(8, 2);
        F = x2fx(X, 'quadratic');
        if det(F.'*F) > eps^3
            execute = false;
        end
    end

   
    % STEP 2: The input argument specifies which algorithm to use.
    %--------------------------------------------------------------------
    if algorithm == "pso"
        [design, max_spv] = call_pso();
    elseif algorithm == "nm"
        [design, max_spv] = call_nm(X);
        design = reshape(design, 8, 2);
    elseif algorithm == "pexch"
        [design, max_spv] = call_pexch(X);
    end 
    
end