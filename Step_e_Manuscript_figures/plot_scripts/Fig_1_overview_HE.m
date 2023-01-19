clear; clf;

i_data_pth = fullfile('..','..','..','data');

ha = tight_subplot(4,4,[.01,.01],[.01,.01],[.01,.01]);

for sample = 1:16
    disp(sample)
    
    axes(ha(sample));
    hold on;
    
    i_pth_HE  = fullfile(i_data_pth,num2str(sample),'coreg_fine','ver1');
    load(fullfile(i_pth_HE,'HE.mat'),'HE');
    
    hold on;
    imagesc(flipud(HE))
    axis image off
end

print(sprintf('HE_overview.png'),'-dpng','-r500')
