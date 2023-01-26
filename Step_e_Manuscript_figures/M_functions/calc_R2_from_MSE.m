function R2 = calc_R2_from_MSE(SSE_method,SSE_benchmark)
% function RR2 = calc_R2_from_MSE(SSE_method,SSE_benchmark)
%
% Calculates relative coefficient of determination (RR2).
% Provide SSE only in the test set to calculte out-of-sample RR2.
% To obtain R2 select SSE_benchmark to be mean-sample-model
% To obtain relative R2 select SSE_benchmark to be the
% competing model such as CNN.

R2 = 1 - SSE_method./SSE_benchmark;

end