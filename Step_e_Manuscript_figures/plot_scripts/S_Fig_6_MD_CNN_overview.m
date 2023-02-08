clear; clf; 

%decrease in MD % 1 2 3 7 13
%no correlation % 12 8 15
%no correlation but systematic problems % 9 10 5 6
%coregistration errors % 4 13 14 16

addpath(fullfile('..','M_functions'));

idx = 1:16;

ha = tight_subplot(numel(idx),5,[.01,.01],[.01,.01],[.01,.01]);
load(fullfile('..','summary.mat'))
axs = 1;
for id = 1:numel(idx)
    sample = idx(id);
    
    disp(sample)
        
    CD_lims  = 1;
    dif_lims = 0.5;
    
    if sample == 3 
        MD_lims = 1.5;
    else
        MD_lims = 1;
    end
    
    MD_meas = process_map(sMR{sample}.MD,sROI{sample},MD_lims,0);
    
    CD = process_map(sCD{sample},sROI{sample},CD_lims,1);
    MD_pred_CD = predict_map(CD,MD_meas,sROI{sample},11);
    MD_pred_CD = process_map(MD_pred_CD,sROI{sample},MD_lims,0);
    
    MD_meas_CNN = process_map(sMD_CNN{sample}.I_measured,sROI{sample},MD_lims,0);    
    MD_pred_CNN = process_map(sMD_CNN{sample}.I_pred,sROI{sample},MD_lims,0);
    
    [dif_MD_CD, c_map_CD]   = make_dif_map(MD_meas,MD_pred_CD,sROI{sample},dif_lims);
    [dif_MD_CNN, c_map_CNN]   = make_dif_map(MD_meas_CNN,MD_pred_CNN,sROI{sample},dif_lims);
    
    axes(ha(axs));
    imagesc(MD_meas)
    axis image off
    colormap(ha(axs), 'gray');
    caxis([0 CD_lims])
    
    axes(ha(axs+1));
    imagesc(MD_pred_CD)
    axis image off
    colormap(ha(axs+1), 'gray');
    caxis([0 MD_lims])
    
    axes(ha(axs+2));
    imagesc(MD_pred_CNN)
    axis image off
    colormap(ha(axs+2), 'gray');
    caxis([0 MD_lims])    
    
    axes(ha(axs+3));
    imagesc(dif_MD_CD)
    colormap(ha(axs+3), c_map_CD);
    caxis([-dif_lims dif_lims])
    axis image off
    
    axes(ha(axs+4));
    imagesc(dif_MD_CNN);
    colormap(ha(axs+4), c_map_CD);
    caxis([-dif_lims dif_lims])
    axis image off
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 5;
end


print('MD_CNN_overview.png','-dpng','-r500')
