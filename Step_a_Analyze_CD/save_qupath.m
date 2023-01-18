% This script will create a QuPath readable H&E histology image.
% This will save .mat files as jpg files.
%
% Run this after you create a QuPath project in the folder
% /data/<sample_number>/QuPath
% QuPath needs an empty folder to create a new project.

clear; clc;

for sample = 2:2
    
    disp(sample)
    
    i_path  = fullfile('..','..','data',num2str(sample),'coreg_fine','ver1');
    o_path  = fullfile('..','..','data',num2str(sample),'cell_density','QuPath');
    
    H = load(fullfile(i_path,'HE.mat'),'HE');
    H = H.HE;
    
    imwrite(H,fullfile(o_path,'HE.jpg'),'Quality',100); %this works most of the time
    
    clearvars -except sample
end
