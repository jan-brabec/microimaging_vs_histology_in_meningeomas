clear; clf; 

idx = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
% % idx = [1 2 3 7 13 12 8 15 9 10 5 6 4 14 11 16];


ha = tight_subplot(numel(idx),5,[.01,.01],[.01,.01],[.01,.01]);
load(fullfile('..','..','local_data','summary.mat'))
axs = 1;
for id = 1:numel(idx)
    sample = idx(id);
    
    disp(sample)
    
    addpath('../zAnalyze_FA2D')
        
    lims_scatter  = 1;
    dif_lims = 0.5;
    [lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,0.6);
    
    IA   = process_map(sHd{sample}.dIA,sROI_ver2{sample},lims_dir_IA,1);
    FA2D_meas = process_map(sMR{sample}.FA2D,sROI_ver2{sample},lims_dir_FA2D,0);    
    
    FA2D_pred_IA = predict_map(IA,FA2D_meas,sROI_ver2{sample},sample,11);
    FA2D_pred_IA = process_map(FA2D_pred_IA,sROI_ver2{sample},lims_dir_FA2D,0);
    
    FA2D_pred_ML = process_map(sFA2D_ML{sample}.I_pred,sROI_ver2{sample},lims_dir_FA2D,0);
    
    [dif_IA_IA, c_map_IA] = make_dif_map(FA2D_meas,FA2D_pred_IA,sROI_ver2{sample},dif_lims);
    [dif_MD_ML, c_map_ML] = make_dif_map(FA2D_meas,FA2D_pred_ML,sROI_ver2{sample},dif_lims);
    
    axes(ha(axs));
    imagesc(FA2D_meas)
    axis image off
    colormap(ha(axs), 'gray');
    caxis([0 lims_dir_FA2D])
    
    axes(ha(axs+1));
    imagesc(FA2D_pred_IA)
    axis image off
    colormap(ha(axs+1), 'gray');
    caxis([0 lims_dir_FA2D])
    
    axes(ha(axs+2));
    imagesc(FA2D_pred_ML)
    axis image off
    colormap(ha(axs+2), 'gray');
    caxis([0 lims_dir_FA2D])    
    
    axes(ha(axs+3));
    imagesc(dif_IA_IA)
    colormap(ha(axs+3), c_map_IA);
    caxis([-dif_lims dif_lims])
    axis image off
    
    axes(ha(axs+4));
    imagesc(dif_MD_ML);
    colormap(ha(axs+4), c_map_IA);
    caxis([-dif_lims dif_lims])
    axis image off
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 5;
end

print('FA2D_ML_overview.png','-dpng','-r500')
