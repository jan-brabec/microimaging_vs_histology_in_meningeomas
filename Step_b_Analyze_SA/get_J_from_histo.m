function [J_11,J_12,J_22] = get_J_from_histo(C_histo,cases)
% function [J_11,J_12,J_22] = get_J_from_histo(C_histo)
%
% Computes tensor from histological image.
%
% Written by Filip Szczepankiewicz (filip.szczepankiewicz@med.lu.se) based
% on code that was adapted from some other author.

A = single(mean(C_histo,3));

switch cases
    case 1 %the original one from Markus, use this for all
        h_size_1 = 9;
        sigma_1 = 1;
        
        h_size_2 = 51;
        sigma_2 = 30;
        
    case 2 %testing from here
        h_size_1 = 50;
        sigma_1 = 1;
        
        h_size_2 = 51;
        sigma_2 = 30;
        
    case 3 %1
        h_size_1 = 9;
        sigma_1 = 50;
        
        h_size_2 = 51;
        sigma_2 = 30;
        
    case 4
        h_size_1 = 9;
        sigma_1 = 1;
        
        h_size_2 = 1;
        sigma_2 = 30;
        
    case 5
        h_size_1 = 9;
        sigma_1 = 1;
        
        h_size_2 = 51;
        sigma_2 = 1;
        
end

f1 = fspecial('gaussian', [h_size_1 h_size_1], sigma_1); %for derivative
f2 = fspecial('gaussian', [h_size_2 h_size_2], sigma_2); %for masking

% make a mask to avoid edge effects
M = A > 230;
M = convn(single(M), f2, 'same');
M = M > 0.9;
M = convn(single(M), f2, 'same');
M = M > 0.1;
M = convn(single(M), f2, 'same');
M = M > 0.1;
M = ~M;

fx = repmat(linspace(-1,1,size(f1,1)),size(f1,2),1)  .* f1;
fy = repmat(linspace(-1,1,size(f1,1)),size(f1,2),1)' .* f1;

%This is the main part.
DX = convn(A, fx, 'same');
DY = convn(A, fy, 'same');

%This using masking
J_11 = convn(DX .* DX .* M, f2, 'same'); % xx
J_12 = convn(DY .* DX .* M, f2, 'same'); % xy
J_22 = convn(DY .* DY .* M, f2, 'same'); % yy

end