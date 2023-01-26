clear; clc; load(fullfile('..','summary.mat'))
addpath('../M_functions')

for sample = 1:16
    
    disp(sample)
    
    %CNN part
    part = 4;
    ROI_path = fullfile('..','..','Step_c_Analyze_CNN','output_mat_new');
    f_name = strcat('MAT_dan_individual_FA2D_efficientnet_v2_2_s',num2str(sample),'_p',num2str(part),'.mat');
    load(fullfile(ROI_path,f_name));
    
    tt = test_positions_map';
    tt(sROI{sample} == 0) = 0;
    
    MSE_CNN      = calc_MSE(sFAIP_CNN{sample}.I_measured(tt==1),sFAIP_CNN{sample}.I_pred(tt==1));
    MSE_CNN_mean = calc_MSE(sFAIP_CNN{sample}.I_measured(tt==1),mean(sFAIP_CNN{sample}.I_measured(tt==1)));
    
    R2OS_CNN(sample) = calc_R2_from_MSE(MSE_CNN,MSE_CNN_mean);
%     R2OS_CNN(sample) = calc_R2(sFAIP_CNN{sample}.I_measured(tt==1),sFAIP_CNN{sample}.I_pred(tt==1));
    

    %FAIP R2OS
    [lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.6);
    SA   = process_map(sHd{sample}.dSA,sROI{sample},lims_dir_SA,1);
    FAIP_meas = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);
    %Switch to sMR{sample}.FA instead of sMR{sample}.FAIP to see results
    %for FA instead.
    
    for i = 1:10
        [~,FAIP_test_set_measured,FAIP_test_set_predicted,~] = ...
            predict_map(SA,FAIP_meas,sROI{sample},1101);
        
        MSE_FAIP = calc_MSE(FAIP_test_set_measured,FAIP_test_set_predicted);
        MSE_FAIP_mean = calc_MSE(FAIP_test_set_measured,mean(FAIP_test_set_measured));
        
        R2OS_FAIP(sample,i) = calc_R2_from_MSE(MSE_FAIP,MSE_FAIP_mean);
        RR2OS_FAIP_CNN(sample,i) = calc_R2_from_MSE(MSE_FAIP,MSE_CNN);
        
    end
    
end



if (0) %R squared out-of-sample plot
    
    R2OOS = calc_R2OOS(median(MSE_CD,2),MSE_CNN');
    
    clf
    bar(1:16,R2OOS, 'BarWidth', 0.8); hold on
    ylim([-1 1])
    set(gca, 'XTick', [1:16])
    set(gca, 'YTick', [-1, -0.8, -0.6, -0.4, -0.2, 0,0.2,0.4,0.6,0.8,1.0])
    set(gca,'FontSize',20)
    set(gca,'box','off')
    ax = gca;
    ax.XAxis.LineWidth = 2;
    ax.YAxis.LineWidth = 2;
    set(ax,'tickdir','out');
    ax.XGrid = 'off';
    ax.YGrid = 'on';
    legend('R^2_{OOS} FA_{IP} prediction by SA vs by CNN','FontSize',10,'Location','southeast')
end



if (1) %What we had there previously
    clf
    %     subplot(3,1,1)
    %     hold on;
    %     title(sprintf('R^2 by definition, median: SA %0.2f CNN %0.2f',median(median(R2_FAIP_SA_test_bootstrap,2)), median(R2_FAIP_CNN_test)))
    %
    R2OS_CNN(R2OS_CNN<0) = 0;
    R2OS_CNN(isnan(R2OS_CNN)) = 0;
    
    bar(1:16,[median(R2OS_FAIP,2)';R2OS_CNN], 'BarWidth', 1.2); hold on;
    e = errorbar((1:16)-0.15,median(R2OS_FAIP,2)',iqr(R2OS_FAIP,2)/2);
    e.LineStyle = 'none';
    e.LineWidth = 1.5;
    e.Color = 'black';
    
    ylim([0 1])
    set(gca, 'XTick', [1:16])
    set(gca, 'YTick', [0,0.2,0.4,0.6,0.8,1.0])
    set(gca,'FontSize',20)
    set(gca,'box','off')
    ax = gca;
    ax.XAxis.LineWidth = 2;
    ax.YAxis.LineWidth = 2;
    set(ax,'tickdir','out');
    ax.XGrid = 'off';
    ax.YGrid = 'on';
    legend('SA','CNN','FontSize',10,'Location','northeast')
    
    
    qSA = quantile(median(R2OS_FAIP,2),3);
    fprintf('R2 SA intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(R2OS_FAIP,2)),qSA(1),qSA(3))
    
    qCNN = quantile(R2OS_CNN,3);
    fprintf('R2 CNN intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(R2OS_CNN),qCNN(1),qCNN(3))
    
    
    print(sprintf('R2_FAIP_FA_chart.png'),'-dpng','-r500')
    
    
end