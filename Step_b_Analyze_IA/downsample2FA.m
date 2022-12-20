function FAC = downsample2FA(J_11,J_12,J_22,FA,C_FA)
% function FA = downsample2microFA(J_11,J_12,J_22,FA,C_FA)
%
%
%J_11 = D_xx
%J_22 = D_yy
%J_33 = D_zz (not present, 2D images)
%J_12 = D_xy = D_yx
%
% L1 = lambda_1 = first  eigenvalue
% L2 = lambda_2 = second eigenvalue

[L1,L2] = get_L1L2_from_J(J_11,J_12,J_22);

sx = floor(size(C_FA,1)/size(FA,1));
sy = floor(size(C_FA,2)/size(FA,2));

CM = zeros(floor(size(FA,1)/sx),floor(size(FA,2)/sy));
FAC = zeros(floor(size(FA,1)/sx),floor(size(FA,2)/sy));

for i = 1:size(FA,1)
    for j = 1:size(FA,2)
        idx = (i*sx-sx+1) : sx*i; %region in x direction
        idy = (j*sy-sy+1) : sy*j; %region in y direction
        
        l1 = L1(idx,idy);
        l1 = l1(:); %unwrapped lambda_1 = xx along 1st dim
        l1 = sum(l1);
        
        l2 = L2(idx,idy);
        l2 = l2(:); %unwrapped lambda_2 = yy along 1st dim
        l2 = sum(l2);
        
        n = 1/2 * sum(l1^2 + l2^2) - (1/2 * sum(l1 + l2))^2;
        d = 1/2 * sum(l1^2 + l2^2);
        
        CM(i,j) = 3/2 * n/d;
        
        if isnan(CM(i,j))
            CM(i,j) = 0;
        end
        
    end
end

FAC = sqrt(CM);

end