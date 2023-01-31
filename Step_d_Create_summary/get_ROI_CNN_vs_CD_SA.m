function [sROI_c,stis_MD,stis_FAIP] = get_ROI_CNN_vs_CD_SA(sCD, sMR,sHd,sFAIP_CNN,sMD_CNN)
% function [ROI_c,ti] = ROI_CNN_vs_CD_SA(MD_meas_CD,MD_mean_CNN,FAIP_meas_SA,FAIP_meas_CNN)
%
%   Creates ROIs for comparison between CNN and plots them.
%   These were different because CNN was trained only in the middle of the
%   tumor sample without the tumor borders.

if nargin == 0
    summary_path  = fullfile('..','Step_e_Manuscript_figures','summary.mat');
    load(summary_path);
    [sROI_c,stis_MD,stis_FAIP] = get_ROI_CNN_vs_CD_SA(sCD, sMR,sHd,sFAIP_CNN,sMD_CNN);
    return;
end

for sample = 1:16
    
    tt_MD = sMD_CNN{sample}.I_test_ind;
    tt_FAIP = sFAIP_CNN{sample}.I_test_ind;
    
    ROI1 = logical(abs(sMR{sample}.FAIP-sFAIP_CNN{sample}.I_measured) < 1e-5);
    ROI2 = logical(abs(sMR{sample}.MD-sMD_CNN{sample}.I_measured) < 1e-5);
    
    ROI = ROI1 & ROI2;
    
    %Erase disconnected pixels, there are very few but it looks ugly
    [tmp,n] = bwlabel(ROI);
    tmp2 = sum(tmp(:)==1:n);
    ind = find(tmp2 == max(tmp2));
    ROI(tmp~=ind) = 0;
    %
    
    sROI_c{sample} = ROI;
    stis_MD{sample}   = tt_MD  & ROI ;
    stis_FAIP{sample} = tt_FAIP & ROI ;
    
end


if (1)
    
    v = {'CD','MD','SA','FAIP','MD_pred_CNN','FAIP_pred_CNN'};
    l = {'CD_lims','MD_lims','lims_dir_SA','lims_dir_FAIP','MD_lims','lims_dir_FAIP'};
    
    v = v{3};
    l = l{3};
    
    sROI_full = get_ROI_full();
    
    figure(125);
    clf;
    
    
    set(gcf, 'InvertHardCopy', 'off'); 
    set(gcf,'Color',[0 0 0]);
    
    ha = tight_subplot(4,4,[.01,.01],[.01,.01],[.01,.01]);
    
    axs = 1;
    for sample = 1:16
        
        [lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.6);
        CD_lims  = 1;
        if sample == 3
            MD_lims =  2;
        else
            MD_lims = 1;
        end
        
        SA   = process_map(sHd{sample}.dSA,[],lims_dir_SA,1);
        CD   = process_map(sCD{sample},sROI_full{sample},CD_lims,1);
        
        FAIP = process_map(sMR{sample}.FAIP,[],lims_dir_FAIP,0);
        MD   = process_map(sMR{sample}.MD,sROI_full{sample},MD_lims,0);
        
        FAIP_pred_CNN = process_map(sFAIP_CNN{sample}.I_pred,sROI_full{sample},lims_dir_FAIP,0);
        MD_pred_CNN = process_map(sMD_CNN{sample}.I_pred,sROI_full{sample},MD_lims,0);
        
        axes(ha(axs));
        imagesc(eval(v))
        hold on
        plot_roi(sROI_c{sample},'red')
%         plot_roi(sROI_full{sample}, 'yellow')
        colormap(ha(axs), 'gray');
        caxis([0 eval(l)])
        axis image off
        
        set(gcf,'color','k');
        drawnow;
        axs = axs + 1;
    end
    
    print(sprintf('ROIs.png'),'-dpng','-r300')
    
end



end

