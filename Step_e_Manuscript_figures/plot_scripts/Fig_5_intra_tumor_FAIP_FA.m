clear; clf; clc; load(fullfile('..','summary.mat'))
addpath('../M_functions')

for sample = 1:16
    
    disp(sample)
    
    dif_lims = 0.5;
    [lims_dir_FAIP, lims_dir_SA] = get_dir_lims(sample,0.6);
    
    SA   = process_map(sHd{sample}.dSA,sROI{sample},lims_dir_SA,1);
    FAIP_meas = process_map(sMR{sample}.FAIP,sROI{sample},lims_dir_FAIP,0);
    %Switch to sMR{sample}.FA instead of sMR{sample}.FAIP to see results
    %for FA instead.
    
    FAIP_pred_CNN = process_map(sFAIP_CNN{sample}.I_pred,sROI{sample},lims_dir_FAIP,0);
    
    for i = 1:1000
        [FAIP_pred,test_set_measured,test_set_predicted,test_set_usedforpred] = ...
            predict_map(SA,FAIP_meas,sROI{sample},sample,1101);
        
        R2_FAIP_SA_test_bootstrap(sample,i) = calc_R2(test_set_measured,test_set_predicted);
        MSE_CD(sample,i) = calc_MSE(test_set_measured,test_set_predicted);
    end
    
    R2_FAIP_CNN_test(sample) = calc_R2(FAIP_meas(sFAIP_CNN{sample}.test_ind == 1),FAIP_pred_CNN(sFAIP_CNN{sample}.test_ind == 1));
    MSE_CNN(sample) = calc_MSE(FAIP_meas(sFAIP_CNN{sample}.test_ind == 1),FAIP_pred_CNN(sFAIP_CNN{sample}.test_ind == 1));
end


if (1) %R squared out-of-sample plot
    
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



if (0) %What we had there previously
    
    R2_FAIP_CNN_test(R2_FAIP_CNN_test<0) = 0;
    R2_FAIP_CNN_test(isnan(R2_FAIP_CNN_test)) = 0;
    
    bar(1:16,[median(R2_FAIP_SA_test_bootstrap,2)';R2_FAIP_CNN_test], 'BarWidth', 1.2); hold on;
    e = errorbar((1:16)-0.15,median(R2_FAIP_SA_test_bootstrap,2)',iqr(R2_FAIP_SA_test_bootstrap,2)/2);
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
    
    
    qSA = quantile(median(R2_FAIP_SA_test_bootstrap,2),3);
    fprintf('R2 SA intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(R2_FAIP_SA_test_bootstrap,2)),qSA(1),qSA(3))
    
    qCNN = quantile(R2_FAIP_CNN_test,3);
    fprintf('R2 CNN intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(R2_FAIP_CNN_test),qCNN(1),qCNN(3))
    
    r = median(R2_FAIP_SA_test_bootstrap,2)' ./ R2_FAIP_CNN_test * 100;
    qr = quantile(r,3);
    fprintf('R2 SA/CNN ratio intra-tumor: %0.2f %% (%0.2f %% - %0.2f) %% (median (25th quartile - 75th quartile)), min %0.2f %%, max %0.2f %% \n',median(r), qr(1), qr(3), min(r), max(r))
    
    print(sprintf('R2_FAIP_FA_chart.png'),'-dpng','-r500')
    
    
end