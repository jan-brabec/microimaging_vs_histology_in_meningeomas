function [FAd_SAd,J_11d,J_12d,J_22d] = downsample_SA_to_dSA(J_11,J_12,J_22,sz_FA,sz_SA)
% function [FAd_SAd,J_11d,J_12d,J_22d] = downsample_SA_to_dSA(J_11,J_12,J_22,FA,C_FA)
%
%   Downsamples partial derivatives to MR resolution.
%   Computes SA and FAIP resolution from downsampled partial derivatives.

sx = floor(sz_SA(1)/sz_FA(1));
sy = floor(sz_SA(2)/sz_FA(2));

FAd_SAd = zeros(floor(sz_FA(1)/sx),floor(sz_FA(2)/sy));

for i = 1:sz_FA(1)
    for j = 1:sz_FA(2)
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

FAd_SAd = get_FAIP_SA_from_J(J_11d,J_12d,J_22d);

end