clear; clf; 

idx = 1:16;


ha = tight_subplot(numel(idx),5,[.01,.01],[.01,.01],[.01,.01]);
load(fullfile('..','summary.mat'))
axs = 1;
for id = 1:numel(idx)
    sample = idx(id);
    
    disp(sample)
    
    
        
    lims_scatter  = 1;
    dif_lims = 0.5;
    [lims_dir_FAIP, lims_dir_IA] = get_dir_lims(sample,0.6);
        
    SA   = process_map(sHd{sample}.dSA,sROI{sample},lims_dir_IA,1);
    FAIP_meas = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);    
    
    FAIP_pred_SA = predict_map(SA,FAIP_meas,sROI{sample},11);
    FAIP_pred_SA = process_map(FAIP_pred_SA,sROI{sample},lims_dir_FAIP,0);
    
    FAIP_meas_CNN = process_map(sFAIP_CNN{sample}.I_measured,sROI{sample},lims_dir_FAIP,0);    
    FAIP_pred_CNN = process_map(sFAIP_CNN{sample}.I_pred,sROI{sample},lims_dir_FAIP,0);
    
    [dif_SA_SA, c_map_SA] = make_dif_map(FAIP_meas,FAIP_pred_SA,sROI{sample},dif_lims);
    [dif_MD_CNN, c_map_CNN] = make_dif_map(FAIP_meas_CNN,FAIP_pred_CNN,sROI{sample},dif_lims);
    
    axes(ha(axs));
    imagesc(FAIP_meas)
    axis image off
    colormap(ha(axs), 'gray');
    caxis([0 lims_dir_FAIP])
    
    axes(ha(axs+1));
    imagesc(FAIP_pred_SA)
    axis image off
    colormap(ha(axs+1), 'gray');
    caxis([0 lims_dir_FAIP])
    
    axes(ha(axs+2));
    imagesc(FAIP_pred_CNN)
    axis image off
    colormap(ha(axs+2), 'gray');
    caxis([0 lims_dir_FAIP])    
    
    axes(ha(axs+3));
    imagesc(dif_SA_SA)
    colormap(ha(axs+3), c_map_SA);
    caxis([-dif_lims dif_lims])
    axis image off
    
    axes(ha(axs+4));
    imagesc(dif_MD_CNN);
    colormap(ha(axs+4), c_map_SA);
    caxis([-dif_lims dif_lims])
    axis image off
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 5;
end

print('FAIP_CNN_overview.png','-dpng','-r500')
