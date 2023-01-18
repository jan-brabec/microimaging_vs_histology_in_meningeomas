clear; clf;

axs = 1;
load(fullfile('..','summary.mat'))
addpath('../M_functions')

% idxs = [9 5 6 15 13 4 16 1 8 11 3 10 12 2 14 7];
idxs = 1:16;

ha = tight_subplot(numel(idxs),4,[.03,.01],[.02,.05],[.03,.01]);
for idx = 1:numel(idxs)
    
    sample = idxs(idx);
    
    disp(sample)
    
    lims_scatter  = 1;
    dif_lims = 0.5;
    [lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.6);
    
    SA   = process_map(sHd{sample}.dIA,sROI{sample},lims_dir_SA,1);
    FAIP = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);    
    
    FAIP_pred = predict_map(SA,FAIP,sROI{sample},sample,11);
    FAIP_pred = process_map(FAIP_pred,sROI{sample},lims_dir_FAIP,0);
    [dif_IA,c_map_SA] = make_dif_map(FAIP,FAIP_pred,sROI{sample},dif_lims);
    
    axes(ha(axs));
    imagesc(SA)
    axis image off
    colormap(ha(axs), 'gray');
    caxis([0 lims_dir_SA])
    
    axes(ha(axs+1));
    imagesc(FAIP)
    axis image off
    colormap(ha(axs+1), 'gray');
    caxis([0 lims_dir_FAIP])
    
    axes(ha(axs+2));
    imagesc(FAIP_pred)
    axis image off
    colormap(ha(axs+2), 'gray');
    caxis([0 lims_dir_FAIP])
    
    axes(ha(axs+3));
    imagesc(dif_IA);
    colormap(ha(axs+3), c_map_SA);
    caxis([-dif_lims dif_lims])
    axis image off
    
    
    
    
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 4;
end


print('FAIP_overview.png','-dpng','-r500')

