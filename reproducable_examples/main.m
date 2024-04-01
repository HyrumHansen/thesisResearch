% Load everything, set seed for reproducability
dir = pwd;
[dir, ~, ~] = fileparts(dir); % Move up one directory
addpath(genpath(dir))
rng(123)

% Grab the design
[design, max_spv] = run_example("nm");

% Present the results
design_mat = mat2str(design);

sprintf("2-factor, 8-trial optimal design: ")
disp(design)

eff =  (600/max_spv)/87.95*100;
sprintf("G-Efficiency (wrt. Walsh 2022): %f ", eff)