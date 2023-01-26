function MSE = calc_MSE(A,B)
% function MSE = calc_MSE(A,B)
%  
% Calculates sum of squared errors between A and B

MSE = mean((A - B).^2);

end

