% Two dimension grid evaluation
% -----------------------------
function[G] = two_var_g(F, x1, x2)
    var = [1 x1 x2 x1*x2 x1^2 x2^2];
    G = size(F, 1)*var*inv(F.'*F)*var.';
end