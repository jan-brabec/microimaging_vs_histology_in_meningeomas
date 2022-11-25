function sm_X = smooth_map(X,filter_sigma)
% function cFAs = smooth_map(FA,filter_sigma)
%
% Smooths computed  FA map because the diffusion is also smoothed. Copied
% function from mdm to ensure it does the same thing.

filter = fspecial('gaussian',[0 0] + round(max(filter_sigma) * 3)*2+1,filter_sigma);

% Smooth
sm_X = double(X);
sm_X = imfilter(X, filter);


end