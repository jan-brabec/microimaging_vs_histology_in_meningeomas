function X = process_map(X,ROI,lims,smooth)
% function X = process_map(X,ROI,lims,prediction)
%
% Processes map in a standard way.

if smooth == 1
    
    X(isnan(X)) = 0;
    X = X .* ROI;
    
    filter_sigma = 0.5;
    X = smooth_map(X,filter_sigma);
end


%to show in the image, outside of ROI not considered anyway for
%prediction or R2 calculations

X(isnan(X)) = 0;
X = X .* ROI;
X(ROI == 0) = lims;

end

