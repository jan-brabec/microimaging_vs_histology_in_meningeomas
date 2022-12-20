clear; clc;


for sample = 8:8
    
    disp(sample)
    
    path  = fullfile('..','data',num2str(sample),'coreg_fine','ver1');
    H = load(fullfile(path,'HE.mat'),'HE');
    H = H.HE;
    
    imwrite(H,fullfile(path,'HE.jpg'),'Quality',100); %this works most of the time
%     imwrite(H,fullfile(path,'HE.tif'),'Compression','none');
%     imwrite(H,fullfile(path,'HE.png'),'Compression','none');
    
    clearvars -except sample
end

clear