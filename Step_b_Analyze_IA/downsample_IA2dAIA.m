function [FAd,J_11d,J_12d,J_22d] = downsample_IA2dAIA(J_11,J_12,J_22,FA,IA)
% function [FAd,J_11d,J_12d,J_22d] = downsample_IA2dAIA(J_11,J_12,J_22,FA,C_FA)
%
%   Downsamples computed IA to measured FA resolution via tensor.
%   IA and FA are only used for sizes.

sx = floor(size(IA,1)/size(FA,1));
sy = floor(size(IA,2)/size(FA,2));

FAd = zeros(floor(size(FA,1)/sx),floor(size(FA,2)/sy));

for i = 1:size(FA,1)
    for j = 1:size(FA,2)
        idx = (i*sx-sx+1) : sx*i;
        idy = (j*sy-sy+1) : sy*j;
        J_11d(i,j) = nansum(nansum(J_11(idx,idy),1),2);
        J_12d(i,j) = nansum(nansum(J_12(idx,idy),1),2);
        J_22d(i,j) = nansum(nansum(J_22(idx,idy),1),2);
        
        J_11d(i,j) = J_11d(i,j)/(numel(idx(~isnan(idx)))*numel(idy(~isnan(idy))));
        J_12d(i,j) = J_12d(i,j)/(numel(idx(~isnan(idx)))*numel(idy(~isnan(idy))));
        J_22d(i,j) = J_22d(i,j)/(numel(idx(~isnan(idx)))*numel(idy(~isnan(idy))));
    end
end

FAd = get_FA2D_IA_from_J(J_11d,J_12d,J_22d);
end