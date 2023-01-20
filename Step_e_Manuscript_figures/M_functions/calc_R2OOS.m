function R2OOS = calc_R2OOS(MSE_method,MSE_benchmark)
% function R2OOS = calc_R2OOS(MSE_method,MSE_benchmark)
%
% Calculated out of sample mean squared error.

R2OOS = 1 - MSE_method ./ MSE_benchmark;

end

