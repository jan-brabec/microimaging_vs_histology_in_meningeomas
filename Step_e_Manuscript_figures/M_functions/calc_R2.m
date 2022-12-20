function R2 = calc_R2(X,X_pred,ROI)
% function R2 = calc_R2(X,X_pred,ROI)
%
% Calculates R2

if nargin < 3
    ROI = ones(size(X)); %if not ROI inputted take all into account
end


c = corrcoef(X(ROI > 0),X_pred(ROI > 0));
R2 =  c(2,1) .^2;

if (0) %try to use this instead, why doesnt it work?
    R2 = 1 - var(X(ROI>0) - X_pred(ROI>0)) / var(X(ROI>0));
end

R2 = round(R2,2);



end
