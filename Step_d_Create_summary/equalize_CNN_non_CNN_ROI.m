function ROI_CNN = equalize_CNN_non_CNN_ROI(MD_meas_CNN,MD_meas,ROI_no_CNN)
% function ROI_CNN = equalize_CNN_non_CNN_ROI(MD_meas_CNN,MD_meas,ROI_no_CNN)
%
% ROI equalizes because it was a bit different

addpath('../Step_e_Manuscript_figures/M_functions')

MD_lims = 1;

MD_meas     = process_map(MD_meas    ,ROI_no_CNN,MD_lims,0);
MD_meas_CNN = process_map(MD_meas_CNN,ROI_no_CNN,MD_lims,0);

dif = ones(size(ROI_no_CNN));
dif(abs(MD_meas - MD_meas_CNN) > eps) = 0;

ROI_CNN = ROI_no_CNN .* dif;

if (0) %print difference between CNN ROI and "our" ROI
    axs = 1;
    ha = tight_subplot(1,5,[.01,.01],[.01,.01],[.01,.01]);

    axes(ha(axs));
    imagesc(MD_meas)
    axis image off
    colormap(ha(axs), 'gray');
    caxis([0 MD_lims])
    
    axes(ha(axs+1));
    imagesc(MD_meas_CNN)
    axis image off
    colormap(ha(axs+1), 'gray');
    caxis([0 MD_lims])
    
    axes(ha(axs+2));
    imagesc(dif)
    colormap(ha(axs+2), 'gray');
    caxis([0 1])
    axis image off
    
    axes(ha(axs+3));
    imagesc(ROI_no_CNN)
    colormap(ha(axs+3), 'gray');
    caxis([0 1])
    axis image off
    
    axes(ha(axs+4));
    imagesc(ROI_CNN)
    colormap(ha(axs+4), 'gray');
    caxis([0 1])
    axis image off
    
    set(gcf,'color','w');
    drawnow;
    
    axs = axs + 5;
    
end



end

