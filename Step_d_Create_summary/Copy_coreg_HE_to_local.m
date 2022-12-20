%Copy all files to a local HDD from external HDD after coregistering

clear; clc;

i_path = '/Volumes/ExtHDD4/PhD/Meningioma_ex-vivo_manuscript/data';
o_path = '/Users/jb/Documents/Local/Microimaging/local_data';

for sample=7:8
    
    disp(sample);
    
    i_fn = fullfile(i_path,num2str(sample),'coreg_fine','ver1','HE.mat');
    o_fn = fullfile(o_path,num2str(sample),'coreg_fine','ver1','HE.mat');
    
    copyfile(i_path,o_path);
end