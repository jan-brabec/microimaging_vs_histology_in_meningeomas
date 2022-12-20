function CD = make_celldensity_map(pos,sz_H,sz_MR)
% function bind = downsample_celldensity(I_H,C_MD)
%   Downsamples computed cell mask to measured MD resolution

sx = floor(sz_H(1)/sz_MR(1));
sy = floor(sz_H(2)/sz_MR(2));

k(:,1) = pos.Centroid_X_px;
k(:,2) = pos.Centroid_Y_px;

for i = 1:sz_MR(1)
    for j = 1:sz_MR(2)
        
        idx = (i*sx-sx+1) : sx*i;
        idy = (j*sy-sy+1) : sy*j;
        
        ind = find(k(:,2) < max(idx) & k(:,2) > min(idx) &  k(:,1) < max(idy) & k(:,1) > min(idy));
        CD(i,j) = numel(ind);
        
    end
end

CD = CD ./ max(CD(:));

end