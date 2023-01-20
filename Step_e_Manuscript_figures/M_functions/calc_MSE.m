function MSE = calc_MSE(A,B)
% function MSE = calc_MSE(A,B)
%  
% Calculates mean squared error of A and B

MSE = mean((A - B).^2);

end

