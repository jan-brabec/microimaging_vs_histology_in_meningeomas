function [dif_X,c_map] = make_dif_map(X,X_pred,ROI,lims)
% function [dif_X,c_map] = make_dif_map(X,X_pred,ROI,lims)
%
% Creates a difference map and a color map.

dif_X = X - X_pred;

dif_X(ROI == 1 & dif_X <- lims + 0.01 ) = -lims + 0.02; %for plotting
dif_X(ROI == 0) = -lims;

c_map = redgreencmap;
c_map(1:1,1)=1; c_map(1:1,2)=1; c_map(1:1,3)=1;
c_map(200:256,1)=1;
c_map = c_map.^2;

end

