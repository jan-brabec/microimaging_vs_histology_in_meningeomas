clear; clf; 


idx = [1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16];
% % idx = [1 2 3 7 13 12 8 15 9 10 5 6 4 14 11 16];

% idx = [3 7 ...
%        12 8 ...
%        10 5];


ha = tight_subplot(numel(idx),5,[.01,.01],[.01,.01],[.01,.01]);
load(fullfile('..','..','local_data','summary.mat'))
axs = 1;
for id = 1:numel(idx)
    sample = idx(id);
    
    disp(sample)
    
    addpath('../../zAnalyze_FAIP')
    
    CD_lims  = 1;
    dif_lims = 0.5;
    
    if sample == 3 
        MD_lims = 1.5;
    else
        MD_lims = 1;
    end
    
    MD_meas = process_map(sMR{sample}.MD,sROI_ver2{sample},MD_lims,0);
    
    CD = process_map(sCDA_raw{sample},sROI_ver2{sample},CD_lims,1);
    MD_pred_CD = predict_map(CD,MD_meas,sROI_ver2{sample},sample,11);
    MD_pred_CD = process_map(MD_pred_CD,sROI_ver2{sample},MD_lims,0);
    
    MD_pred_ML = process_map(sMD_ML{sample}.I_MD_pred,sROI_ver2{sample},MD_lims,0);
    
    [dif_MD_CD, c_map_CD]   = make_dif_map(MD_meas,MD_pred_CD,sROI_ver2{sample},dif_lims);
    [dif_MD_ML, c_map_ML]   = make_dif_map(MD_meas,MD_pred_ML,sROI_ver2{sample},dif_lims);
    
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
    imagesc(MD_pred_ML)
    axis image off
    colormap(ha(axs+2), 'gray');
    caxis([0 MD_lims])    
    
    axes(ha(axs+3));
    imagesc(dif_MD_CD)
    colormap(ha(axs+3), c_map_CD);
    caxis([-dif_lims dif_lims])
    axis image off
    
    axes(ha(axs+4));
    imagesc(dif_MD_ML);
    colormap(ha(axs+4), c_map_CD);
    caxis([-dif_lims dif_lims])
    axis image off
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 5;
end


print('MD_ML_overview.png','-dpng','-r500')
