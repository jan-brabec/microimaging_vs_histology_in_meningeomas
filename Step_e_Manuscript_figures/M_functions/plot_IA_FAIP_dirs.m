function I_dirs = plot_IA_FAIP_dirs(I,J_11,J_12,J_22,ROI,c_lim)
% function I_dirs = plot_IA_FAIP_dirs(I,J_11,J_12,J_22,ROI,c_lim)
%
%   Returns image I_dirs to plot directions of IA and FA2D (in-plane).
%   I can be either IA or FA2D, c_lim is the scale limit of image
%   and J_?? derivative in respective directions (xx, yy, xy = yx).

I(isnan(I)) = 0; J_11(isnan(J_11)) = 0; J_12(isnan(J_12)) = 0; J_22(isnan(J_22)) = 0;

T0 = 1/2 * atan2(2 * J_12, J_11 - J_22);

if (1) %hue colormap instead of true RGB color
    T0 = (T0 + pi/2) / pi; %angles remapped from 0 (0 degrees) to 1 (180 degrees)
    
    if (1)
        Is = I.^(1/2); %rescale FA2D
        Ib = I.^(1/2); %rescale FA2D
    else
        %         I = I ./ max(I(:)); %original brightness
        Is = ones(size(T0))*0.6;
        Ib = ones(size(T0))*0.6;
    end
    
    
    I_dirs = cat(3,T0,Is,Ib);  % Hue: Angles in T0, Saturation: I, Brightness: I
    I_dirs = hsv2rgb(I_dirs);
end


if (0) %RGB true color
    I_dirs = abs(cat(3, I .* cos(T0), I .* sin(T0), zeros(size(T0))));
end

x = I_dirs(:,:,1);
y = I_dirs(:,:,2);
z = I_dirs(:,:,3);

x(isnan(x)) = 0;
y(isnan(y)) = 0;
z(isnan(z)) = 0;

x(ROI==0) = 255;
y(ROI==0) = 255;
z(ROI==0) = 255;

I_dirs(:,:,1) = x;
I_dirs(:,:,2) = y;
I_dirs(:,:,3) = z;

I_dirs = uint8(255 * I_dirs);
I_dirs = imadjust(I_dirs,[0 0 0; c_lim c_lim c_lim],[]);

if (0)
    imagesc(I_dirs)
    axis image off
end

end
