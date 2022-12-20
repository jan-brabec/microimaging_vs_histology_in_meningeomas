if (1)
    o_pth_sum  = fullfile('..','data','summary.mat');
    load(o_pth_sum,'sCD', 'sCDA_raw', 'sHd', 'sHEd', 'sMD_pred', 'sMR', 'sROI')
end

for sample = 16:16
    
    disp(sample)
    
    if (1)
        clearvars -except sample sHd sMR sROI sHEd sCD sCDA_raw sHd sHEd sMD_pred sMR sROI o_pth_sum
        i_pth_FA_IA  = fullfile('..','data',num2str(sample),'anisotropy','ver1');
        load(fullfile(i_pth_FA_IA,'IA.mat'),'H','MR')
        disp('     IA loaded')
        i_pth_HE  = fullfile('..','data',num2str(sample),'coreg_fine','ver1');
        load(fullfile(i_pth_HE,'HE.mat'),'HE','dHE_mask')
        disp('     HE loaded')
    end
    disp('     all loaded')
    
    lims = 0.5;
    lims_dir_MR = 0.3;
    lims_dir_H  = 0.5;
    
    ROI = get_ROI(sample,MR.ROI,dHE_mask);
    
    %Mask all relevant and deal with computed NaNs = 0
    H.dIA(isnan(H.dIA)) = 0;
    IA = smooth_FA_IA_CD(H.dIA,0.5); %smoothed kernel 0.5 and downsampled
    IA(isnan(IA)) = 0;
    IA = IA .* ROI;
    IA(ROI == 0) = lims; %just not to show in the image
    
    FA2D = MR.FA2D;
    FA2D(isnan(FA2D)) = 0;
    FA2D = FA2D .* ROI;
    FA2D(ROI == 0) = lims;  %just not to show in the image
    
    FA = MR.FA; %no NaNs here but just to make sure
    FA(isnan(FA)) = 0;
    FA = FA .* ROI;
    FA(ROI == 0) = lims;  %just not to show in the image
    
    %HE already masked in the previous step
    mdl = fitlm(IA(ROI > 0),FA2D(ROI > 0),'Intercept',false);
    FA2D_pred = mdl.Coefficients.Estimate(1) .* IA;
    
    FA2D_pred = FA2D_pred .* ROI;
    FA2D_pred(ROI == 0) = lims;
    
    dif = FA2D  - FA2D_pred;
    dif(ROI == 0) = -lims;
    
    clf;
    subplot(3,3,1)
    imagesc(IA)
    axis image off
    colormap gray
    caxis([0 lims])
    colorbar
    title('IA masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,2)
    imagesc(FA2D)
    axis image off
    colormap gray
    caxis([0 lims])
    colorbar
    title('FA2D masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,3)
    imagesc(FA)
    axis image off
    colormap gray
    caxis([0 lims])
    colorbar
    title('FA masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,4)
    imagesc(HE)
    axis image off
    title('HE masked on HE ROI')
    
    subplot(3,3,5);
    imagesc(FA2D_pred)
    axis image off
    caxis([0 lims])
    colorbar
    title('FA2D predicted, linear, from inside ROIs only, masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,7)
    scatter(IA(ROI > 0),FA2D(ROI > 0),2);
    xlabel('IA inside ROIs')
    ylabel('FA2D inside ROIs')
    hold on
    
    plot(IA(ROI > 0),FA2D_pred(ROI > 0),'Linewidth',2);
    a = corrcoef(IA(ROI > 0),FA2D(ROI > 0));
    a = a(2,1);
    title(sprintf('Scatter IA vs FA2D inside ROIs; R = %0.2f, R^2 = %0.2f',a, a.^2));
    
    ax = subplot(3,3,8);
    imagesc(dif);
    
    redgreencmap_e = redgreencmap;
    redgreencmap_e(1:1,1)=1; redgreencmap_e(1:1,2)=1; redgreencmap_e(1:1,3)=1;
    redgreencmap_e(200:256,1)=1;
    custom_colormap = redgreencmap_e.^3;
    colormap(ax, custom_colormap);
    colorbar;
    caxis([-lims lims])
    axis image off
    title('Error map masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,6)
    I_dirs_MR = plot_IA_FA_dirs(FA2D,MR.J_11,MR.J_12,MR.J_22,ROI,lims_dir_MR);
    imagesc(I_dirs_MR)
    hold on
    axis image off
    title('Direction encoded color map of FA2D, green up-bottom, red left-right')
    
    subplot(3,3,9)
    I_dirs_H = plot_IA_FA_dirs(IA,H.dJ_11,H.dJ_12,H.dJ_22,ROI,lims_dir_H);
    imagesc(I_dirs_H)
    axis image off
    hold on
    title('Direction encoded color map of IA, green up-bottom, red left-right')
    
    set(gcf,'color','w');
    drawnow;
    saveas(gcf,['Fig_IA_FA_' num2str(sample),'.png'])
    
    if (1)
        %Save finals for plotting
        sHd{sample}.dJ_11 = H.dJ_11;
        sHd{sample}.dJ_12 = H.dJ_12;
        sHd{sample}.dJ_22 = H.dJ_22;
        sHd{sample}.dIA = H.dIA;
        
        sMR{sample}  = MR;
        sROI{sample} = ROI;
        sHEd{sample} = HE(1:10:end,1:10:end,:);
    end
    %     figure;
    %     mn_check_result_6_options(HE,IA,FA2D,FA,FA2D_pred,dif,lims,custom_colormap)
    
end

if (1)
    disp('     Saving to struct')
    save(o_pth_sum,'sMR','sROI','sHd','sHEd','-append')
    disp('     Saving to struct complete')
end

