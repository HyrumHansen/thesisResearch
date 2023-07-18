% Function to create a random matrix
function[X] = gen_mat(N, K)
   
    % Get N*K random values from [-1,1] uniform
    vals = -1 + (1+1)*rand(N*K, 1);

    % Schlep em' in a cute lil' matrix
    X = cell(N, K);
    for i = 1:N
        for j = 1:K
            X{i,j} = vals(i*j);
        end
    end
    
    X = cell2mat(X);

end