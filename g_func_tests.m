% Script to test my g efficiency functions on known optimal designs
% -----------------------------------------------------------------

dat = readtable('walsh_data.csv');

X = data_reader(dat(8,4));

F = x2fx(X, 'quadratic');

compute_g(F, 2, 4)
compute_g_grid(F, 2)