% One dimension grid evaluation
% -----------------------------
function[G] = one_var_g(F, x1)
    var = [1 x1 x1^2];
    G = size(F, 1)*var*inv(F.'*F)*var.';
end