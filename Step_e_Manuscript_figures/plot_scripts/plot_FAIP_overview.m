clear; clf;

axs = 1;
load(fullfile('..','..','local_data','summary.mat'))
addpath('../M_functions')

% idxs = [9 5 6 15 13 4 16 1 8 11 3 10 12 2 14 7];
idxs = 1:16;
idxs = [5 15 7 12 ];

ha = tight_subplot(numel(idxs),4,[.03,.01],[.02,.05],[.03,.01]);
for idx = 1:numel(idxs)
    
    sample = idxs(idx);
    
    disp(sample)
    
    lims_scatter  = 1;
    dif_lims = 0.5;
    [lims_dir_FA2D, lims_dir_IA] = get_dir_lims(sample,0.6);
    
    
    IA   = process_map(sHd{sample}.dIA,sROI_ver2{sample},lims_dir_IA,1);
    FA2D = process_map(sMR{sample}.FA2D,sROI_ver2{sample},lims_dir_FA2D,0);    
    
    FA2D_pred = predict_map(IA,FA2D,sROI_ver2{sample},sample,11);
    FA2D_pred = process_map(FA2D_pred,sROI_ver2{sample},lims_dir_FA2D,0);
    [dif_IA,c_map_IA] = make_dif_map(FA2D,FA2D_pred,sROI_ver2{sample},dif_lims);
    
    axes(ha(axs));
    imagesc(IA)
    axis image off
    colormap(ha(axs), 'gray');
    caxis([0 lims_dir_IA])
    
    axes(ha(axs+1));
    imagesc(FA2D)
    axis image off
    colormap(ha(axs+1), 'gray');
    caxis([0 lims_dir_FA2D])
    
    axes(ha(axs+2));
    imagesc(FA2D_pred)
    axis image off
    colormap(ha(axs+2), 'gray');
    caxis([0 lims_dir_FA2D])
    
    axes(ha(axs+3));
    imagesc(dif_IA);
    colormap(ha(axs+3), c_map_IA);
    caxis([-dif_lims dif_lims])
    axis image off
    
    
    
    
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 4;
end


print('FAIP_overview.png','-dpng','-r500')

