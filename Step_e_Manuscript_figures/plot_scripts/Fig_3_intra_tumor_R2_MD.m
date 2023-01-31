clear; clc; load(fullfile('..','summary.mat'))
addpath('../M_functions')

for sample = 1:16
    
    disp(sample)
    
    %CNN part
    MSE_CNN      = calc_MSE(sMD_CNN{sample}.I_measured(sMD_CNN{sample}.I_test_ind==1),sMD_CNN{sample}.I_pred(sMD_CNN{sample}.I_test_ind==1));
    MSE_CNN_mean = calc_MSE(sMD_CNN{sample}.I_measured(sMD_CNN{sample}.I_test_ind==1),mean(sMD_CNN{sample}.I_measured(sMD_CNN{sample}.I_test_ind==1)));
    
    R2OS_CNN(sample) = calc_R2_from_MSE(MSE_CNN,MSE_CNN_mean);
    
    % CD part
    CD = process_map(sCD{sample},sROI{sample},1,1);
    MD_meas = process_map(sMR{sample}.MD,sROI{sample},1.5,0);
    for i = 1:1000
        [~,CD_test_set_measured,CD_test_set_predicted,~] =...
            predict_map(CD,MD_meas,sROI{sample},1101);
        
        MSE_CD = calc_MSE(CD_test_set_measured,CD_test_set_predicted);
        MSE_CD_mean = calc_MSE(CD_test_set_measured,mean(CD_test_set_measured));
        
        R2OS_CD(sample,i) = calc_R2_from_MSE(MSE_CD,MSE_CD_mean);
        RR2OS_CD_CNN(sample,i) = calc_R2_from_MSE(MSE_CD,MSE_CNN);
    end
    
end

R2OS_CNN(isnan(R2OS_CNN)) = 0;
R2OS_CNN(R2OS_CNN < 0) = 0;

if (1) %out-of-sample R squared plots, R2OS
    
    figure(123)
    clf
    
    bar(1:16,[median(R2OS_CD,2)';R2OS_CNN], 'BarWidth', 1.2); hold on
    e = errorbar((1:16)-0.15,median(R2OS_CD,2)',iqr(R2OS_CD,2)/2);
    
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
    
    qCD = quantile(median(R2OS_CD,2),3);
    fprintf('R2 CD intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(R2OS_CD,2)),qCD(1),qCD(3))
    
    qML = quantile(R2OS_CNN,3);
    fprintf('R2 CNN intra-tumor: %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(R2OS_CNN),qML(1),qML(3))
    
    print(sprintf('R2_MD_chart.png'),'-dpng','-r500')
end

if (1) %Relative out-of-sample R squared plot, RR2OS
    figure(124)
    clf
    
    bar(1:16,median(RR2OS_CD_CNN,2), 'BarWidth', 0.8); hold on
    e = errorbar((1:16),median(RR2OS_CD_CNN,2)',iqr(RR2OS_CD_CNN,2)/2);
    
    e.LineStyle = 'none';
    e.LineWidth = 1.5;
    e.Color = 'black';
    
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
    legend('RR^2_{OS} MD','FontSize',10,'Location','southwest')
    
    qRR2OS = quantile(median(RR2OS_CD_CNN,2),3);
    fprintf('RR2OS : %0.2f (%0.2f - %0.2f) (median (25th quartile - 75th quartile))\n',median(median(RR2OS_CD_CNN,2)),qRR2OS(1),qRR2OS(3))
    
    sum(median(RR2OS_CD_CNN,2) <= 0)
    
    print(sprintf('RR2OS_MD_chart.png'),'-dpng','-r500')
end

