function [X_pred,test_set_measured,test_set_predicted,test_set_usedforpred] = predict_map(X_from,X_measured,ROI,sample,what,ROI_test_set)
% function X_pred = predict_map(X,ROI,sample,FA2DorMD)
%
% Predicts map from CD->MD or IA->FA2D.

if nargin < 6
    ROI_test_set = NaN;
end

test_set_measured    = NaN;
test_set_predicted   = NaN;
test_set_usedforpred = NaN;

if what == 11 %CD-> MD or IA -> FAIP quadratic
    all = [X_from(:).^2 X_from(:)];
    mdl_all = fitlm(all(ROI>0,:), X_measured(ROI>0));
    X_pred = reshape([ones(size(X_from(:))) all] * mdl_all.Coefficients.Estimate, size(X_measured));
end

if what == 1101 %CD-> MD or IA -> FAIP quadratic but on a test set only
    test_set_size = 0.2; %20 %
    
    X_from2fit = X_from(ROI>0);
    X_measured2fit = X_measured(ROI>0);
    
    id_test_set = randperm(numel(X_from2fit), ceil(numel(X_from2fit) * test_set_size));
    ind_test_set = zeros(numel(X_from2fit),1);
    ind_test_set(id_test_set) = 1;
    
    test_set_measured = X_measured2fit(ind_test_set==1); %MD or FA2D measured
    test_set_usedforpred = X_from2fit(ind_test_set==1); %IA or CD
    
    X_from2fit = X_from2fit(ind_test_set==0);
    X_measured2fit = X_measured2fit(ind_test_set==0);
    
    all2fit = [X_from2fit.^2 X_from2fit];
    mdl_all = fitlm(all2fit, X_measured2fit);
    
    all     = [X_from(:).^2 X_from(:)];
    
    X_pred = reshape([ones(size(X_from(:))) all] * mdl_all.Coefficients.Estimate, size(X_measured));
    
    
    test_set_all     = [test_set_usedforpred(:).^2 test_set_usedforpred(:)];
    test_set_predicted = [ones(size(test_set_usedforpred(:))) test_set_all] * mdl_all.Coefficients.Estimate; %predicted values in the test set - MD_pred or FAIP_pred
end







%To validate what is best

if what == 91 %Linear
    all = [X_from(:)];
    mdl_all = fitlm(all(ROI>0,:), X_measured(ROI>0));
    X_pred = reshape([ones(size(X_from(:))) all] * mdl_all.Coefficients.Estimate, size(X_measured));
end

%what = 11 Quadratic

if what == 93 %Cubic
    all = [X_from(:).^3 X_from(:).^2 X_from(:)];
    mdl_all = fitlm(all(ROI>0,:), X_measured(ROI>0));
    X_pred = reshape([ones(size(X_from(:))) all] * mdl_all.Coefficients.Estimate, size(X_measured));
end

if what == 99 %MD - CD constrained quadratic
    t = X_from(ROI > 0);
    y = X_measured(ROI > 0);
    
    % Aeq * x = beq type of constrain,  here to set when CD == 0 then MD = max(MD)
    Aeq = [   0    0    1];
    beq = max(y);
    
    % A * x =< b type of constrain, here derivative is zero
    t_points = 100;
    t_eval = linspace(0,0.8,t_points)';
    A = [2*t_eval t_eval zeros(t_points,1)]; %Derivative of x^2 + x + c is 2x + c + 0 = b
    b = zeros(t_points,1);
    
    C = [t.^2 t ones(size(t))]; %3rd degree polynomial
    x_lsqlin1 = lsqlin(C,y,A,b,Aeq,beq);
    
    X_pred = reshape([X_from(:).^2 X_from(:) ones(size(X_from(:)))] * x_lsqlin1, size(X_measured));
end

if what == 98 %FA2D from IA linear no intercept
    
    mdl = fitlm(X_from(ROI > 0),X_measured(ROI > 0),'Intercept',false);
    X_pred = mdl.Coefficients.Estimate(1) .* X_from;
    
end



end