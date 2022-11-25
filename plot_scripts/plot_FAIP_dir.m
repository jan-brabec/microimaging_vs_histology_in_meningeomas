clear; clf;

axs = 1;
load(fullfile('..','..','local_data','summary.mat'))
addpath('../M_functions')

idxs = 1:16;
% idxs = 5;

ha = tight_subplot(numel(idxs),2,[.01,.01],[.01,.01],[.01,.01]);
for idx = 1:numel(idxs)
    
    sample = idxs(idx);
    
    disp(sample)
    
    [lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,0.7);
    
    FA2D = process_map(sMR{sample}.FA2D,sROI{sample},lims_dir_FA2D,0);
    IA   = process_map(sHd{sample}.dIA,sROI{sample},lims_dir_IA,1);
    
    axes(ha(axs));
    I_dirs_MR = plot_IA_FAIP_dirs(FA2D,sMR{sample}.J_11,sMR{sample}.J_12,sMR{sample}.J_22,sROI{sample},lims_dir_FA2D);
    imagesc((I_dirs_MR))
    hold on
    axis image off
    
    axes(ha(axs+1));
    I_dirs_H = plot_IA_FAIP_dirs(IA,sHd{sample}.dJ_11,sHd{sample}.dJ_12,sHd{sample}.dJ_22,sROI{sample},lims_dir_IA);
    imagesc((I_dirs_H))
    
    axis image off
    hold on
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 2;
    
end

print(sprintf('FAIP_dirs.png'),'-dpng','-r500')