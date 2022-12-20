


for sample = 1:16
    
    
    if (1)
        
        disp(sample)
        clearvars -except sample
        clf
        
        load(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','MR.mat'));
        load(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'));
    end
    
    if sample ~= 3
        MD_lims = 1;
    else
        MD_lims = 2;
    end
    
    addpath('../zAnalyze_IA')
    
    ROI = get_ROI(sample,MR.ROI,dHE_mask);
    
    FA2D_lims = 0.7;
    FA2D = MR.FA2D;
    FA2D(isnan(FA2D)) = 0;
    FA2D = FA2D .* ROI;
    FA2D(ROI == 0) = FA2D_lims;
    
    MD = MR.MD;
    MD(isnan(MD)) = 0;
    MD = MD .* ROI;
    MD(ROI == 0) = MD_lims;
    
    
    subplot(3,1,1)
    imagesc(HE)
    axis image off
    
    subplot(3,1,2)
    imagesc(MD)
    axis image off
    colormap gray
    caxis([0 MD_lims])
    
    subplot(3,1,3)
    imagesc(FA2D)
    axis image off
    colormap gray
    caxis([0 FA2D_lims])
    
    set(gcf,'color','w');
    drawnow;
    saveas(gcf,['Coreg_' num2str(sample),'.png'])
    
    %     figure;
    
end


