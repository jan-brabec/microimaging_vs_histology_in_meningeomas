clear; clf;

axs = 1;
load(fullfile('..','summary.mat'))
addpath('../M_functions')

idxs = 1:16;
% idxs = 5;

ha = tight_subplot(numel(idxs),3,[.01,.01],[.01,.01],[.01,.01]);
for idx = 1:numel(idxs)
    
    sample = idxs(idx);
    
    disp(sample)
    
    lims_scatter  = 1;
    dif_lims = 0.5;
    [lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.6);
    
    SA   = process_map(sHd{sample}.dSA,sROI{sample},lims_dir_SA,1);
    FAIP = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);    
    
    FA = process_map(sMR{sample}.FA,sROI{sample},lims_dir_FAIP,0);  
    
    

    
    axes(ha(axs));
    imagesc(SA)
    axis image off
    colormap(ha(axs), 'gray');
    caxis([0 lims_dir_SA])
    
    axes(ha(axs+1));
    imagesc(FAIP)
    hold on
    axis image off
    colormap(ha(axs+1), 'gray');
    caxis([0 lims_dir_FAIP])
    
    axes(ha(axs+2));
    imagesc(FA)
    axis image off
    colormap(ha(axs+2), 'gray');
    caxis([0 lims_dir_FAIP])
    
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 3;
end


print('FA_FAIP_SA_overview.png','-dpng','-r500')

