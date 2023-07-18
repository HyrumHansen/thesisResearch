% Step 1: Download gloptipoly3. Avaliable at this link:
%         www.laas.fr/∼henrion/software/gloptipoly3
%
% Step 2: Unzip the files into the MATLAB folder on your machine. 
%         Folder called Gloptipoly3 should be one level below MATLAB.
%
% Step 3: run addpath("gloptipoly3") in command window
%
% Step 4: Grab SeDuMi 1.3. I grabbed the second link on this page:
%         https://sedumi.ie.lehigh.edu/?page_id=58
% 
% Step 5: Unzip, should be same as step 2. 
%
% Step 6: run addpath('SeDuMi_1_3'). 
% 
% Step 7: Scripts are dependent on a couple functions from the 'statistics
%         and machine learning' toolkit, particularly x2fx. Navigate to 
%         'HOME' tab, click "Add-Ons' in the 'ENVIRONMENT' bin. Search for
%         the toolkit and install. 
%
% Step 8: May need to restart Matlab for things to work, but at this point
%         all dependencies should be on your machine. 
%
% Step 9: Make sure that the folder I sent you is unzipped at the same
%         level as gloptipoly3 and SeDuMi_1_3. 
%
% Step 10: Run addpath("Thesis"). This is the folder I sent with all the
%          functions required to make everything work.


% Set random seed
rng(420)

% Continue drawing X from [-1,1] uniform until F.'F nonsingular
execute = true;
while execute
    X = gen_mat(8, 2);
    F = x2fx(X, 'quadratic');
    if det(F.'*F) > eps
        execute = false;
    end
end

% Compute G score using gloptipoly
compute_g(F, 2, 3)

% Compute G score using dense grid (100 points in [-1,1]). Can be 
% easily modified to increase or decrease density.
compute_g_grid(F, 2)

% Now, if you so choose you may proceed to the 'coordinate_exchange.m"
% folder to see a naive implementation of the algorithm. 