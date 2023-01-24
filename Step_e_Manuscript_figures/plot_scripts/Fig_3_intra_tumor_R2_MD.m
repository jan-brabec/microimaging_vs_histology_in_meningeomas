clear; clc; load(fullfile('..','summary.mat'))
addpath('../M_functions')

for sample = 1:16
    
    disp(sample)
    
    MD_lims = 1.5;
    CD_lims = 1.0;
    
    CD = process_map(sCD{sample},sROI{sample},CD_lims,1);
    MD_meas = process_map(sMR{sample}.MD,sROI{sample},MD_lims,0);
    
    MD_pred_CNN = process_map(sMD_CNN{sample}.I_MD_pred,sROI{sample},MD_lims,0);
    
    for i = 1:10
        [MD_pred_CD,test_set_measured,test_set_predicted,test_set_usedforpred] =...
            predict_map(CD,MD_meas,sROI{sample},1101);
        
        R2_MD_CD_test_bootstrap(sample,i) = calc_R2(test_set_measured,test_set_predicted);
        MSE_CD(sample,i) = calc_MSE(test_set_measured,test_set_predicted);
        
    end
    
    R2_MD_CNN_test(sample) = calc_R2(MD_meas(sMD_CNN{sample}.test_ind == 1),MD_pred_CNN(sMD_CNN{sample}.test_ind == 1));
    MSE_CNN(sample) = calc_MSE(MD_meas(sMD_CNN{sample}.test_ind == 1),MD_pred_CNN(sMD_CNN{sample}.test_ind == 1));
    
end




if (1)
    clf
    R2OOS = calc_R2OOS(median(MSE_CD,2),MSE_CNN');
    
    bar(1:16,[median(R2_MD_CD_test_bootstrap,2)';R2OOS'], 'BarWidth', 1.2); hold on
    e = errorbar((1:16)-0.15,median(R2_MD_CD_test_bootstrap,2)',iqr(R2_MD_CD_test_bootstrap,2)/2);
    
    e.LineStyle = 'none';
    e.LineWidth = 1.5;
    e.Color = 'black';
    
    ylim([-0.7 0.7])
    set(gca, 'XTick', [1:16])
    set(gca, 'YTick', [-0.6 -0.4, -0.2, 0, 0.2, 0.4, 0.6])
    set(gca,'FontSize',20)
    set(gca,'box','off')
    ax = gca;
    ax.XAxis.LineWidth = 2;
    ax.YAxis.LineWidth = 2;
    set(ax,'tickdir','out');
    ax.XGrid = 'off';
    ax.YGrid = 'on';
    legend('R^2 CD','R^2_{OOS} CD vs CNN','FontSize',10,'Location','southwest')
    
    qCD = quantile(median(R2_MD_CD_test_bootstrap,2),3);
    fprintf('R2 CD intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(R2_MD_CD_test_bootstrap,2)),qCD(1),qCD(3))
    

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
    legend('R^2_{OOS} MD prediction by CD vs by CNN','FontSize',10,'Location','northeast')
end

if (0) %What we had previously
    clf
    %     subplot(3,1,3)
    %     hold on;
    %     title(sprintf('Correlation coefficient squared, median: CD %0.2f CNN %0.2f',median(median(R2_MD_CD_test_bootstrap,2)), median(R2_MD_CNN_test)))
    %
    R2_MD_CNN_test(isnan(R2_MD_CNN_test)) = 0;
        
    bar(1:16,[median(R2_MD_CD_test_bootstrap,2)';R2_MD_CNN_test], 'BarWidth', 1.2); hold on
    e = errorbar((1:16)-0.15,median(R2_MD_CD_test_bootstrap,2)',iqr(R2_MD_CD_test_bootstrap,2)/2);
    
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
    legend('CD','CNN','FontSize',10,'Location','northeast')
    
    
    qCD = quantile(median(R2_MD_CD_test_bootstrap,2),3);
    fprintf('R2 CD intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(R2_MD_CD_test_bootstrap,2)),qCD(1),qCD(3))
    
    qML = quantile(R2_MD_CNN_test,3);
    fprintf('R2 CNN intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(R2_MD_CNN_test),qML(1),qML(3))
    
    r = median(R2_MD_CD_test_bootstrap,2)' ./ R2_MD_CNN_test * 100;
    qr = quantile(r,3);
    fprintf('R2 CD/CNN ratio intra-tumor: %0.2f %% (%0.2f %% - %0.2f) %% (median (25th quartile - 75th quartile)), min %0.2f %%, max %0.2f %% \n',median(r), qr(1), qr(3), min(r), max(r))
    
    print(sprintf('R2_MD_chart.png'),'-dpng','-r500')
end

