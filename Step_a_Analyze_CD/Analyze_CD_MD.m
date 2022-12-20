if (1)
    o_pth_sum  = fullfile('..','data','summary.mat');
    load(o_pth_sum,'sCD', 'sCDA_raw', 'sHd', 'sHEd', 'sMD_pred', 'sMR', 'sROI')
end


for sample = 3:3
    
    if (0)
        
        disp(sample)
        clearvars -except sample sHd sMR sROI sHEd sCD sCDA_raw sHd sHEd sMD_pred sMR sROI o_pth_sum sz_HE
        clf
        
        load(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','MR.mat'));
        load(fullfile('..','data',strcat(num2str(sample)),'coreg_fine','ver1','HE.mat'));
        pos = tdfread(fullfile('data',strcat(num2str(sample)),'measurements.tsv'));
        
        CDa  = make_celldensity_map(pos,size(HE),size(MR.MD));
    end
    
    addpath('../zAnalyze_FA2D');
    
    CDa(isnan(CDa)) = 0;
    CD = smooth_FA_IA_CD(CDa,0.5);
    
    CD_lims = 1;
    dif_lims=0.5;
    
    if sample ~= 3
        MD_lims = 1;
    else
        MD_lims = 2;
    end
    
    addpath('../zAnalyze_IA');
    ROI = get_ROI(sample,MR.ROI,dHE_mask);
    
    %
    mkdir(num2str(sample))
    MR_ROI = MR.ROI;
    Final_ROI = ROI;
    save(fullfile(num2str(sample),'ROIs'),'HE_mask','dHE_mask','MR_ROI','Final_ROI')
    %
    
    %Mask all relevant and deal with computed NaNs = 0
    CD(isnan(CD)) = 0;
    CD = CD .* ROI;
    CD(ROI == 0) = -CD_lims; %just not to show in the image
    
    MD = MR.MD;
    MD(isnan(MD)) = 0;
    MD = MD .* ROI;
    MD(ROI == 0) = MD_lims;  %just not to show in the image
    
    %HE already masked in the previous step
    
    %Prediction
    if sample ~= 3
        
        mdl = fitlm(CD(ROI > 0),MD(ROI > 0));
        MD_pred = reshape([ones(size(CD(:))) CD(:)] * mdl.Coefficients.Estimate, size(CD));
        
    else
        t = CD(ROI > 0);
        y = MD(ROI > 0);
        
        % Aeq * x = beq constrain
        Aeq = [   0    0    1];   % when = 0
        beq = max(y);
        
        % A * x =< b %constrain, here derivative is zero
        t_eval = linspace(0,0.8,10)';
        A = [2*t_eval t_eval zeros(10,1)]; %Derivative of x^2 + x + c is 2x + c + 0 = b
        b = zeros(10,1);
        
        C = [t.^2 t ones(size(t))]; %3rd degree polynomial
        x_lsqlin1 = lsqlin(C,y,A,b,Aeq,beq);
        
        MD_pred = reshape([CD(:).^2 CD(:) ones(size(CD(:)))] * x_lsqlin1, size(MD));
        
    end
    
    
    MD_pred = MD_pred .* ROI;
    MD_pred(ROI == 0) = MD_lims;
    
    dif = MD - MD_pred;
    dif(ROI == 0) = -dif_lims;
    
    clf;
    
    subplot(3,3,1)
    imagesc(imcomplement(CD))
    axis image off
    colormap gray
    caxis([0 CD_lims])
    colorbar
    title('Complement CD masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,2)
    imagesc(MD)
    axis image off
    colormap gray
    caxis([0 MD_lims])
    colorbar
    title('MD masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,3)
    CD2 = CD;
    CD2(ROI == 0) = CD_lims;
    imagesc(CD2)
    axis image off
    colormap gray
    caxis([0 CD_lims])
    colorbar
    title('CD masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,4)
    imagesc(HE)
    axis image off
    title('HE masked on HE ROI')
    
    subplot(3,3,5);
    imagesc(MD_pred)
    axis image off
    caxis([0 MD_lims])
    colorbar
    title('MD predicted, linear, from inside ROIs only, masked on MR, HE ROIs, eroded ROI')
    
    subplot(3,3,6)
    scatter(CD(ROI > 0),MD(ROI > 0));
    xlabel('CD inside ROIs')
    ylabel('MD inside ROIs')
    xlim([0 1])
    ylim([0 2])
    hold on
    
    plot(CD(ROI > 0),MD_pred(ROI > 0),'.','Markersize',10);
    a = corrcoef(CD(ROI > 0),MD(ROI > 0));
    a = a(2,1);
    title(sprintf('Scatter CD vs MD inside ROIs; R = %0.2f, R^2 = %0.2f',a, a.^2));
    
    ax = subplot(3,3,8);
    imagesc(dif);
    
    redgreencmap_e = redgreencmap;
    redgreencmap_e(1:1,1)=1; redgreencmap_e(1:1,2)=1; redgreencmap_e(1:1,3)=1;
    redgreencmap_e(200:256,1)=1;
    custom_colormap = redgreencmap_e.^3;
    colormap(ax, custom_colormap);
    colorbar;
    caxis([-dif_lims dif_lims])
    axis image off
    title('Error map masked on MR, HE ROIs, eroded ROI')
    
    set(gcf,'color','w');
    drawnow;
    saveas(gcf,['Fig_CD_MD_' num2str(sample),'.png'])
    
    
    %Save finals for plotting
    if (0)
        sCD{sample} = CD;
        sCDA_raw{sample} = CDa;
        sMD_pred{sample} = MD_pred;
        sz_HE{sample} = size(HE);
    end
    %     figure;
    %     mn_check_result_6_options_CD_MD(HE,CD,MD,MD_pred,dif,CD_lims,dif_lims,MD_lims,custom_colormap,ROI)
end

if (0)
    o_pth_sum  = fullfile('..','data','summary.mat');
    save(o_pth_sum,'sCD','sCDA_raw','sMD_pred','sz_HE','-append')
end