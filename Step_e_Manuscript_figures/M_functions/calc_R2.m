function R2 = calc_R2(X,X_pred,ROI)
% function R2 = calc_R2(X,X_pred,ROI)
%
% Calculates R2
% We do regression y = ax^2 + bx + c and CNN comparison
% Provide only values in the test set to get out-of-sample R2.

if nargin < 3
    ROI = ones(size(X)); %if not ROI inputted take all into account
end

x  = X(ROI > 0);
x_pred = X_pred(ROI > 0);

if (0) %R2 by definition
    
    SS_res = calc_MSE(x,x_pred);
    SS_tot = calc_MSE(x,mean(x));
    
    R2 = 1 - SS_res/SS_tot;
end


% Alternative definitions of R2:
if (0) %Proportion of variance explained
    R2 = 1 - var(x - x_pred) / var(x);
end

if (1)
    %Pearson correlation coefficient squared is equal to coefficient of determination
    % for linear regression only, y = ax + b, but not generally for
    % multiple regression or non-linear regression
    c = corrcoef(x,x_pred);
    R2 =  c(2,1) .^2;
end


R2 = round(R2,2);


end
