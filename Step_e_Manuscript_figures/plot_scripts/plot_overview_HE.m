addpath(fullfile('..','M_functions'))
load(fullfile('..','..','local_data','summary.mat'))

clf; ha = tight_subplot(4,4,[.01,.01],[.01,.01],[.01,.01]);

o = [1 5 9 13 ...
     2 6 10 14 ...
     3 7 11 15 ...
     4 8 12 16];
 
for sample = 1:16
    axes(ha(o(sample)));
    hold on;
    
    disp(sample)
    
    hold on;
    imagesc(flipud(sHEd{sample}))
    axis image off
end