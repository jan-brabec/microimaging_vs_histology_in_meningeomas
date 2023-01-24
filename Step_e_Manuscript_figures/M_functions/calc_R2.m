function R2 = calc_R2(X,X_pred,ROI)
% function R2 = calc_R2(X,X_pred,ROI)
%
% Calculates R2
% We do regression y = ax^2 + bx + c and CNN comparison

if nargin < 3
    ROI = ones(size(X)); %if not ROI inputted take all into account
end

x  = X(ROI > 0);
x_pred = X_pred(ROI > 0);

if (1) %R2 by definition
    
    SS_res = sum((x - x_pred).^2);
    SS_tot = sum((x - mean(x)).^2);
    
    R2 = max(0, 1 - SS_res/SS_tot); %if below 0 -> add a constant term which makes it R=0
end

if (0) %Proportion of variance explained
    R2 = 1 - var(x - x_pred) / var(x);
end

if (0)
    %Pearson correlation coefficient squared is equal to coefficient of determination
    % for linear regression only, y = ax + b, but not generally for
    % multiple regression or non-linear regression
    c = corrcoef(x,x_pred);
    R2 =  c(2,1) .^2;
end

R2 = round(R2,2);


end
