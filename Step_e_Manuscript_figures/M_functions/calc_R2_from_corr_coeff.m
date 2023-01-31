function R2 = calc_R2_from_corr_coeff(X,X_pred,ROI)
% function R2 = calc_R2_from_corr_coeff(X,X_pred,ROI)
%
% Calculates R2 as correlation coefficient squared
% We do regression y = ax^2 + bx + c and CNN comparison so this is
% technically correct only for linear regression.
% Provide only values in the test set to get out-of-sample R2.
% Pearson correlation coefficient squared is equal to coefficient of determination
% for linear regression only, y = ax + b, but not generally for
% multiple regression or non-linear regression.

if nargin < 3
    ROI = ones(size(X)); %if not ROI inputted take all into account
end

c = corrcoef(X(ROI > 0),X_pred(ROI > 0));
R2 =  c(2,1) .^2;

R2 = round(R2,2);

end
