clear; clf;

axs = 1;
load(fullfile('..','summary.mat'))
addpath('../M_functions')

% idxs = [9 5 6 15 13 4 16 1 8 11 3 10 12 2 14 7];
idxs = 1:16;

ha = tight_subplot(numel(idxs),2,[.01,.01],[.01,.01],[.01,.01]);
for idx = 1:numel(idxs)
    
    sample = idxs(idx);
    
    disp(sample)
    
    [lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.7);
    
    FAIP = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);
    SA   = process_map(sHd{sample}.dSA,sROI{sample},lims_dir_SA,1);
    
    axes(ha(axs));
    I_dirs_MR = plot_IA_FAIP_dirs(FAIP,sMR{sample}.J_11,sMR{sample}.J_12,sMR{sample}.J_22,sROI{sample},lims_dir_FAIP);
    imagesc((I_dirs_MR))
    hold on
    axis image off
    
    axes(ha(axs+1));
    I_dirs_H = plot_IA_FAIP_dirs(SA,sHd{sample}.dJ_11,sHd{sample}.dJ_12,sHd{sample}.dJ_22,sROI{sample},lims_dir_SA);
    imagesc((I_dirs_H))
    
    axis image off
    hold on
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 2;
    
end

print(sprintf('FAIP_dirs.png'),'-dpng','-r500')